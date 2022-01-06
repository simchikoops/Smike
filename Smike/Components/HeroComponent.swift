import SpriteKit
import GameplayKit

enum HeroMotion {
  case toLeft
  case toRight
  case stopped
}

class HeroComponent: GKComponent {
  @GKInspectable var type: String = ""
  @GKInspectable var index: Int = 0
  
  let unselectedColor: UIColor = .gray
  let selectedColor: UIColor = .yellow
  
  let impairmentTime: Float = 4.0
  let maxImpairmentAlpha: Float = 0.45
  let minImpairmentAlpha: Float = 0.75
  
  var heroType: HeroType?
  
  var track: Track?
  var trackNode: SKShapeNode?
  
  var alongTrack: CGFloat = 0.0
  var moving: HeroMotion = .stopped
  var lastAttackTicks: CGFloat = 0.0
  
  var impaired: Bool { entity!.healthComponent!.hp <= 0 }
  
  var hasFocus: Bool = false {
    didSet {
      trackNode?.strokeColor = hasFocus ? selectedColor : unselectedColor
    }
  }

  override func didAddToEntity() {
    guard let printNode = entity?.printNode else { return }
    
    self.heroType = HeroType(rawValue: type)
    createControl()
    
    self.track = Track.fromNodes(headNode: entity!.spriteNode)
    alongTrack = track!.distance / 2
    moveToDot(track!.dotAlong(alongTrack))
    
    self.trackNode = createTrackNode()
    printNode.addChild(trackNode!)
     
    if let scene = entity?.scene {
      scene.heroes.append(entity!)
    }
    
    if let node = entity!.node as? SKSpriteNode {
      let physicsBody = SKPhysicsBody(rectangleOf: node.size)

      physicsBody.affectedByGravity = false
      physicsBody.allowsRotation = false
      physicsBody.isDynamic = false // alow overlaps

      physicsBody.categoryBitMask = PhysicsInfo.hero.categoryBitMask
      physicsBody.contactTestBitMask = PhysicsInfo.hero.contactTestBitMask

      node.physicsBody = physicsBody
    }
  }
  
  override class var supportsSecureCoding: Bool {
    true
  }
  
  func attack() {
    guard !impaired else { return }
    guard entity!.scene.ticks - lastAttackTicks > heroType!.minimumAttackInterval else { return }
    
    switch heroType!.attack {
    case .thrust:
      print("THRUST ATTACK")
    case .missile:
      let attack = GKEntity()
      entity!.scene.entities.append(attack)
      
      var startingPosition = entity!.spriteNode.position
      startingPosition.y += heroType!.attackOrigin.y
      startingPosition.x += entity!.spriteNode.facing == .right ? heroType!.attackOrigin.y : -heroType!.attackOrigin.y
    
      let attackComponent = MissileAttackComponent(originSprite: entity!.spriteNode, physics: PhysicsInfo.heroAttack, imageName: heroType!.attackDisplay, startingPosition: startingPosition, power: heroType!.attackPower, speed: heroType!.attackSpeed!)
      attack.addComponent(attackComponent)
    
      entity!.printNode!.addChild(attack.node)
    
      var vector: CGVector = CGVector(dx: 0, dy: 0)
      switch entity!.spriteNode.facing {
      case .right:
        vector = CGVector(dx: 300, dy: 350)
      case .left:
        vector = CGVector(dx: -300, dy: 350)
      }
 
      attackComponent.launch(vector: vector)
    }
    
    lastAttackTicks = entity!.scene.ticks
  }
  
  func impair() {
    // TODO: flash into impairment
    entity!.node.alpha = CGFloat(maxImpairmentAlpha)
    
    let unfade = SKAction.fadeAlpha(to: CGFloat(minImpairmentAlpha), duration: CGFloat(impairmentTime))
    let clearImpairment = SKAction.run { [unowned self] in
      entity!.node.alpha = 1.0
      entity!.healthComponent!.hp = entity!.healthComponent!.maxHp
    }
    let unfadeSequence = SKAction.sequence([unfade, clearImpairment])
    
    entity!.node.run(unfadeSequence, withKey: "unfade")
  }

  private func createControl() {
    let rect = entity!.node.calculateAccumulatedFrame().insetBy(dx: -40, dy: -40)
    let controlNode = SKShapeNode(rect: rect)
    
    controlNode.name = "hero_control_\(index)"
    controlNode.strokeColor = .clear
    controlNode.zPosition = Layer.dash.rawValue
    
    entity!.node.parent?.addChild(controlNode)
  }
  
  private func createTrackNode() -> SKShapeNode {
    let node = SKShapeNode(path: track!.asCGPath())
    
    node.strokeColor = unselectedColor
    node.alpha = 0.85
    node.lineWidth = 5
    node.glowWidth = 5
    node.lineCap = .round
    node.zPosition = Layer.tracks.rawValue

    return node;
  }
  
  override func update(deltaTime seconds: TimeInterval) {
    guard !impaired else { return }
    guard let node = entity?.node as? SKSpriteNode, let track = self.track else { return }
    
    let speed = Slot.live.heroStats[heroType!]!["speed"]! * seconds
    
    switch moving {
    case .toLeft:
      node.xScale = -1 // look direction
      alongTrack = (alongTrack - speed).clamped(to: 0...track.distance)
    case .toRight:
      node.xScale = 1
      alongTrack = (alongTrack + speed).clamped(to: 0...track.distance)
    case .stopped: return // nothing to do
    }
    
    moveToDot(track.dotAlong(alongTrack))
  }
  
  func moveToDot(_ dot: TrackDot) {
    let (position, depth, layer, _) = dot
    
    entity!.spriteNode.position = position
    entity!.spriteNode.depth = depth
    entity!.spriteNode.zPosition = layer
  }
}
