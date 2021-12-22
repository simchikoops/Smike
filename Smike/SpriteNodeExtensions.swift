import SpriteKit

enum FacingDirection {
  case left
  case right
}

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
    return xScale >= 0 ? .right : .left // by convention
  }
  
  var layer: CGFloat {
    return zPosition
  }
}
