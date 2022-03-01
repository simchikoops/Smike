import SpriteKit

typealias RailValues = (restitution: CGFloat, friction: CGFloat) // TODO: impact sound

let soilValues: RailValues = (restitution: 0.2, friction: 0.8)
let rockValues: RailValues = (restitution: 0.5, friction: 0.2)

enum RailType: Int {
  case rock = 1
  case soil = 2
  
  var values: RailValues {
    switch self {
    case .rock: return rockValues
    case .soil: return soilValues
    }
  }
  
  var restitution: CGFloat { values.restitution }
  var friction: CGFloat { values.friction }
}
