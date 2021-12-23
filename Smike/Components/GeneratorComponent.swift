import SpriteKit
import GameplayKit

class GeneratorComponent: GKComponent {
  @GKInspectable var sequenceJSON: String = ""
  
  var sequence: [(ticks: CGFloat, type: DemonType)] = []
  var track: Track?
  
  var exhausted: Bool {
    get { sequence.isEmpty }
  }
  
  override func didAddToEntity() {
    let sequenceData = sequenceJSON.data(using: .utf8)!
    let sequenceObj = try! JSONSerialization.jsonObject(with: sequenceData, options: []) as! [Any]
    
    for unitObj in sequenceObj {
      let unit = unitObj as! [Any]
      
      let ticks = unit[0] as! CGFloat
      let type = unit[1] as! Int
        
      sequence.append((ticks: ticks, type: DemonType(rawValue: type)!))
    }
    
    track = Track.fromNodes(headNode: entity!.node)
    
    if let scene = entity?.scene {
      scene.generators.append(entity!)
    }
  }
  
  override class var supportsSecureCoding: Bool {
    true
  }

  override func update(deltaTime seconds: TimeInterval) {
    guard let unit = sequence.first else { return }
    guard entity!.scene.ticks >= unit.ticks else { return }
    
    sequence.removeFirst()
    spawn(type: unit.type)
  }
  
  private func spawn(type: DemonType) {
    let demon = GKEntity()
    
    let demonComponent = DemonComponent(type: type, track: track!)
    demon.addComponent(demonComponent)
    
    entity!.node.parent!.addChild(demon.node)
    
    entity!.scene.entities.append(demon)
    entity!.scene.demons.append(demon)
  }
}
