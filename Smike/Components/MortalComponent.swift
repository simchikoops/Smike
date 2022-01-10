import SpriteKit
import GameplayKit

class MortalComponent: GKComponent {
  override class var supportsSecureCoding: Bool {
    true
  }
  
  override func didAddToEntity() {
    if let scene = entity?.scene {
      scene.mortals.append(entity!)
    }
    
    if let node = entity!.node as? SKSpriteNode {
      let physicsBody = SKPhysicsBody(rectangleOf: node.size)

      physicsBody.affectedByGravity = false
      physicsBody.allowsRotation = false
      physicsBody.isDynamic = false

      physicsBody.categoryBitMask = PhysicsInfo.mortal.categoryBitMask
      physicsBody.contactTestBitMask = PhysicsInfo.mortal.contactTestBitMask

      node.physicsBody = physicsBody
    }
  }

  func die() {
    entity?.scene.mortals.remove(object: entity!)
    entity?.scene.checkWhetherHeroesDefeated()
    entity?.remove()
  }
}
