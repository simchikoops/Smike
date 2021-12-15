import SpriteKit
import GameplayKit

class GeneratorComponent: GKComponent {
  @GKInspectable var sequenceJSON: String = ""
  @GKInspectable var positivePath: Bool = true
  
  var sequence: [(ticks: CGFloat, type: DemonType)] = []
  
  override func didAddToEntity() {
    let sequenceData = sequenceJSON.data(using: .utf8)!
    let sequenceObj = try! JSONSerialization.jsonObject(with: sequenceData, options: []) as! [Any]
    
    for unitObj in sequenceObj {
      let unit = unitObj as! [Any]
      let ticks = unit[0] as! CGFloat
      let type = unit[1] as! Int
      
      sequence.append((ticks: ticks, type: DemonType(rawValue: type)!))
    }
  }
  
  override class var supportsSecureCoding: Bool {
    true
  }
  
  override func update(deltaTime seconds: TimeInterval) {
    guard let unit = sequence.first else { return }
    guard entity!.scene.ticks >= unit.ticks else { return }
    
    sequence.removeFirst()
    spawn(unit.type)
  }
  
  private func spawn(_ type: DemonType) {
    print(type)
  }
}
