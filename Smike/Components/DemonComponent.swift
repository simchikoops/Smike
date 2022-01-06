import SpriteKit
import GameplayKit

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
    let canAttack = entity!.scene.ticks - lastAttackTicks > type.minimumAttackInterval
    let unimpairedHeroes = entity!.scene.heroes.filter { !$0.heroComponent!.impaired }
    
    if let mortal = target(list: entity!.scene.mortals) {
      if (canAttack) { attack(mortal) }
    } else if let hero = target(list: unimpairedHeroes) {
      if (canAttack) { attack(hero) }
      progress(deltaTime: seconds)
    } else {
      progress(deltaTime: seconds)
    }
  }
  
  func attack(_ target: GKEntity) {
    switch type.attack {
    case .missile:
      let attack = GKEntity()
      entity!.scene.entities.append(attack)
      
      var startingPosition = entity!.spriteNode.position
      startingPosition.y += type.attackOrigin.y
      startingPosition.x += entity!.spriteNode.facing == .right ? type.attackOrigin.y : -type.attackOrigin.y
      
      let attackComponent = MissileAttackComponent(originSprite: entity!.spriteNode, physics: PhysicsInfo.demonAttack, imageName: type.attackImage!, startingPosition: startingPosition, power: type.attackPower, speed: type.attackSpeed!)
      attack.addComponent(attackComponent)
      
      entity!.printNode!.addChild(attack.node)
      attackComponent.launch(vector: attackVector(origin: startingPosition, target: target))
    case .thrust:
      if let component = target.component(ofType: HealthComponent.self) {
        component.damage(points: type.attackPower)
      }
    }
    lastAttackTicks = entity!.scene.ticks
  }
  
  func target(list: [GKEntity]) -> GKEntity? {
    if let nearest = nearestTargetableEntityAndDistance(list: list) {
      return nearest.distance <= type.attackRange ? nearest.entity : nil
    } else {
      return nil
    }
  }
  
  func nearestTargetableEntityAndDistance(list: [GKEntity]) -> (entity: GKEntity, distance: CGFloat)? {
    let ownPosition = entity!.node.position
    
    return list.filter { isWithinAttackAngle(position: ownPosition, otherPosition: $0.node.position) }
      .map { (entity: $0, distance: ownPosition.distance(to: $0.node.position)) }
      .sorted { $0.distance < $1.distance }
      .first
  }
  
  func isWithinAttackAngle(position: CGPoint, otherPosition: CGPoint) -> Bool {
    var rad = atan2(otherPosition.y - position.y, otherPosition.x - position.x)
    if (rad < 0) { rad += .pi * 2.0 }
    
    let deg = rad.toDegrees()
    let angle = entity!.spriteNode.facing == .right ? type.attackAngle : reversedAngle(type.attackAngle)
    
    return angle.contains(deg) || angle.contains(deg + 360)
  }
  
  func reversedAngle(_ angle: ClosedRange<Int>) -> ClosedRange<Int> {
    var newLowerBound = 180 - angle.lowerBound
    if newLowerBound < 0 { newLowerBound += 360}
    
    var newUpperBound = 180 - angle.upperBound
    if newUpperBound < 0 { newUpperBound += 360}
    
    let bounds = [newLowerBound, newUpperBound].sorted()

    return bounds.first!...bounds.last!
  }
  
  func attackVector(origin: CGPoint, target: GKEntity) -> CGVector {
    return CGVector(dx: target.node.position.x - origin.x,
                    dy: target.node.position.y - origin.y)
  }
  
  func progress(deltaTime seconds: TimeInterval) {
    guard let node = entity?.node as? SKSpriteNode else { return }
    
    let speed = type.speed
    alongTrack = (alongTrack + (speed * seconds)).clamped(to: 0...track.distance)
    
    let (position, depth, layer, facing) = track.dotAlong(alongTrack)
    node.position = position
    node.depth = depth
    node.zPosition = layer
    node.facing = facing
  }
  
  func dispell() {
    entity!.scene.demons.remove(object: entity!)
    // TODO: check scene completion
    entity!.remove()
  }
}
