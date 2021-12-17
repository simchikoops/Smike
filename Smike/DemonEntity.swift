import SpriteKit
import GameKit

class DemonEntity: GKEntity {
  let type: DemonType
  let track: Track
  
  init(type: DemonType, track: Track, originNode: SKNode) {
    self.type = type
    self.track = track
    
    super.init()
    
    let dot = track.dotAlong(0)
    print(dot)
    let renderComponent = RenderComponent(imageNamed: type.imageName, position: dot.position, depth: dot.depth, layer: dot.layer)
    
    addComponent(renderComponent)
    originNode.parent!.addChild(node)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
