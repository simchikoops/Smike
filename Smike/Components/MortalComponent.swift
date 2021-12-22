import SpriteKit
import GameplayKit

class MortalComponent: GKComponent {
  override class var supportsSecureCoding: Bool {
    true
  }
  
  override func didAddToEntity() {
    if let scene = entity?.scene {
      scene.mortals.append(entity!)
    }
  }

  func die() {
    
  }
}
