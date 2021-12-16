import SpriteKit
import GameplayKit

class GeneratorComponent: GKComponent {
  @GKInspectable var sequenceJSON: String = ""
  @GKInspectable var positivePath: Bool = true
  
  var sequence: [(ticks: CGFloat, type: DemonType)] = []
  
  var lowPath: [DemonDotComponent] = []
  var highPath: [DemonDotComponent] = []
  
  override func didAddToEntity() {
    let sequenceData = sequenceJSON.data(using: .utf8)!
    let sequenceObj = try! JSONSerialization.jsonObject(with: sequenceData, options: []) as! [Any]
    
    for unitObj in sequenceObj {
      let unit = unitObj as! [Any]
      let ticks = unit[0] as! CGFloat
      let type = unit[1] as! Int
      
      sequence.append((ticks: ticks, type: DemonType(rawValue: type)!))
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
    spawn(unit.type)
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
  
  private func spawn(_ type: DemonType) {
    print(type)
  }
}
