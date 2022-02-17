import SpriteKit
import GameplayKit

class RailComponent: GKComponent {
  override class var supportsSecureCoding: Bool {
    true
  }
  
  override func didAddToEntity() {
    if let track = Track.fromNodes(headNode: entity!.node) {
      let physicsBody = SKPhysicsBody(edgeChainFrom: track.asCGPath())
      entity!.node.physicsBody = physicsBody
    }
  }
}
