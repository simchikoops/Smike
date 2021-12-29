import SpriteKit
import GameplayKit

class HealthComponent: GKComponent {
  @GKInspectable var hp: Int = 0

  override class var supportsSecureCoding: Bool {
    true
  }
  
  func damage(points: Int) {
    hp -= points
    
    if let component = entity?.component(ofType: HeroComponent.self) {
      component.takeDamage(points)
    } else {
      if hp <= 0 {
        if let component = entity?.component(ofType: DemonComponent.self) {
          component.dispell()
        } else if let component = entity?.component(ofType: MortalComponent.self)  {
          component.die()
        }
      } else {
        // TODO: flash
      }
    }
  }
}
