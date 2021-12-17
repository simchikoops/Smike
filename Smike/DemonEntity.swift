import SpriteKit
import GameKit

class DemonEntity: GKEntity {
  init(type: DemonType, track: Track, originNode: SKNode) {
    super.init()
    
    print(type, track)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
