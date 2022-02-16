import SpriteKit

typealias CoinValues = (imageName: String, power: Int, pinches: Int, swipes: Int)

let bronzeMonValues: CoinValues = (imageName: "bat", power: 100, pinches: 0, swipes: 0)

enum CoinType: Int {
  case bronzeMon = 1
  
  var values: CoinValues {
    switch self {
    case .bronzeMon: return bronzeMonValues
    }
  }
  
  var imageName: String { values.imageName }
  var power: Int { values.power }
  var pinches: Int { values.pinches }
  var swipes: Int { values.swipes }
}
