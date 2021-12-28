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
    entity!.scene.mortals.remove(object: entity!)
    // TODO: check scene completion
    entity!.remove()
  }
}
