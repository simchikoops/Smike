import SpriteKit
import GameKit

class DemonEntity: GKEntity {
  init(type: DemonType, track: Track, originNode: SKNode) {
    super.init()
    
    let demonComponent = DemonComponent(type: type, track: track)
    addComponent(demonComponent)
    
    let dot = track.dotAlong(0)
    let renderComponent = RenderComponent(imageNamed: type.imageName, position: dot.position, depth: dot.depth, layer: dot.layer)
    
    addComponent(renderComponent)
    
    if let node = self.node as? SKSpriteNode {
      let physicsBody = SKPhysicsBody(rectangleOf: node.size)
      print("demon size", node.size)

      physicsBody.affectedByGravity = false
      physicsBody.allowsRotation = false
      physicsBody.isDynamic = true // just about the contacts

      physicsBody.categoryBitMask = 15 //PhysicsInfo.demon.categoryBitMask
      physicsBody.contactTestBitMask = 15 //PhysicsInfo.demon.contactTestBitMask
      physicsBody.collisionBitMask = 15 //PhysicsInfo.demon.contactTestBitMask
      node.physicsBody = physicsBody
    }
    
    originNode.parent!.addChild(node)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
