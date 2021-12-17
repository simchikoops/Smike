import SpriteKit
import Algorithms

typealias TrackDot = (position: CGPoint, depth: CGFloat, layer: CGFloat)

struct Track {
  let dots: [ TrackDot ]
  
  init(dots: [ TrackDot ] ) {
    assert(dots.count >= 2, "Not enough dots in track")
    self.dots = dots
  }
  
  var distance: CGFloat {
    get {
      return dots.adjacentPairs().map { pair in
        CGFloat(hypotf(Float(pair.1.position.x - pair.0.position.x),
                       Float(pair.1.position.y - pair.0.position.y)))
      }.reduce(0, +)
    }
  }
  
  func asCGPath() -> CGPath {
    let path = CGMutablePath()
    
    path.move(to: dots.first!.position)
    dots.dropFirst().forEach { path.addLine(to: $0.position) }
    
    return path
  }
    
  func dotAlong(_ along: CGFloat) -> TrackDot {
    assert(along >= 0 && along <= 1, "Along out of range.")
    
    let distanceAlong = along * distance
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
}