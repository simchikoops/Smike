import SpriteKit
import GameplayKit

class RailComponent: GKComponent {
  @GKInspectable var rawType: Int = 0
  
  var type: RailType = .rock

  override class var supportsSecureCoding: Bool {
    true
  }
  
  override func didAddToEntity() {
    self.type = RailType(rawValue: rawType)!
    
    if let track = Track.fromNodes(headNode: entity!.node) {
      let physicsBody = SKPhysicsBody(edgeChainFrom: track.asCGPath())
      
      physicsBody.restitution = type.restitution
      physicsBody.friction = type.friction
      
      entity!.node.physicsBody = physicsBody
    }
  }
}
