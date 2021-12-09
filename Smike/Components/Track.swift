import SpriteKit
import Algorithms

struct Track {
    let dots: [ (position: CGPoint, depth: CGFloat) ]
    
    init(dots: [ (position: CGPoint, depth: CGFloat) ] ) {
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
}
