import SpriteKit
import GameplayKit

class TrackDotComponent: GKComponent {
  @GKInspectable var seq: Int = 0
  @GKInspectable var depth: CGFloat = 0.0
  @GKInspectable var relativeSpeed: CGFloat = 1.0
  
  override class var supportsSecureCoding: Bool {
    true
  }
}
