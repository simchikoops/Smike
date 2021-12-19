import SpriteKit

class AttackNode: SKSpriteNode {
  let heroType: HeroType
  
  init (heroType: HeroType, originNode: SKSpriteNode) {
    self.heroType = heroType

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
    print("start")
  }
}
