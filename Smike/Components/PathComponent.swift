import SpriteKit
import GameplayKit

enum PathType: Int {
  case simple = 1  // stop at end
  case terminal = 2 // remove at end
  case loop = 3 // connect end to beginning
  case jump = 4 // instantaneously from end to beginning
}

class PathComponent: GKComponent {
  @GKInspectable var duration: CGFloat = 0.0
  @GKInspectable var rawType: Int = 1

  var track: Track?
  var type: PathType = .simple
  
  var baseDepth: CGFloat? {
    track?.dots.first?.depth
  }

  override class var supportsSecureCoding: Bool {
    true
  }
  
  override func didAddToEntity() {
    type = PathType(rawValue: rawType)!
    print(type)
    track = Track.fromNodes(headNode: entity!.node, loop: type == .loop)
  }
}
