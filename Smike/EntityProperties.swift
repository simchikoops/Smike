import SpriteKit
import GameplayKit

extension GKEntity {
    var node: SKNode {
        if let node = component(ofType: GKSKNodeComponent.self)?.node {
            return node
        } else if let node = component(ofType: RenderComponent.self)?.spriteNode {
            return node
        } else {
            return SKNode() // sketchy fallback
        }
    }
    
    var depth: CGFloat {
        return component(ofType: DepthComponent.self)?.depth ?? 0.0
    }
    
    var printNode: SKNode? {
        return node["/Print"].first
    }
}
