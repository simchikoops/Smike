import SpriteKit
import GameplayKit

class DemonComponent: GKComponent, Tappable {
  let minimumAttackCost = 1
  let maximumAttackCost = 100
  
  let attackWindowSeconds: CGFloat = 5.0
  
  let generator: GeneratorComponent
  var type: DemonType { generator.demonType }
  var track: Track { generator.track! }
  
  var frameNode: SKSpriteNode?
  var blindNode: SKSpriteNode?

  var alongTrack: CGFloat = 0
  var isDiving: Bool = false
  var isDying: Bool = false
  
  var alongAttackWindow: CGFloat {
    max(0, (alongTrack * generator.duration) - (generator.duration - attackWindowSeconds)) / attackWindowSeconds
  }
    
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
    
    self.blindNode = SKSpriteNode(imageNamed: "\(type.imageName)_blind")
    self.blindNode?.zPosition = fix.depth + 1
    entity!.node.addChild(blindNode!)
    
    generator.entity!.node.addChild(entity!.node)
    entity!.scene.entities.append(entity!)
    
    self.frameNode = SKSpriteNode(imageNamed: "\(type.imageName)_frame")
    track.affixNodeFractionAlong(fractionAlong: 1.0, node: frameNode!)
    
    frameNode?.zPosition += 0.5 // stay ahead of main sprite
    frameNode?.alpha = 0.0
    frameNode?.run(SKAction.sequence([
      SKAction.wait(forDuration: generator.duration - attackWindowSeconds),
      SKAction.fadeAlpha(to: 1.0, duration: attackWindowSeconds)]))
    
    entity!.node.parent!.addChild(frameNode!)
  }
    
  override func update(deltaTime seconds: TimeInterval) {
    guard let node = entity?.node as? SKSpriteNode else { return }
    guard !(isDiving || isDying) else { return }
        
    let increment = (seconds / generator.duration)
    alongTrack += increment
     
    if alongTrack >= 1.0 {
      dive()
    } else {
      track.affixNodeFractionAlong(fractionAlong: alongTrack, node: node)
    }
  }
  
  func dive() {
    self.isDiving = true
        
    let scenePosition = entity!.node.convert(entity!.node.position, to: entity!.scene)
    let victim = entity!.scene.nearestLivingMortal(scenePosition: scenePosition)
    
    victim?.component(ofType: MortalComponent.self)?.kill()
    
    guard let node = entity?.node as? SKSpriteNode, let victimNode = victim?.node else { return }
    guard let diveTarget = node.parent?.convert(victimNode.position, from: victimNode.parent!) else { return }
        
    node.zPosition = 9000 // out in front
        
    let diveActions = SKAction.sequence([
      SKAction.group([
        SKAction.scale(by: 2.0, duration: 0.5),
        SKAction.fadeAlpha(by: -0.6, duration: 0.5)
      ]),
      SKAction.group([
        SKAction.scale(to: 0.4, duration: 0.5),
        SKAction.move(to: diveTarget, duration: 0.5)
      ])
    ])
    
    node.run(SKAction.sequence([diveActions, SKAction.run { self.clearSelf(checkWin: false) }]))
    self.blindNode?.removeFromParent()
    self.frameNode?.removeFromParent()
  }
  
  // TODO: better than point-in-rect.
  func isTappedAt(scenePoint: CGPoint) -> Bool {
    return true
  }
  
  func tapped() {
    guard !isDiving, !isDying, let scene = entity?.scene else { return }
    
    let powerCost = powerPrice()
    
    if alongAttackWindow == 0.0 {
      print("not attackable")
      return
    } else if scene.attackPower < powerCost {
      // TODO: bad noise
      print("too much")
      return
    }
    
    scene.attackPower -= powerCost
    
    let position = entity!.printNode!.convert(entity!.node.position, from: entity!.node.parent!)
    scene.addContextLabel(printPosition: position, text: "-\(powerCost)", color: costColor(powerCost))

    self.isDying = true
    clearSelf(checkWin: true);
  }
  
  // Higher powers are closer to linear prices.
  func powerPrice() -> Int {
    Int(round(CGFloat(maximumAttackCost - minimumAttackCost) * pow(1 - alongAttackWindow, 0.75))) + minimumAttackCost
  }
    
  func costColor(_ cost: Int) -> UIColor {
    if cost > 150 {
      return .red
    } else if cost > 100 {
      return .orange
    } else if cost > 50 {
      return .yellow
    } else {
      return .green
    }
  }
  
  func clearSelf(checkWin: Bool) {
    frameNode?.removeFromParent()
    generator.demons.remove(object: entity!)
    
    if checkWin, let scene = entity?.scene {
      scene.checkForWin()
    }
    entity?.remove()
  }
}
