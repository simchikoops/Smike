import SpriteKit
import GameplayKit

class HeroAttackComponent: GKComponent {
  let originHero: GKEntity
  
  var imageName: String {
    get {
      switch originHero.heroComponent!.heroType! {
      case .woodpecker: return "beak"
      case .samurai: return "beak" // TODO: fix
      }
    }
  }

  init(originHero: GKEntity) {
    self.originHero = originHero
    super.init()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override class var supportsSecureCoding: Bool {
    true
  }
  
  override func didAddToEntity() {
    let originNode = originHero.spriteNode
    let nodeComponent = NodeComponent(imageNamed: imageName, position: originNode.position, depth: originNode.depth, layer: originNode.layer)
    
    entity!.addComponent(nodeComponent)
  }
  
  func launch() {
    let node = entity!.spriteNode
    var vector = CGVector(dx: 0, dy: 0)
    var xScaleMultiplier = 1.0
    
    switch originHero.spriteNode.facing {
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
}
