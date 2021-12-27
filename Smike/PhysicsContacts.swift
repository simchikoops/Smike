import SpriteKit

extension LevelScene: SKPhysicsContactDelegate {
  func didBegin(_ contact: SKPhysicsContact) {
    let collision = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
    
    switch collision {
    case PhysicsInfo.heroAttack.categoryBitMask | PhysicsInfo.demon.categoryBitMask:
      let demonNode = contact.bodyA.categoryBitMask == PhysicsInfo.demon.categoryBitMask ? contact.bodyA.node : contact.bodyB.node

      let heroAttackNode = contact.bodyA.categoryBitMask == PhysicsInfo.heroAttack.categoryBitMask ? contact.bodyA.node : contact.bodyB.node
      let heroAttackComponent = heroAttackNode!.entity!.component(ofType: MissileAttackComponent.self)!
      
      heroAttackComponent.spent = true
      demonNode?.entity?.healthComponent?.damage(points: heroAttackComponent.power)
    default:
      break
    }
  }
}
