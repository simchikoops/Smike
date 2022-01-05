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
  
  func damage(points: Int) {
    hp -= points

    if hp <= 0 {
      if let component = entity?.component(ofType: HeroComponent.self) {
        component.impair()
      } else if let component = entity?.component(ofType: DemonComponent.self) {
        component.dispell()
      } else if let component = entity?.component(ofType: MortalComponent.self)  {
        component.die()
      }
    } else {
      // TODO: flash
    }
  }
}
