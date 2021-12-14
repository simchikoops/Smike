import SpriteKit

class Slot {
  static var live = Slot()
  
  var heroStats: [HeroType: [String: CGFloat]] = [:]
  
  init() {
    let samuraiStats = ["speed": CGFloat(0.08)]
    heroStats[.samurai] = samuraiStats
  }
}
