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
  
  var facing: FacingDirection {
    get {
      return xScale >= 0 ? .right : .left // by convention
    }
    set(newValue) {
      if (self.facing == .right && newValue == .left) || (self.facing == .left && newValue == .right) {
        self.xScale *= -1
      }
    }
  }
  
  var layer: CGFloat {
    return zPosition
  }
}
