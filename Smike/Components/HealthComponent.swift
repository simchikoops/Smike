import SpriteKit
import GameplayKit

class HealthComponent: GKComponent {
  @GKInspectable var maxHp: Int = 0
  var hp: Int = 0

  override class var supportsSecureCoding: Bool {
    true
  }
  
  override func didAddToEntity() {
    self.hp = maxHp
  }
  
  func showDamage(color: UIColor = .red) {
    guard let node = entity?.node as? SKSpriteNode else { return }
      
    let pulsedRed = SKAction.sequence([
      SKAction.colorize(with: color, colorBlendFactor: 1.0, duration: 0.15),
      SKAction.wait(forDuration: 0.1),
      SKAction.colorize(withColorBlendFactor: 0.0, duration: 0.15)])
    
    node.run(pulsedRed)
  }
  
  func damage(points: Int) {
    guard hp > 0 else { return } // beyond damage
    hp -= points
    
    if let body = entity?.component(conformingTo: Body.self) {
      if hp <= 0 {
        body.kill()
      } else {
        body.damage()
      }      
    }
  }
}
