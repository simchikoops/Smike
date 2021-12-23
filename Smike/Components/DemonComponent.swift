import SpriteKit
import GameplayKit

enum DemonType: Int {
  case bat = 1
  case devil = 2
  
  var imageName: String {
    switch self {
    case .bat: return "bat"
    case .devil: return "devil"
    }
  }

  var speed: CGFloat {
    switch self {
    case .bat: return 75.0
    case .devil: return 10.0
    }
  }
  
  var hp: Int {
    switch self {
    case .bat: return 20
    case .devil: return 100
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
  
  override func didAddToEntity() {
    let dot = track.dotAlong(0)
    let nodeComponent = NodeComponent(imageNamed: type.imageName, position: dot.position, depth: dot.depth, layer: dot.layer)
    
    entity!.addComponent(nodeComponent)
    
    if let node = entity!.node as? SKSpriteNode {
      let physicsBody = SKPhysicsBody(rectangleOf: node.size)

      physicsBody.affectedByGravity = false
      physicsBody.allowsRotation = false
      physicsBody.isDynamic = false // alow overlaps

      physicsBody.categoryBitMask = PhysicsInfo.demon.categoryBitMask
      physicsBody.contactTestBitMask = PhysicsInfo.demon.contactTestBitMask

      node.physicsBody = physicsBody
    }
    
    let healthComponent = HealthComponent()
    healthComponent.hp = type.hp
    entity!.addComponent(healthComponent)
  }
    
  override func update(deltaTime seconds: TimeInterval) {
    
    progress(deltaTime: seconds)
  }
  
  func progress(deltaTime seconds: TimeInterval) {
    guard let node = entity?.node as? SKSpriteNode else { return }
    
    let speed = type.speed
    alongTrack = (alongTrack + (speed * seconds)).clamped(to: 0...track.distance)
    
    let (position, depth, layer) = track.dotAlong(alongTrack)
    node.position = position
    node.depth = depth
    node.zPosition = layer
  }
  
  func dispell() {
    entity!.scene.demons.remove(object: entity!)
    // TODO: check scene completion
    entity!.remove()
  }
}
