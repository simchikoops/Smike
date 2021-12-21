import SpriteKit

class AttackNode: SKSpriteNode {
  let heroType: HeroType
  let heroFacing: FacingDirection
  
  init (heroType: HeroType, originNode: SKSpriteNode) {
    self.heroType = heroType
    self.heroFacing = originNode.facing

    let texture = SKTexture(imageNamed: AttackNode.imageName(heroType))
    super.init(texture: texture, color: .clear, size: texture.size())
    
    self.depth = originNode.depth
    self.position = originNode.position
    self.zPosition = originNode.zPosition + 1.0
    
    if let parent = originNode.parent {
      parent.addChild(self)
    }
  }
  
  static func imageName(_ heroType: HeroType) -> String {
    switch heroType {
    case .woodpecker: return "beak"
    case .samurai: return "beak" // TODO: fix
    }
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func start() {
    var vector = CGVector(dx: 0, dy: 0)
    var xScaleMultiplier = 1.0
    
    switch heroFacing {
    case .right:
      vector = CGVector(dx: 300, dy: 350)
    case .left:
      vector = CGVector(dx: -300, dy: 350)
      xScaleMultiplier = -1
    }
    
    let physicsBody = SKPhysicsBody(circleOfRadius: self.size.height)
    print("attack Size", self.size)

    physicsBody.affectedByGravity = false
    physicsBody.allowsRotation = false
    physicsBody.isDynamic = true // just about the contacts

    physicsBody.categoryBitMask = 15//PhysicsInfo.heroAttack.categoryBitMask
    physicsBody.contactTestBitMask = 15//PhysicsInfo.heroAttack.contactTestBitMask
    physicsBody.collisionBitMask = 15//PhysicsInfo.heroAttack.contactTestBitMask

    self.physicsBody = physicsBody

    self.xScale *= xScaleMultiplier
    
    let motion = SKAction.move(by: vector, duration: 4.25)
    run(motion, completion: { self.removeFromParent() })
  }
}
