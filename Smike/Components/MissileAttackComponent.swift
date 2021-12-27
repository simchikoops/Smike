import SpriteKit
import GameplayKit

class MissileAttackComponent: GKComponent {
  let originSprite: SKSpriteNode
  let power: Int
  let imageName: String
  
  var spent: Bool = false
  
  init(originSprite: SKSpriteNode, imageName: String, power: Int) {
    self.originSprite = originSprite
    self.imageName = imageName
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
    let nodeComponent = NodeComponent(imageNamed: imageName, position: originSprite.position, depth: originSprite.depth, layer: originSprite.layer)
    
    entity!.addComponent(nodeComponent)
  }
  
  func launch() {
    let node = entity!.spriteNode
    var vector = CGVector(dx: 0, dy: 0)
    var xScaleMultiplier = 1.0
    
    switch originSprite.facing {
    case .right:
      vector = CGVector(dx: 300, dy: 350)
    case .left:
      vector = CGVector(dx: -300, dy: 350)
      xScaleMultiplier = -1
    }
    
    let physicsBody = SKPhysicsBody(circleOfRadius: node.size.height)

    physicsBody.affectedByGravity = false
    physicsBody.allowsRotation = false
    physicsBody.isDynamic = true // has to be true or contact doesn't register

    physicsBody.categoryBitMask = PhysicsInfo.heroAttack.categoryBitMask
    physicsBody.contactTestBitMask = PhysicsInfo.heroAttack.contactTestBitMask

    node.physicsBody = physicsBody

    node.xScale *= xScaleMultiplier
    
    let motion = SKAction.move(by: vector, duration: 4.25)
    node.run(motion, completion: { self.entity!.remove() })
  }
  
  override func update(deltaTime seconds: TimeInterval) {
    if spent { entity!.remove() }
  }
}
