import SpriteKit

extension LevelScene: SKPhysicsContactDelegate {
  func didBegin(_ contact: SKPhysicsContact) {
    var attack: Attack? = nil
    var health: HealthComponent? = nil
    
    if let attackA = contact.bodyA.node?.entity?.component(conformingTo: Attack.self) {
      attack = attackA
      health = contact.bodyB.node?.entity?.healthComponent
    } else if let attackB = contact.bodyB.node?.entity?.component(conformingTo: Attack.self) {
      attack = attackB
      health = contact.bodyA.node?.entity?.healthComponent
    }
    
    if var attack = attack, let health = health {
      attack.spent = true
      health.damage(points: attack.power)
    } else {
      print("UNHANDLED CONTACT")
    }
  }
}
