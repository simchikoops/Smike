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
    let demon = GKEntity()
    
    if let entranceImageName = demonType.entranceImageName, entrance == nil  {
      self.entrance = GKEntity()
      
      let fix = track!.fixAlong(0)
      let nodeComponent = NodeComponent(imageNamed: "\(entranceImageName)_0", position: fix.position, depth: fix.depth, layer: fix.layer)
      entrance?.addComponent(nodeComponent)

      let animationComponent = AnimationComponent()
      animationComponent.textures = entranceImageName
      animationComponent.frameCount = demonType.entranceFrameCount
      animationComponent.timePerFrame = demonType.entranceTimePerFrame
      entrance?.addComponent(animationComponent)
      
      entity!.node.parent!.addChild(entrance!.node)
    }
    
    let demonComponent = DemonComponent(generator: self)
    demon.addComponent(demonComponent)
    
    self.demons.append(demon)
  }
}
