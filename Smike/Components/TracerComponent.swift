import SpriteKit
import GameplayKit

class TracerComponent: GKComponent {
  @GKInspectable var speed: CGFloat = 1.0
  @GKInspectable var startsAlong: CGFloat = 0.0
  @GKInspectable var facesLeft: Bool = false
  @GKInspectable var facingFrozen: Bool = false
  
  var positionOffset: CGVector = CGVector(dx: 0, dy: 0)
  var baseDepth: CGFloat = 1.0
  var alongTrack: CGFloat = 0.0
  
  var path: PathComponent? {
    entity?.node.parent?.entity?.component(ofType: PathComponent.self)
  }

  override class var supportsSecureCoding: Bool {
    true
  }
  
  override func didAddToEntity() {
    guard let node = entity?.node, let track = path?.track else { return }
     
    alongTrack = startsAlong
    let (position, depth, _, _) = track.fixFractionAlong(alongTrack)

    positionOffset = CGVector(dx: node.position.x - position.x, dy: node.position.y - position.y)
    baseDepth = depth
  }
  
  override func update(deltaTime seconds: TimeInterval) {
    guard let path = path, let track = path.track else { return }
    guard let node = entity?.node as? SKSpriteNode else { return }
    
    let increment = (seconds / path.duration) * speed
    alongTrack += increment
    
    if alongTrack >= 1.0 {
      switch path.type {
      case .loop:
        alongTrack = alongTrack.truncatingRemainder(dividingBy: 1.0)
      case .jump:
        alongTrack = 0.0
      case .terminal:
        entity!.remove()
        return
      case .simple:
        return
      }
    }
    
    var (position, depth, layer, facing) = track.fixFractionAlong(alongTrack)
    
    position.x += positionOffset.dx
    position.y += positionOffset.dy

    node.position = position
    node.depth = baseDepth == 0 ? depth : 1 - (depth / baseDepth)
    node.zPosition = layer
    
    if !facingFrozen {
      node.facing = facesLeft ? facing.opposite : facing
    }
  }
}
