import SpriteKit
import GameplayKit

class AnimationComponent: GKComponent {
  @GKInspectable var speed: CGFloat = 1.0
  
  var alongTrack: CGFloat = 0
  
  var loop: LoopComponent? {
    entity?.node.parent?.entity?.component(ofType: LoopComponent.self)
  }

  override class var supportsSecureCoding: Bool {
    true
  }
  
  override func update(deltaTime seconds: TimeInterval) {
    guard let loop = loop, let track = loop.track else { return }
    guard let node = entity?.node as? SKSpriteNode else { return }
    
    let increment = (seconds / loop.duration) * track.distance
    alongTrack += increment
    
    let loopDistance = alongTrack.truncatingRemainder(dividingBy: track.distance)
    let (position, depth, layer, facing) = track.dotAlong(loopDistance)
    
    node.position = position
    node.depth = depth
    node.zPosition = layer
    node.facing = facing
  }
}
