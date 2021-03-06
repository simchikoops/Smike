import SpriteKit
import GameplayKit

extension GKEntity {
  var node: SKNode {
    if let node = component(ofType: NodeComponent.self)?.node {
      return node
    } else if let node = component(ofType: GKSKNodeComponent.self)?.node {
      return node
    } else {
      assert(false, "Entity has no node.")
      return SKNode()
    }
  }
  
  var spriteNode: SKSpriteNode {
    return node as! SKSpriteNode
  }
  
  var scene: ActionScene {
    return node.scene as! ActionScene
  }
  
  var printNode: SKNode? {
    return scene["print"].first
  }
    
  func component<P>(conformingTo protocol: P.Type) -> P? {
    for component in components {
      if let p = component as? P {
        return p
      }
    }

    return nil
  }
  
  func remove() {
    scene.entities.remove(object: self)
    node.removeFromParent()
  }
}
