import Foundation
import SpriteKit

extension Comparable {
  func clamped(to limits: ClosedRange<Self>) -> Self {
    return min(max(self, limits.lowerBound), limits.upperBound)
  }
}

extension Array where Element: Equatable {
  // Remove first collection element that is equal to the given `object`:
  mutating func remove(object: Element) {
    guard let index = firstIndex(of: object) else { return }
    remove(at: index)
  }
}

extension CGPoint {
  func distance(to other: CGPoint) -> CGFloat {
    return hypot(other.x - self.x, other.y - self.y)
  }
}

extension Int {
  func toRadians() -> CGFloat {
    return CGFloat(self) * .pi / 180
  }
}

extension CGFloat {
  func toDegrees() -> Int {
    return Int(self * 180 / .pi)
  }
}
