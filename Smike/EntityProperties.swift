import SpriteKit
import GameplayKit

extension GKEntity {
  var node: SKNode {
    if let node = component(ofType: RenderComponent.self)?.spriteNode {
      return node
    } else if let node = component(ofType: GKSKNodeComponent.self)?.node {
      return node
    } else {
      return SKNode()
    }
  }
  
  var scene: LevelScene {
    return node.scene as! LevelScene
  }
  
  var baseNode: SKNode {
    if let node = component(ofType: GKSKNodeComponent.self)?.node {
      return node
    } else {
      return SKNode()
    }
  }
  
  var depth: CGFloat {
    return component(ofType: DepthComponent.self)?.depth ?? 0.0
  }
  
  var layer: CGFloat {
    return component(ofType: DepthComponent.self)?.layer ?? Layer.normal.rawValue
  }
  
  var printNode: SKNode? {
    return scene["print"].first
  }
  
  var heroComponent: HeroComponent? {
    return component(ofType: HeroComponent.self)
  }
}
