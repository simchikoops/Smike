import SpriteKit
import GameplayKit

enum DemonType: Int {
  case bat = 1
  
  var imageName: String {
    switch self {
    case .bat: return "bat"
    }
  }

}

class DemonComponent: GKComponent {

}
