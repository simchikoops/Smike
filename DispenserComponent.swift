import SpriteKit
import GameplayKit

class DispenserComponent: GKComponent {
  @GKInspectable var rawCoinType: Int = 0
  @GKInspectable var sequenceJSON: String = ""
  @GKInspectable var probability: CGFloat = 1.0

  @GKInspectable var startingVector: CGPoint = CGPoint()
  @GKInspectable var awayLayer: CGFloat = 0
  @GKInspectable var minY: CGFloat = 0
  
  var coinType: CoinType = .bronzeMon
  var sequence: [CGFloat] = []
  
  override class var supportsSecureCoding: Bool {
    true
  }

  override func didAddToEntity() {
    entity!.node.isHidden = true // just a visual placeholder
    
    let sequenceData = sequenceJSON.data(using: .utf8)!
    self.sequence = try! JSONSerialization.jsonObject(with: sequenceData, options: []) as! [CGFloat]
    
    self.coinType = CoinType(rawValue: rawCoinType)!
  }
  
  override func update(deltaTime seconds: TimeInterval) {
    guard let ticks = sequence.first else { return }
    guard entity!.scene.ticks >= ticks else { return }
    
    sequence.removeFirst()
    conditionallyDispense()
  }

  private func conditionallyDispense() {
    guard GameScene.random.nextUniform() <= Float(probability) else { return }

    let coin = GKEntity()
    let coinComponent = CoinComponent(dispenser: self)
    coin.addComponent(coinComponent)

    entity!.scene.entities.append(coin)
    entity!.node.parent!.addChild(coin.node)
    
    coin.node.physicsBody!.applyForce(CGVector(dx: startingVector.x, dy: startingVector.y))
  }
}
