import Foundation
import SpriteKit

extension Comparable {
  func clamped(to limits: ClosedRange<Self>) -> Self {
    return min(max(self, limits.lowerBound), limits.upperBound)
  }
}

enum FacingDirection {
  case left
  case right
}

extension SKNode {
  var facing: FacingDirection {
    return xScale >= 0 ? .right : .left // by convention
  }
}
