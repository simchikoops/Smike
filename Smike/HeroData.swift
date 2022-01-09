import SpriteKit
import GameplayKit

typealias HeroValues = (imageName: String, attack: AttackType, attackPower: Int, attackDisplay: String, attackOrigin: CGPoint, attackSize: CGSize?, attackSpeed: CGFloat?, minimumAttackInterval: CGFloat)

let samuraiValues: HeroValues = (imageName: "samurai", attack: .stab, attackPower: 20, attackDisplay: "none", attackOrigin: CGPoint(x: 40, y: 10), attackSize: CGSize(width: 80, height: 40), attackSpeed: nil, minimumAttackInterval: 1.0)

let woodpeckerValues: HeroValues = (imageName: "woodpecker", attack: .missile, attackPower: 10, attackDisplay: "beak", attackOrigin: CGPoint(x: 70, y: 50), attackSize: nil, attackSpeed: 100.0, minimumAttackInterval: 0.7)

enum AttackType {
  case missile
  case stab
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
  var attackSize: CGSize? { values.attackSize }
  var attackOrigin: CGPoint { values.attackOrigin }
  var minimumAttackInterval: CGFloat { values.minimumAttackInterval }
}
