import SpriteKit
import GameplayKit

class LoopComponent: GKComponent {
  @GKInspectable var duration: CGFloat = 0.0
  
  var track: Track?
  
  var baseDepth: CGFloat? {
    track?.dots.first?.depth
  }

  override class var supportsSecureCoding: Bool {
    true
  }
  
  override func didAddToEntity() {
    track = Track.fromNodes(headNode: entity!.node, loop: true)
  }
}
