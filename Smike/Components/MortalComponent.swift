import SpriteKit
import GameplayKit

class MortalComponent: GKComponent {
  @GKInspectable var seq: Int = 0
  @GKInspectable var isMale: Bool = true

  override class var supportsSecureCoding: Bool {
    true
  }
  
  func kill() {
    entity?.scene.checkWhetherDefeated()
    entity?.remove()
  }
}
