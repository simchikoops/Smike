import SpriteKit

typealias DemonValues = (imageName: String, frameCount: Int, timePerFrame: Double)

let batValues: DemonValues = (imageName: "bat", frameCount: 1, timePerFrame: 0)
let devilValues: DemonValues = (imageName: "devil", frameCount: 1, timePerFrame: 0)
let ghostValues: DemonValues = (imageName: "ghost", frameCount: 4, timePerFrame: 0.25)

enum DemonType: Int {
  case bat = 1
  case devil = 2
  case ghost = 3
  
  var values: DemonValues {
    switch self {
    case .bat: return batValues
    case .devil: return devilValues
    case .ghost: return ghostValues
    }
  }
  
  var imageName: String { values.imageName }
  var frameCount: Int { values.frameCount }
  var timePerFrame: Double { values.timePerFrame }
}
