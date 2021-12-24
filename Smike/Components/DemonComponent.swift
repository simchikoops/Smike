import SpriteKit
import GameplayKit

typealias DemonValues = (imageName: String, speed: CGFloat, hp: Int, attackRange: CGFloat, minimumAttackInterval: CGFloat)
let batValues: DemonValues = (imageName: "bat", speed: 75, hp: 20, attackRange: 200, minimumAttackInterval: 4.0)
let devilValues: DemonValues = (imageName: "devil", speed: 15, hp: 100, attackRange: 90, minimumAttackInterval: 2.0)

enum DemonType: Int {
  case bat = 1
  case devil = 2
  
  var values: DemonValues {
    switch self {
    case .bat: return batValues
    case .devil: return devilValues
    }
  }
  
  var imageName: String { values.imageName }
  var speed: CGFloat { values.speed }
  var hp: Int { values.hp }
  var attackRange: CGFloat { values.attackRange }
  var minimumAttackInterval: CGFloat { values.minimumAttackInterval }
}

class DemonComponent: GKComponent {
  let type: DemonType
  let track: Track

  var alongTrack: CGFloat = 0
  var lastAttackTicks: CGFloat = 0.0
  
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
    if let nearest = nearestEntityAndDistance(list: entity!.scene.mortals),
       nearest.distance <= type.attackRange,
       entity!.scene.ticks - lastAttackTicks > type.minimumAttackInterval {
      attack(nearest.entity)
    } else {
      progress(deltaTime: seconds)
    }
  }
  
  func attack(_ target: GKEntity) {
    print("ATTACK", target)
    lastAttackTicks = entity!.scene.ticks
  }
  
  func nearestEntityAndDistance(list: [GKEntity]) -> (entity: GKEntity, distance: CGFloat)? {
    let ownPosition = entity!.node.position
    
    return list.map { (entity: $0, distance: ownPosition.distance(to: $0.node.position)) }
      .sorted { $0.distance < $1.distance }
      .first
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
