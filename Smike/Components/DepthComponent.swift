import SpriteKit
import GameplayKit

class DepthComponent: GKComponent {
  @GKInspectable var depth: CGFloat = 0.0
  @GKInspectable var layer: CGFloat = Layer.normal.rawValue

  override class var supportsSecureCoding: Bool {
    true
  }
}
