import SpriteKit
import GameplayKit

class MortalComponent: GKComponent {
  override class var supportsSecureCoding: Bool {
    true
  }
  
  func kill() {
    entity?.scene.checkWhetherDefeated()
    entity?.remove()
  }
}
