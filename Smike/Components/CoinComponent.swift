import SpriteKit
import GameplayKit

class CoinComponent: GKComponent, Tappable {
  var dispenser: DispenserComponent
  
  var type: CoinType { dispenser.coinType }
  var startingPosition: CGPoint { dispenser.entity!.node.position }
  var layer: CGFloat { dispenser.awayLayer }
  var minY: CGFloat { dispenser.minY }
  
  init(dispenser: DispenserComponent) {
    self.dispenser = dispenser
    
    super.init()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override class var supportsSecureCoding: Bool {
    true
  }
  
  override func didAddToEntity() {
    let nodeComponent = NodeComponent(imageNamed: type.imageName, position: startingPosition, depth: 0.0, layer: layer)
    
    entity!.addComponent(nodeComponent)
    let node = entity!.node
    
    let physicsBody = SKPhysicsBody(circleOfRadius: node.frame.width / 2)
    
    physicsBody.isDynamic = true
    physicsBody.affectedByGravity = true
    physicsBody.allowsRotation = true
    physicsBody.mass = 0.005 // kg
    physicsBody.linearDamping = 1.0 // air resistance? small effect
    
    node.physicsBody = physicsBody
  }
  
  override func update(deltaTime seconds: TimeInterval) {
    if let node = entity?.node, node.position.y < minY {
      entity!.remove()
    }
  }
  
  // TODO: better than point-in-rect.
  func isTappedAt(scenePoint: CGPoint) -> Bool {
    return true
  }
  
  func tapped() {
    if let scene = entity?.scene {
      if type.power > 0 {
        scene.attackPower += type.power
        
        let position = entity!.printNode!.convert(entity!.node.position, from: entity!.node.parent!)
        scene.addContextLabel(printPosition: position, text: "+\(type.power)", color: .blue)
      }
    }
    entity!.remove()
  }
}
