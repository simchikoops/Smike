import SpriteKit
import GameplayKit

class NodeComponent: GKComponent {
  
  var spriteNode: SKSpriteNode?
  
  init(node: SKSpriteNode) {
    super.init()
    spriteNode = node
  }
  
  init(imageNamed: String, position: CGPoint, depth: CGFloat, layer: CGFloat, facing: FacingDirection = .right) {
    super.init()
    
    spriteNode = SKSpriteNode(imageNamed: imageNamed)
    spriteNode?.depth = depth
    spriteNode?.position = position
    spriteNode?.zPosition = layer
    spriteNode?.facing = facing
  }
  
  override func didAddToEntity() {
    spriteNode?.entity = entity
  }
  
  required init?(coder: NSCoder) {
    super.init(coder:coder)
  }
  
  override class var supportsSecureCoding: Bool {
    true
  }
}
