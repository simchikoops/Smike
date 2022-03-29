import SpriteKit
import GameplayKit

class TutorialComponent: GKComponent, Continuable {
  var step: Int = 0
  
  override class var supportsSecureCoding: Bool {
    true
  }
  
  override func didAddToEntity() {
    guard let scene = entity?.scene else { return }
    guard let print = scene["print"].first as? SKSpriteNode else { return }

    if let message = print["message"].first as? SKLabelNode {
      message.fontName = "aAsianNinja"
      message.fontSize = 105
    }
    
//    if let buttonText = print["//button_text"].first as? SKLabelNode {
//      buttonText.fontName = "aAsianNinja"
//      buttonText.fontSize = 50
//    }
        
    nextStep()
  }
  
  func doContinue() {
    nextStep()
  }
  
  func nextStep() {
    self.step += 1
    
    switch step {
    case 1: showTextAndButton(text: "Strike demons just before they can see vulnerable mortals",
                              button: "Try Now")
    default: assert(false, "Unknown step \(step)")
    }
  }
  
  func showTextAndButton(text: String, button: String) {
    guard let message = entity?.scene["//message"].first as? SKLabelNode else { return }
    guard let buttonText = entity?.scene["//button_text"].first as? SKLabelNode else { return }
    
    message.text = text
    buttonText.text = button
    
    
  }
}
