import SpriteKit
import GameplayKit

class NetDotComponent: GKComponent {
  // zero, one, or two edges in each direction
  @GKInspectable var pos0: Int = 0 // connection in positive (up) direction
  @GKInspectable var pos1: Int = 0
  @GKInspectable var neg0: Int = 0
  @GKInspectable var neg1: Int = 0
  
  @GKInspectable var posTerm: Bool = false // positive paths terminate here
  @GKInspectable var negTerm: Bool = false
  
  var positiveEdges: [NetDotComponent] = []
  var negativeEdges: [NetDotComponent] = []
  
  override func didAddToEntity() {
    if pos0 > 0 { positiveEdges.append(lookupEdge(pos0)) }
    if pos1 > 0 { positiveEdges.append(lookupEdge(pos1)) }
    if neg0 > 0 { negativeEdges.append(lookupEdge(neg0)) }
    if neg1 > 0 { negativeEdges.append(lookupEdge(neg1)) }
  }
  
  override class var supportsSecureCoding: Bool {
    true
  }
  
  private func lookupEdge(_ number: Int) -> NetDotComponent {
    let n = entity!.printNode!["dd_\(number)"].first!
    return n.entity!.component(ofType: NetDotComponent.self)!
  }
}
