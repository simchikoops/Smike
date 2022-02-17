import SpriteKit
import GameplayKit

class GameScene: SKScene {
  static var random = GKRandomSource()
  var entities = [GKEntity]()
    
  func messageLabel(_ text: String) -> SKLabelNode {
    let margin: CGFloat = 20.0
    let label = SKLabelNode()
    
    label.fontName = "aAsianNinja"
    label.fontSize = 105
    label.fontColor = .black
    
    label.position = CGPoint(x: viewRight / 2, y: viewTop / 2)
    
    label.horizontalAlignmentMode = .center
    label.verticalAlignmentMode = .center
    
    label.lineBreakMode = NSLineBreakMode.byWordWrapping
    label.numberOfLines = 0
    label.preferredMaxLayoutWidth = viewRight - margin * 2
    
    label.zPosition = Layer.dash.rawValue + 10000
    label.text = text
    
    return label
  }
  
  func titleCard(_ text: String, duration: CGFloat = 3.0, block: @escaping () -> Void) {
    let label = messageLabel(text)
    addChild(label)
    
    run(SKAction.sequence([SKAction.wait(forDuration: duration),
                           SKAction.run { label.removeFromParent(); block() }]))
  }
}
