import SpriteKit
import GameplayKit

// A short-lived, single-target attack. A child of the origin sprite without independent existence.

class StabAttackComponent: GKComponent, Attack {
  let duration: CGFloat = 1.1 // disappears if no hits in this time
  
  let originSprite: SKSpriteNode
  
  let position: CGPoint
  let size: CGSize

  let physics: PhysicsInfo
  let power: Int
  
  var spent: Bool = false
  
  init(originSprite: SKSpriteNode, position: CGPoint, size: CGSize, physics: PhysicsInfo, power: Int) {
    self.originSprite = originSprite
    
    self.position = position
    self.size = size

    self.physics = physics
    self.power = power
    
    super.init()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override class var supportsSecureCoding: Bool {
    true
  }
  
  override func didAddToEntity() {
    let nodeComponent = NodeComponent(size: size)
    entity!.addComponent(nodeComponent) // necessary to run actions
    
    let node = entity!.node
    node.position = position
    
    originSprite.addChild(node)
  }
  
  func createPhysicsBody() {
    let physicsBody = SKPhysicsBody(rectangleOf: size)

    physicsBody.affectedByGravity = false
    physicsBody.allowsRotation = false
    physicsBody.isDynamic = true // has to be true or contact doesn't register

    physicsBody.categoryBitMask = physics.categoryBitMask
    physicsBody.contactTestBitMask = physics.contactTestBitMask

    let node = entity!.node
    node.physicsBody = physicsBody
  }
  
  func launch(delay: CGFloat) {
    entity!.node.run(SKAction.sequence([
      SKAction.wait(forDuration: delay), // for initial animation
      SKAction.run { [unowned self] in createPhysicsBody() },
      SKAction.wait(forDuration: duration), // active attack
      SKAction.run { [unowned self] in entity!.remove() }
    ]))
  }
  
  override func update(deltaTime seconds: TimeInterval) {
    if spent { entity!.remove() }
  }
}
