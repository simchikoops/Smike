import SpriteKit
import GameplayKit

typealias HeroValues = (imageName: String, minimumAttackInterval: CGFloat)

let samuraiValues: HeroValues = (imageName: "samurai", minimumAttackInterval: 1.0)
let woodpeckerValues: HeroValues = (imageName: "woodpecker", minimumAttackInterval: 0.7)

enum HeroType: String {
  case samurai
  case woodpecker
  
  var values: HeroValues {
    switch self {
    case .samurai: return samuraiValues
    case .woodpecker: return woodpeckerValues
    }
  }
  
  var imageName: String { values.imageName }
  var minimumAttackInterval: CGFloat { values.minimumAttackInterval }
}
