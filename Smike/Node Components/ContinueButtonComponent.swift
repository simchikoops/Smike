import SpriteKit
import GameplayKit

class ContinueButtonComponent: GKComponent, Tappable {
  override class var supportsSecureCoding: Bool {
    true
  }

  func isTappedAt(scenePoint: CGPoint) -> Bool {
    return true
  }
  
  func tapped() {
    entity?.scene.entity?.component(conformingTo: Continuable.self)?.doContinue()
  }
}
