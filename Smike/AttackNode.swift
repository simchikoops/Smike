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

    self.xScale *= xScaleMultiplier
    
    let motion = SKAction.move(by: vector, duration: 0.25)
    run(motion, completion: { self.removeFromParent() })
  }
}
