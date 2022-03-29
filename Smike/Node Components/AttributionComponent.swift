import SpriteKit
import GameplayKit

class AttributionComponent: GKComponent {
    @GKInspectable var title: String = ""
    @GKInspectable var artist: String = ""
    @GKInspectable var year: Int = -1
    @GKInspectable var url: String = ""
    
    override class var supportsSecureCoding: Bool {
      true
    }
}
