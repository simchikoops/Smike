import SpriteKit

protocol Tappable {
  func isTappedAt(scenePoint: CGPoint) -> Bool
  func tapped()
}
