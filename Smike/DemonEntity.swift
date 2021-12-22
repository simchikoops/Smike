import SpriteKit
import GameKit

class DemonEntity: GKEntity {
  init(type: DemonType, track: Track, originNode: SKNode) {
    super.init()
    
    let dot = track.dotAlong(0)
    let renderComponent = NodeComponent(imageNamed: type.imageName, position: dot.position, depth: dot.depth, layer: dot.layer)
    
    addComponent(renderComponent)
    
    if let node = self.node as? SKSpriteNode {
      let physicsBody = SKPhysicsBody(rectangleOf: node.size)

      physicsBody.affectedByGravity = false
      physicsBody.allowsRotation = false
      physicsBody.isDynamic = false // alow overlaps

      physicsBody.categoryBitMask = PhysicsInfo.demon.categoryBitMask
      physicsBody.contactTestBitMask = PhysicsInfo.demon.contactTestBitMask

      node.physicsBody = physicsBody
    }
    
    let demonComponent = DemonComponent(type: type, track: track)
    addComponent(demonComponent)
    
    originNode.parent!.addChild(node)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
