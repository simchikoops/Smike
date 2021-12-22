import SpriteKit
import GameplayKit

class HealthComponent: GKComponent {
  @GKInspectable var hp: Int = 0

  override class var supportsSecureCoding: Bool {
    true
  }
  
  func damage(points: Int) {
    print("DAMAGE \(points)")
  }
}
