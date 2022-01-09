import SpriteKit

typealias DemonValues = (imageName: String, speed: CGFloat, hp: Int, attack: AttackType, attackImage: String?, attackRange: CGFloat, attackAngle: ClosedRange<Int>, attackOrigin: CGPoint, attackPower: Int, attackSpeed: CGFloat?, minimumAttackInterval: CGFloat)

let batValues: DemonValues = (imageName: "bat", speed: 75, hp: 20, attack: .missile, attackImage: "knife", attackRange: 500, attackAngle: 320...350, attackOrigin: CGPoint(x: 120, y: 75), attackPower: 5, attackSpeed: 175, minimumAttackInterval: 1.0)
let devilValues: DemonValues = (imageName: "devil", speed: 15, hp: 100, attack: .stab, attackImage: nil, attackRange: 200, attackAngle: 300...390, attackOrigin: CGPoint(x: 130, y: 100), attackPower: 20, attackSpeed: nil, minimumAttackInterval: 2.0)

enum DemonType: Int {
  case bat = 1
  case devil = 2
  
  var values: DemonValues {
    switch self {
    case .bat: return batValues
    case .devil: return devilValues
    }
  }
  
  var imageName: String { values.imageName }
  var speed: CGFloat { values.speed }
  var hp: Int { values.hp }
  
  var attack: AttackType { values.attack }
  var attackImage: String? { values.attackImage }
  
  var attackRange: CGFloat { values.attackRange }
  var attackAngle: ClosedRange<Int> { values.attackAngle }
  var attackOrigin: CGPoint { values.attackOrigin }
  
  var attackPower: Int { values.attackPower }
  var attackSpeed: CGFloat? { values.attackSpeed }
  
  var minimumAttackInterval: CGFloat { values.minimumAttackInterval }
}
