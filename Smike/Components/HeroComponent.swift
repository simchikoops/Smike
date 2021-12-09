import SpriteKit
import GameplayKit

class HeroComponent: GKComponent {
    @GKInspectable var type: String = ""
    
    var track: Track?

    override func didAddToEntity() {
        var trackNodes = entity!.node.children.filter { node in
            if let name = node.name {
              return name.starts(with: "PT")
            } else {
              return false
            }
        }
        
        trackNodes.sort { $0.name! < $1.name! }
        
        if let printNode = entity!.printNode {
            let trackDots = trackNodes.map {
                (position: entity!.node.convert($0.position, to: printNode), depth: $0.entity!.depth)
            }
            track = Track(dots: trackDots)
        }
        
        print(track!)
    }
    
    override class var supportsSecureCoding: Bool {
      true
    }
}
