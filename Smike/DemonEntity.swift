import SpriteKit
import GameKit

class DemonEntity: GKEntity {
  init(type: DemonType, path: [DemonDotComponent], originNode: SKNode) {
    super.init()
    
    print(type)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
