import SpriteKit
import GameplayKit

typealias HeroValues = (imageName: String, attack: AttackType, attackPower: Int, attackDisplay: String, attackSpeed: CGFloat?, minimumAttackInterval: CGFloat)

let samuraiValues: HeroValues = (imageName: "samurai", attack: .thrust, attackPower: 20, attackDisplay: "none", attackSpeed: nil, minimumAttackInterval: 1.0)
let woodpeckerValues: HeroValues = (imageName: "woodpecker", attack: .missile, attackPower: 10, attackDisplay: "beak", attackSpeed: 50.0, minimumAttackInterval: 0.7)

enum AttackType {
  case missile
  case thrust
}

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
  
  var attack: AttackType { values.attack }
  var attackPower: Int { values.attackPower }
  var attackSpeed: CGFloat? { values.attackSpeed }
  var attackDisplay: String { values.attackDisplay }
  var minimumAttackInterval: CGFloat { values.minimumAttackInterval }
}
