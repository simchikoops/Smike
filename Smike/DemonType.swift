import SpriteKit

typealias DemonValues = (imageName: String, frameCount: Int, timePerFrame: Double, entranceImageName: String?, entranceFrameCount: Int, entranceTimePerFrame: Double)

let batValues: DemonValues = (imageName: "bat", frameCount: 1, timePerFrame: 0, entranceImageName: nil, entranceFrameCount: 0, entranceTimePerFrame: 0.0)
let devilValues: DemonValues = (imageName: "devil", frameCount: 1, timePerFrame: 0.0, entranceImageName: "devil_dirt", entranceFrameCount: 5, entranceTimePerFrame: 0.2)
let ghostValues: DemonValues = (imageName: "ghost", frameCount: 4, timePerFrame: 0.1, entranceImageName: nil, entranceFrameCount: 0, entranceTimePerFrame: 0.0)

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
  
  var entranceImageName: String? { values.entranceImageName }
  var entranceFrameCount: Int { values.entranceFrameCount }
  var entranceTimePerFrame: Double { values.entranceTimePerFrame }
}
