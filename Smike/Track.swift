import SpriteKit
import Algorithms

typealias TrackDot = (position: CGPoint, depth: CGFloat, layer: CGFloat)

struct Track {
  let dots: [ TrackDot ]
  let distance: CGFloat
  
  init(orderedDots: [ TrackDot ] ) {
    assert(orderedDots.count >= 2, "Not enough dots in track")
    
    dots = orderedDots
    distance = Track.calculateDistance(dots: dots)
  }
  
  static func fromNodes(headNode: SKNode) -> Track? {
    guard let printNode = headNode.entity!.printNode else { return nil }
    
    var trackNodes = headNode.children.filter { node in
      node.entity!.component(ofType: TrackDotComponent.self) != nil
    }
    
    trackNodes.sort {
      $0.entity!.component(ofType: TrackDotComponent.self)!.seq < $1.entity!.component(ofType: TrackDotComponent.self)!.seq
    }

    let trackDots = trackNodes.map {
      (position: headNode.convert($0.position, to: printNode),
       depth: $0.entity!.component(ofType: TrackDotComponent.self)!.depth,
       layer: $0.zPosition)
    }
    
    trackNodes.forEach { $0.removeFromParent() }
    return Track(orderedDots: trackDots)
  }
  
  static func calculateDistance(dots: [TrackDot]) -> CGFloat {
    dots.adjacentPairs().map { $0.0.position.distance(to: $0.1.position) }.reduce(0, +)
  }
  
  func asCGPath() -> CGPath {
    let path = CGMutablePath()
    
    path.move(to: dots.first!.position)
    dots.dropFirst().forEach { path.addLine(to: $0.position) }
    
    return path
  }
    
  func dotAlong(_ distanceAlong: CGFloat) -> TrackDot {
    assert(distanceAlong >= 0 && distanceAlong <= distance, "Along out of range.")
    
    var distanceCovered = 0.0
    
    // find segment and segmentAlong
    for (from, to) in dots.adjacentPairs() {
      let segmentLength = CGFloat(hypotf(Float(to.position.x - from.position.x),
                                         Float(to.position.y - from.position.y)))
        
      if distanceCovered + segmentLength >= distanceAlong {
        let segmentRemaining = distanceAlong - distanceCovered
        let ratio = segmentRemaining / segmentLength
         
        let position = CGPoint(x: (1 - ratio) * from.position.x + (ratio * to.position.x),
                                y: (1 - ratio) * from.position.y + (ratio * to.position.y))
        let depth = from.depth + (to.depth - from.depth) * ratio
        let layer = from.layer
         
        return (position, depth, layer)
      } else {
        distanceCovered += segmentLength
      }
    }

    return dots.last! // underflow
  }
  
  func dotFractionAlong(_ fractionAlong: CGFloat) -> TrackDot {
    return dotAlong(fractionAlong * distance)
  }
}
