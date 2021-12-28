import SpriteKit

typealias DemonValues = (imageName: String, speed: CGFloat, hp: Int, attackRange: CGFloat, attackAngle: ClosedRange<Int>, minimumAttackInterval: CGFloat)

let batValues: DemonValues = (imageName: "bat", speed: 75, hp: 20, attackRange: 200, attackAngle: 320...350, minimumAttackInterval: 4.0)
let devilValues: DemonValues = (imageName: "devil", speed: 15, hp: 100, attackRange: 90, attackAngle: 300...370, minimumAttackInterval: 2.0)

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
  
  var attackRange: CGFloat { values.attackRange }
  var attackAngle: ClosedRange<Int> { values.attackAngle }
  var minimumAttackInterval: CGFloat { values.minimumAttackInterval }
}
