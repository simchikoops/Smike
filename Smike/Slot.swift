import SpriteKit

class Slot {
  static var live = Slot()
  
  var heroStats: [HeroType: [String: CGFloat]] = [:]
  
  init() {
    let samuraiStats = ["speed": CGFloat(25.0)]
    heroStats[.samurai] = samuraiStats
    
    let woodpeckerStats = ["speed": CGFloat(35.0)]
    heroStats[.woodpecker] = woodpeckerStats
  }
}
