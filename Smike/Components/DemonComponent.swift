import SpriteKit
import GameplayKit

enum DemonType: Int {
  case bat = 1
  
  var imageName: String {
    switch self {
    case .bat: return "bat"
    }
  }

  var speed: CGFloat {
    switch self {
    case .bat: return 75.0
    }
  }
}

class DemonComponent: GKComponent {
  let type: DemonType
  let track: Track

  var alongTrack: CGFloat = 0
  
  init(type: DemonType, track: Track) {
    self.type = type
    self.track = track
    
    super.init()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override class var supportsSecureCoding: Bool {
    true
  }
  
  var demonEntity: DemonEntity {
    entity! as! DemonEntity
  }
  
  override func update(deltaTime seconds: TimeInterval) {
    guard let node = entity?.node as? SKSpriteNode else { return }
    
    let speed = type.speed
    alongTrack = (alongTrack + (speed * seconds)).clamped(to: 0...track.distance)
    
    let (position, depth, layer) = track.dotAlong(alongTrack)
    node.position = position
    node.depth = depth
    node.zPosition = layer
  }
}
