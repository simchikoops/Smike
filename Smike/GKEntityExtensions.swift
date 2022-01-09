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
  
  var scene: LevelScene {
    return node.scene as! LevelScene
  }
  
  var printNode: SKNode? {
    return scene["print"].first
  }
    
  var depth: CGFloat {
    return component(ofType: DepthComponent.self)?.depth ?? 0.0
  }
  
  var layer: CGFloat {
    return component(ofType: DepthComponent.self)?.layer ?? Layer.normal.rawValue
  }
  
  var heroComponent: HeroComponent? {
    return component(ofType: HeroComponent.self)
  }
  
  var healthComponent: HealthComponent? {
    return component(ofType: HealthComponent.self)
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
