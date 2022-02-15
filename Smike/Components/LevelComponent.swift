import SpriteKit
import GameplayKit

class LevelComponent: GKComponent {
  @GKInspectable var mortalAllowance: Int = 0
  @GKInspectable var startingAttackPower: Int = 0
  
  override class var supportsSecureCoding: Bool {
    true
  }
}
