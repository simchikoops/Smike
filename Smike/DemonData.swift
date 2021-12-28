import SpriteKit

typealias DemonValues = (imageName: String, speed: CGFloat, hp: Int, attack: AttackType, attackImage: String?, attackRange: CGFloat, attackAngle: ClosedRange<Int>, attackPower: Int, minimumAttackInterval: CGFloat)

let batValues: DemonValues = (imageName: "bat", speed: 75, hp: 20, attack: .missile, attackImage: "knife", attackRange: 500, attackAngle: 320...350, attackPower: 5, minimumAttackInterval: 4.0)
let devilValues: DemonValues = (imageName: "devil", speed: 15, hp: 100, attack: .thrust, attackImage: nil, attackRange: 90, attackAngle: 300...390, attackPower: 20, minimumAttackInterval: 2.0)

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
  var attackPower: Int { values.attackPower }
  
  var minimumAttackInterval: CGFloat { values.minimumAttackInterval }
}
