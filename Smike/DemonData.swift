import SpriteKit

typealias DemonValues = (imageName: String, speed: CGFloat, hp: Int, attackRange: CGFloat, minimumAttackInterval: CGFloat)

let batValues: DemonValues = (imageName: "bat", speed: 75, hp: 20, attackRange: 200, minimumAttackInterval: 4.0)
let devilValues: DemonValues = (imageName: "devil", speed: 15, hp: 100, attackRange: 90, minimumAttackInterval: 2.0)

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
  var minimumAttackInterval: CGFloat { values.minimumAttackInterval }
}
