import SpriteKit
import GameplayKit

class CoinComponent: GKComponent {
  var type: CoinType
  var startingPosition: CGPoint
  var layer: CGFloat
    
  init(type: CoinType, startingPosition: CGPoint, layer: CGFloat) {
    self.type = type
    self.startingPosition = startingPosition
    self.layer = layer
    
    super.init()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override class var supportsSecureCoding: Bool {
    true
  }
  
  override func didAddToEntity() {
    let nodeComponent = NodeComponent(imageNamed: type.imageName, position: startingPosition, depth: 0.0, layer: layer)
    
    entity!.addComponent(nodeComponent)
    let node = entity!.node
    
    let physicsBody = SKPhysicsBody(circleOfRadius: node.frame.width / 2)
    
    physicsBody.isDynamic = true
    physicsBody.affectedByGravity = true
    physicsBody.allowsRotation = true
    physicsBody.mass = 0.005 // kg
    
    node.physicsBody = physicsBody
  }
}
