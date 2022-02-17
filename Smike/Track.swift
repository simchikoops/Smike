import SpriteKit
import Algorithms

enum FacingDirection {
  case left
  case right
  
  var opposite: FacingDirection {
    switch self {
    case .left: return .right
    case .right: return .left
    }
  }
}

typealias TrackDot = (position: CGPoint, depth: CGFloat, layer: CGFloat, facing: FacingDirection, relativeSpeed: CGFloat)
typealias TrackFix = (position: CGPoint, depth: CGFloat, layer: CGFloat, facing: FacingDirection)

struct Track {
  let dots: [ TrackDot ]
  let isLoop: Bool
  
  let printDepthFactor: CGFloat = 1500 // how long it takes to travel along z; could vary by print
  
  var distance: CGFloat = 0
  var referenceDot: TrackDot { dots.first! }
  
  init(orderedDots: [ TrackDot ], loop: Bool = false) {
    assert(orderedDots.count >= 2, "Not enough dots in track")
    
    dots = orderedDots
    isLoop = loop
    
    distance = totalDistance()
  }
  
  static func fromNodes(headNode: SKNode, loop: Bool = false) -> Track? {
    var trackNodes = headNode.children.filter { node in
      node.entity?.component(ofType: TrackDotComponent.self) != nil
    }
    
    trackNodes.sort {
      $0.entity!.component(ofType: TrackDotComponent.self)!.seq < $1.entity!.component(ofType: TrackDotComponent.self)!.seq
    }

    var trackDots: [ TrackDot ] = []
    for (index, node) in trackNodes.enumerated() {
      var nextNode: SKNode?
      
      if index < trackNodes.count - 1 {
        nextNode = trackNodes[index + 1]
      } else if loop {
        nextNode = trackNodes[0]
      }
      
      var facing: FacingDirection = .right
      if let nn = nextNode {
        facing = nn.position.x > node.position.x ? .right : .left
      } else {
        facing = trackDots.last!.facing // don't suddenly turn at track's end
      }
      
      let component = node.entity!.component(ofType: TrackDotComponent.self)!
      trackDots.append((position: node.position, depth: component.depth, layer: node.zPosition,
                        facing: facing, relativeSpeed: component.relativeSpeed))
    }
    
    trackNodes.forEach { $0.entity?.remove() }
    return Track(orderedDots: trackDots, loop: loop)
  }
  
  func totalDistance() -> CGFloat {
    dotPairs().map { dotDistance($0, $1) }.reduce(0, +)
  }
  
  func dotDistance(_ a: TrackDot, _ b: TrackDot) -> CGFloat {
    (a.position.distance(to: b.position) + zDistance(a, b)) / a.relativeSpeed
  }
  
  func zDistance(_ a: TrackDot, _ b: TrackDot) -> CGFloat {
    abs(b.depth - a.depth) * printDepthFactor
  }
    
  func asCGPath() -> CGPath {
    let path = CGMutablePath()
    
    path.move(to: dots.first!.position)
    dots.dropFirst().forEach { path.addLine(to: $0.position) }
    
    return path
  }
    
  func fixAlong(_ distanceAlong: CGFloat) -> TrackFix {
    assert(distanceAlong >= 0 && distanceAlong <= distance, "Along out of range.")
    
    var distanceCovered = 0.0
    
    // find segment and segmentAlong
    for (from, to) in dotPairs() {
      let segmentDistance = dotDistance(from, to)
        
      if distanceCovered + segmentDistance >= distanceAlong {
        let segmentRemaining = distanceAlong - distanceCovered
        let ratio = segmentRemaining / segmentDistance
         
        let position = CGPoint(x: (1 - ratio) * from.position.x + (ratio * to.position.x),
                                y: (1 - ratio) * from.position.y + (ratio * to.position.y))
        let depth = from.depth + (to.depth - from.depth) * ratio
        let layer = from.layer > 0 ? from.layer + (to.layer - from.layer) * ratio : from.layer
         
        return (position, depth, layer, from.facing)
      } else {
        distanceCovered += segmentDistance
      }
    }

    return dotToFix(dots.last!) // underflow
  }
  
  func dotToFix(_ dot: TrackDot) -> TrackFix {
    return (position: dot.position, depth: dot.depth, layer: dot.layer, facing: dot.facing)
  }
  
  func fixFractionAlong(_ fractionAlong: CGFloat) -> TrackFix {
    return fixAlong(fractionAlong * distance)
  }
  
  private func dotPairs() -> Array<(TrackDot, TrackDot)> {
    var pairsArray = Array(dots.adjacentPairs())
    if isLoop {
      pairsArray.append((dots.last!, dots.first!))
    }
    return pairsArray
  }
}
