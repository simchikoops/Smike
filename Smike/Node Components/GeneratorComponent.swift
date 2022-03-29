import SpriteKit
import GameplayKit

class GeneratorComponent: GKComponent {
  @GKInspectable var sequenceJSON: String = ""
  @GKInspectable var duration: CGFloat = 1
  @GKInspectable var rawDemonType: Int = 0

  var demonType: DemonType = .bat
  var sequence: [CGFloat] = []
  var track: Track?
  
  var demons: [GKEntity] = []
  var entrance: GKEntity?
  
  var exhausted: Bool {
    get { sequence.isEmpty && demons.isEmpty }
  }
  
  override func didAddToEntity() {
    let sequenceData = sequenceJSON.data(using: .utf8)!
    self.sequence = try! JSONSerialization.jsonObject(with: sequenceData, options: []) as! [CGFloat]
    
    self.demonType = DemonType(rawValue: rawDemonType)!
    
    track = Track.fromNodes(headNode: entity!.node)
    
    if let scene = entity?.scene {
      scene.generators.append(entity!)
    }
  }
  
  override class var supportsSecureCoding: Bool {
    true
  }

  override func update(deltaTime seconds: TimeInterval) {
    guard let ticks = sequence.first else { return }
    guard entity!.scene.ticks >= ticks else { return }
    
    sequence.removeFirst()
    spawn()
  }
  
  private func spawn() {
    if demonType.entranceImageName != nil, entrance == nil  {
      entity!.node.run(SKAction.sequence([prespawnAction(), spawnAction()]))
    } else {
      entity!.node.run(spawnAction())
    }
  }
  
  private func prespawnAction() -> SKAction {
    return SKAction.sequence([
      SKAction.run {
        self.entrance = GKEntity()
        self.entity!.scene.entities.append(self.entrance!)
        
        let fix = self.track!.fixAlong(0)
        let nodeComponent = NodeComponent(imageNamed: "\(self.demonType.entranceImageName!)_0", position: fix.position, depth: fix.depth, layer: fix.layer - 10)
        self.entrance?.addComponent(nodeComponent)

        let animationComponent = AnimationComponent()
        animationComponent.textures = self.demonType.entranceImageName!
        animationComponent.frameCount = self.demonType.entranceFrameCount
        animationComponent.timePerFrame = self.demonType.entranceTimePerFrame
        animationComponent.repeats = false
        self.entrance?.addComponent(animationComponent)
        
        self.entity!.node.addChild(self.entrance!.node)
      },
      SKAction.wait(forDuration: Double(demonType.entranceFrameCount) * demonType.entranceTimePerFrame * 2)
    ])
  }
  
  private func spawnAction() -> SKAction {
    return SKAction.run {
      let demon = GKEntity()
      let demonComponent = DemonComponent(generator: self)
      
      demon.addComponent(demonComponent)
      self.demons.append(demon)
    }
  }
}
