import SpriteKit
import GameplayKit

class PauseButtonComponent: GKComponent, Tappable {
  override class var supportsSecureCoding: Bool {
    true
  }

  func isTappedAt(scenePoint: CGPoint) -> Bool {
    return true
  }
  
  func tapped() {
    if let scene = entity?.scene {
      scene.isPaused = !scene.isPaused
      scene.lastUpdateTime = 0
      
      entity?.spriteNode.texture = SKTexture(imageNamed: (scene.isPaused ? "play" : "pause"))
    }
  }
}
