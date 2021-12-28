import SpriteKit
import GameplayKit

class MissileAttackComponent: GKComponent {
  let originSprite: SKSpriteNode
  let physics: PhysicsInfo
  
  let imageName: String
  let power: Int
  let speed: CGFloat
  
  var spent: Bool = false
  
  init(originSprite: SKSpriteNode, physics: PhysicsInfo, imageName: String, power: Int, speed: CGFloat) {
    self.originSprite = originSprite
    self.physics = physics
    
    self.imageName = imageName
    self.power = power
    self.speed = speed
    
    super.init()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override class var supportsSecureCoding: Bool {
    true
  }
  
  override func didAddToEntity() {
    let nodeComponent = NodeComponent(imageNamed: imageName, position: originSprite.position, depth: originSprite.depth, layer: originSprite.layer, facing: originSprite.facing)
    
    entity!.addComponent(nodeComponent)
  }
  
  func launch(vector: CGVector) {
    let node = entity!.spriteNode
    let physicsBody = SKPhysicsBody(circleOfRadius: node.size.height)

    physicsBody.affectedByGravity = false
    physicsBody.allowsRotation = false
    physicsBody.isDynamic = true // has to be true or contact doesn't register

    physicsBody.categoryBitMask = physics.categoryBitMask
    physicsBody.contactTestBitMask = physics.contactTestBitMask

    node.physicsBody = physicsBody
    
    let duration = vector.length / speed
    
    let motion = SKAction.move(by: vector, duration: duration)
    node.run(motion, completion: { self.entity!.remove() })
  }
  
  override func update(deltaTime seconds: TimeInterval) {
    if spent { entity!.remove() }
  }
}
