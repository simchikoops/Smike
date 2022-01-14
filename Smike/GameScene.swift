import SpriteKit
import GameplayKit

class GameScene: SKScene {
  func presentMessage(_ text: String) {
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
    
    label.zPosition = Layer.dash.rawValue
    label.text = text
    
    addChild(label)
  }
}
