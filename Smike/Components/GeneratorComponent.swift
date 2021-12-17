import SpriteKit
import GameplayKit

class GeneratorComponent: GKComponent {
  @GKInspectable var sequenceJSON: String = ""
  @GKInspectable var positivePath: Bool = true
  
  var sequence: [(ticks: CGFloat, type: DemonType, useHighTrack: Bool)] = []
  
  var lowTrack: Track?
  var highTrack: Track?
  
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
      
      var useHighTrack = false
      if unit.count > 2 {
        useHighTrack = unit[2] as! Bool
      }
        
      sequence.append((ticks: ticks, type: DemonType(rawValue: type)!, useHighTrack: useHighTrack))
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
    self.lowTrack = pathToTrack(path: buildPath(low: true))
    self.highTrack = pathToTrack(path: buildPath(low: false))
  }
  
  override func update(deltaTime seconds: TimeInterval) {
    guard let unit = sequence.first else { return }
    guard entity!.scene.ticks >= unit.ticks else { return }
    
    sequence.removeFirst()
    spawn(type: unit.type, useHighTrack: unit.useHighTrack)
  }
  
  private func buildPath(low: Bool) -> [NetDotComponent] {
    var path: [NetDotComponent] = []
    var dot = entity!.component(ofType: NetDotComponent.self)!
    
    while true {
      path.append(dot)
      if (positivePath && dot.posTerm) || (!positivePath && dot.negTerm) { break }
      
      let edges = positivePath ? dot.positiveEdges : dot.negativeEdges
      if edges.isEmpty { break }
      
      dot = low ? edges.first! : edges.last!
    }
    
    return path
  }
  
  private func pathToTrack(path: [NetDotComponent]) -> Track {
    let orderedDots = path.map {
      (position: $0.entity!.node.position, depth: $0.entity!.depth, layer: $0.entity!.layer)
    }
    return Track(orderedDots: orderedDots)
  }
  
  private func spawn(type: DemonType, useHighTrack: Bool) {
    let track = useHighTrack ? highTrack! : lowTrack!
    let demon = DemonEntity(type: type, track: track, originNode: entity!.node)
    
    entity!.scene.entities.append(demon)
    entity!.scene.demons.append(demon)
  }
}
