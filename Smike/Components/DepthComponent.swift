import SpriteKit
import GameplayKit

class DepthComponent: GKComponent {
    @GKInspectable var depth: CGFloat = 0.0
    
    override class var supportsSecureCoding: Bool {
      true
    }
}
