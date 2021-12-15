import SpriteKit
import GameplayKit

class GeneratorComponent: GKComponent {
  @GKInspectable var sequenceJSON: String = ""
  @GKInspectable var positivePath: Bool = true
  
  var sequence: [(tick: CGFloat, type: DemonType)] = []
  
  override func didAddToEntity() {
    let sequenceData = sequenceJSON.data(using: .utf8)!
    let sequenceObj = try! JSONSerialization.jsonObject(with: sequenceData, options: []) as! [Any]
    
    for unitObj in sequenceObj {
      let unit = unitObj as! [Any]
      let tick = unit[0] as! CGFloat
      let type = unit[1] as! Int
      
      sequence.append((tick: tick, type: DemonType(rawValue: type)!))
    }
  }
  
  override class var supportsSecureCoding: Bool {
    true
  }
}
