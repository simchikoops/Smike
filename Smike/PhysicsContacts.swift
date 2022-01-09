import SpriteKit

extension LevelScene: SKPhysicsContactDelegate {
  func didBegin(_ contact: SKPhysicsContact) {
    let touch = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
    
    switch touch {
    case PhysicsInfo.heroAttack.categoryBitMask | PhysicsInfo.demon.categoryBitMask:
      let demonNode = contact.bodyA.categoryBitMask == PhysicsInfo.demon.categoryBitMask ? contact.bodyA.node : contact.bodyB.node

      let heroAttackNode = contact.bodyA.categoryBitMask == PhysicsInfo.heroAttack.categoryBitMask ? contact.bodyA.node : contact.bodyB.node
      let missile = heroAttackNode!.entity!.component(ofType: MissileAttackComponent.self)!
      
      missile.spent = true
      demonNode?.entity?.healthComponent?.damage(points: missile.power)
    case PhysicsInfo.demonAttack.categoryBitMask | PhysicsInfo.mortal.categoryBitMask:
      let mortalNode = contact.bodyA.categoryBitMask == PhysicsInfo.mortal.categoryBitMask ? contact.bodyA.node : contact.bodyB.node

      let demonAttackNode = contact.bodyA.categoryBitMask == PhysicsInfo.heroAttack.categoryBitMask ? contact.bodyA.node : contact.bodyB.node
      let missile = demonAttackNode!.entity!.component(ofType: MissileAttackComponent.self)!
      
      missile.spent = true
      mortalNode?.entity?.healthComponent?.damage(points: missile.power)
    case PhysicsInfo.demonAttack.categoryBitMask | PhysicsInfo.hero.categoryBitMask:
      let heroNode = contact.bodyA.categoryBitMask == PhysicsInfo.hero.categoryBitMask ? contact.bodyA.node : contact.bodyB.node

      let demonAttackNode = contact.bodyA.categoryBitMask == PhysicsInfo.demonAttack.categoryBitMask ? contact.bodyA.node : contact.bodyB.node
      let missile = demonAttackNode!.entity!.component(ofType: MissileAttackComponent.self)!
      
      missile.spent = true
      heroNode?.entity?.healthComponent?.damage(points: missile.power)
    default:
      print("UNKNOWN CONTACT")
      break
    }
  }
}
