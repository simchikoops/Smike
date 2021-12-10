import SpriteKit

extension SKSpriteNode {
  var depth: CGFloat {
    get {
      return 1 - yScale
    }
    set(newValue) {
      self.yScale = 1 - newValue
      self.xScale = (1 - newValue) * (xScale < 0 ? -1 : 1)
    }
  }
}
