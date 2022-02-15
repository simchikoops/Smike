import SpriteKit
import GameplayKit

class DemonComponent: GKComponent {
  let minimumAttackCost = 25
  let maximumAttackCost = 200
  
  let generator: GeneratorComponent
  var type: DemonType { generator.demonType }
  var track: Track { generator.track! }

  var alongTrack: CGFloat = 0
  var isDiving: Bool = false
  var isDying: Bool = false
    
  init(generator: GeneratorComponent) {
    self.generator = generator
    super.init()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override class var supportsSecureCoding: Bool {
    true
  }
  
  override func didAddToEntity() {
    let fix = track.fixAlong(0)
    var imageName: String = ""
    
    if type.frameCount > 1 {
      let animationComponent = AnimationComponent()
      animationComponent.textures = type.imageName
      animationComponent.frameCount = type.frameCount
      animationComponent.timePerFrame = type.timePerFrame
      entity!.addComponent(animationComponent)
      
      imageName = "\(type.imageName)_0"
    } else {
      imageName = type.imageName
    }
    
    let nodeComponent = NodeComponent(imageNamed: imageName, position: fix.position, depth: fix.depth, layer: fix.layer)
    
    entity!.addComponent(nodeComponent)
  }
    
  override func update(deltaTime seconds: TimeInterval) {
    guard let node = entity?.node as? SKSpriteNode else { return }
    guard !(isDiving || isDying) else { return }
    
    let increment = (seconds / generator.duration)
    alongTrack += increment
     
    if alongTrack >= 1.0 {
      dive()
    } else {
      let (position, depth, layer, facing) = track.fixFractionAlong(alongTrack)
      
      node.position = position
      node.depth = depth
      node.zPosition = layer
      node.facing = facing
    }
  }
  
  func dive() {
    self.isDiving = true
    
    let scenePosition = entity!.node.convert(entity!.node.position, to: entity!.scene)
    let victim = entity!.scene.nearestLivingMortal(scenePosition: scenePosition)
    
    victim?.component(ofType: MortalComponent.self)?.kill()
    
    guard let node = entity?.node as? SKSpriteNode, let victimNode = victim?.node else { return }
    guard let diveTarget = node.parent?.convert(victimNode.position, from: victimNode.parent!) else { return }
    
    node.zPosition = 7000 // out in front
    node.run(SKAction.sequence([
      SKAction.group([
        SKAction.scale(by: 2.0, duration: 0.5),
        SKAction.fadeAlpha(by: -0.6, duration: 0.5)
      ]),
      SKAction.group([
        SKAction.scale(to: 0.4, duration: 0.5),
        SKAction.move(to: diveTarget, duration: 0.5)
      ]),
      SKAction.run { self.clearSelf(checkWin: false) }
    ]))
  }
  
  // TODO: better than point-in-rect.
  func hitAt(scenePoint: CGPoint) -> Bool {
    return true
  }
  
  func attack() {
    guard !isDiving, let scene = entity?.scene else { return }
    
    let powerCost = powerPrice()
    print("price", alongTrack, powerCost)
    
    if scene.attackPower >= powerCost {
      scene.attackPower -= powerCost
    } else {
      // TODO: bad noise
      print("too much")
      return
    }
    
    // TODO: use power, animate
    
    self.isDying = true
    clearSelf(checkWin: true);
  }
  
  func powerPrice() -> Int {
    minimumAttackCost + Int(floor(CGFloat(maximumAttackCost - minimumAttackCost) * pow(1 - alongTrack, 0.5)))
  }
  
  func clearSelf(checkWin: Bool) {
    generator.demons.remove(object: entity!)
    if checkWin, let scene = entity?.scene {
      scene.checkForWin()
    }
    entity?.remove()
  }
}
