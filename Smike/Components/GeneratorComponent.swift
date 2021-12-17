import SpriteKit
import GameplayKit

class GeneratorComponent: GKComponent {
  @GKInspectable var sequenceJSON: String = ""
  @GKInspectable var positivePath: Bool = true
  
  var sequence: [(ticks: CGFloat, type: DemonType, highPath: Bool)] = []
  
  var lowPath: [DemonDotComponent] = []
  var highPath: [DemonDotComponent] = []
  
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
      
      var highPath = false
      if unit.count > 2 {
        highPath = unit[2] as! Bool
      }
        
      sequence.append((ticks: ticks, type: DemonType(rawValue: type)!, highPath: highPath))
    }
    
    if let scene = entity?.scene {
      scene.generators.append(entity!)
    }
  }
  
  override class var supportsSecureCoding: Bool {
    true
  }
  
  // Needs all dot components loaded first.
  func calculatePaths() {
    self.lowPath = buildPath(low: true)
    self.highPath = buildPath(low: false)
  }
  
  override func update(deltaTime seconds: TimeInterval) {
    guard let unit = sequence.first else { return }
    guard entity!.scene.ticks >= unit.ticks else { return }
    
    sequence.removeFirst()
    spawn(type: unit.type, useHighPath: unit.highPath)
  }
  
  private func buildPath(low: Bool) -> [DemonDotComponent] {
    var path: [DemonDotComponent] = []
    var dot = entity!.component(ofType: DemonDotComponent.self)!
    
    while true {
      path.append(dot)
      if (positivePath && dot.posTerm) || (!positivePath && dot.negTerm) { break }
      
      let edges = positivePath ? dot.positiveEdges : dot.negativeEdges
      if edges.isEmpty { break }
      
      dot = low ? edges.first! : edges.last!
    }
    
    return path
  }
  
  private func spawn(type: DemonType, useHighPath: Bool) {
    let path = useHighPath ? highPath : lowPath
    let demon = DemonEntity(type: type, path: path, originNode: entity!.node)
    
    entity!.scene.entities.append(demon)
    entity!.scene.demons.append(demon)
  }
}
