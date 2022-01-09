import SpriteKit
import GameplayKit

class NodeComponent: GKComponent {
  var node: SKNode
  
  init(node: SKSpriteNode) {
    self.node = node
    super.init()
  }
  
  init(imageNamed: String, position: CGPoint, depth: CGFloat, layer: CGFloat, facing: FacingDirection = .right) {
    let spriteNode = SKSpriteNode(imageNamed: imageNamed)
    
    spriteNode.depth = depth
    spriteNode.position = position
    spriteNode.zPosition = layer
    spriteNode.facing = facing
    
    self.node = spriteNode
    
    super.init()
  }
  
  init(size: CGSize) {
    self.node = SKShapeNode(rectOf: size)
    super.init()
  }
  
  override func didAddToEntity() {
    node.entity = entity
  }
  
  required init?(coder: NSCoder) {
    self.node = SKNode()
    super.init(coder:coder)
  }
  
  override class var supportsSecureCoding: Bool {
    true
  }
}
