import SpriteKit
import GameplayKit

class PathComponent: GKComponent {
  @GKInspectable var duration: CGFloat = 0.0
  @GKInspectable var isLoop: Bool = false
  @GKInspectable var removeWhenFinished: Bool = false

  var track: Track?
  
  var baseDepth: CGFloat? {
    track?.dots.first?.depth
  }

  override class var supportsSecureCoding: Bool {
    true
  }
  
  override func didAddToEntity() {
    track = Track.fromNodes(headNode: entity!.node, loop: isLoop)
  }
}
