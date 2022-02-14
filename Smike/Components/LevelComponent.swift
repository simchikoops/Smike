import SpriteKit
import GameplayKit

class LevelComponent: GKComponent {
  @GKInspectable var mortalAllowance: Int = 0
  
  override class var supportsSecureCoding: Bool {
    true
  }
}
