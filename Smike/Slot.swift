import SpriteKit

class Slot {
  static var live = Slot()
  
  var heroStats: [HeroType: [String: CGFloat]] = [:]
  
  init() {
    let samuraiStats = ["speed": CGFloat(15.0)]
    heroStats[.samurai] = samuraiStats
  }
}
