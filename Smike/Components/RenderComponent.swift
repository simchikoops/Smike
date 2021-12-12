import SpriteKit
import GameplayKit

class RenderComponent: GKComponent {
  
  var spriteNode: SKSpriteNode?
  
  init(node: SKSpriteNode) {
    super.init()
    spriteNode = node
  }
  
  init(imageNamed: String, position: CGPoint, depth: CGFloat, layer: CGFloat) {
    super.init()
    
    spriteNode = SKSpriteNode(imageNamed: imageNamed)
    spriteNode?.depth = depth
    spriteNode?.position = position
    spriteNode?.zPosition = layer
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
