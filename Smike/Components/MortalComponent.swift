import SpriteKit
import GameplayKit

class MortalComponent: GKComponent {
  @GKInspectable var seq: Int = 0
  @GKInspectable var isMale: Bool = true

  override class var supportsSecureCoding: Bool {
    true
  }
  
  override func didAddToEntity() {
    if let scene = entity?.scene {
      scene.mortals.append(entity!)
    }
  }
  
  func kill() {
    entity?.scene.checkWhetherDefeated()
    entity?.remove()
  }
}
