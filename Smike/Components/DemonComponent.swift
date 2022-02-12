import SpriteKit
import GameplayKit

class DemonComponent: GKComponent {
  let generator: GeneratorComponent

  var alongTrack: CGFloat = 0
  var lastAttackTicks: CGFloat = 0.0
  var isDiving: Bool = false
  
  var type: DemonType { generator.demonType }
  var track: Track { generator.track! }
  
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
    guard !isDiving else { return }
    
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
    let victim = entity!.scene.nearestMortal(scenePosition: scenePosition)
    
    print(victim)
    
    // TODO: remove self
  }
  
  func kill() {
//    entity?.scene.demons.remove(object: entity!)
//    entity?.scene.checkForWin()
//    entity?.remove()
  }
}
