import SpriteKit
import GameplayKit

class RenderComponent: GKComponent {
  
  var spriteNode: SKSpriteNode?
  
  init(node: SKSpriteNode) {
    super.init()
    spriteNode = node
  }
  
  init(imageNamed: String, position: CGPoint, depth: CGFloat) {
    super.init()
    
    spriteNode = SKSpriteNode(imageNamed: imageNamed)
    spriteNode?.depth = depth
    spriteNode?.position = position
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
