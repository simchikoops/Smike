import SpriteKit
import GameplayKit

class MortalComponent: GKComponent {
  @GKInspectable var seq: Int = 0
  @GKInspectable var isMale: Bool = true
  
  var dying: Bool = false

  override class var supportsSecureCoding: Bool {
    true
  }
  
  override func didAddToEntity() {
    if let scene = entity?.scene {
      scene.mortals.append(entity!)
    }
  }
  
  // Coordinate with kill animation.
  func kill() {
    self.dying = true // to avoid double vicitimization & ensure full animations
    guard let node = entity?.node as? SKSpriteNode, let scene = entity?.scene else { return }

    let deathSequence = SKAction.sequence([
      SKAction.colorize(with: .red, colorBlendFactor: 1.0, duration: 0.15),
      SKAction.wait(forDuration: 0.1),
      SKAction.colorize(withColorBlendFactor: 0.0, duration: 0.15)
    ])
    
    node.run(SKAction.sequence([
      SKAction.wait(forDuration: 1.0),
      deathSequence,
      SKAction.run {
        scene.mortals.remove(object: self.entity!)
        self.entity!.remove()
        scene.checkForLoss()
      }
    ]))
  }
}
