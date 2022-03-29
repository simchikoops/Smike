import SpriteKit
import GameplayKit

class LevelComponent: GKComponent {
  @GKInspectable var mortalAllowance: Int = 0
  @GKInspectable var startingAttackPower: Int = 0
  
  var mortalsRemaining: Int = 0 {
    didSet {
      mortalsRemainingCount?.text = String(mortalsRemaining)
      mortalsRemainingCount?.fontColor = mortalsRemaining <= 1 ? .red : .black
    }
  }
  
  var attackPower: Int = 0 {
    didSet { attackPowerCount?.text = String(attackPower) }
  }

  private var attackPowerCount: SKLabelNode?
  private var mortalsRemainingCount: SKLabelNode?
    
  override class var supportsSecureCoding: Bool {
    true
  }
  
  override func didAddToEntity() {
    guard let entity = entity else { return }
    let scene = entity.scene
    
    scene.live = false
    
    self.attackPowerCount = scene.childNode(withName: "//attack_power_count") as? SKLabelNode
    self.mortalsRemainingCount = scene.childNode(withName: "//mortals_remaining_count") as? SKLabelNode

    self.mortalsRemaining = mortalAllowance
    self.attackPower = startingAttackPower
    
    if let print = entity.scene["print"].first as? SKSpriteNode {
      let shake = SKAction.shake(initialPosition: print.position, duration: 0.4)
      print.run(SKAction.sequence([SKAction.wait(forDuration: 2.5), shake]))
    }
     
    entity.scene.run(SKAction.sequence([SKAction.wait(forDuration: 3.0), // contemplate the picture
                                        SKAction.run { entity.scene.live = true }]))

  }
  
  func checkForWin() {
    guard let scene = entity?.scene else { return }
    guard scene.generators.allSatisfy({ $0.component(ofType: GeneratorComponent.self)!.exhausted })
      else { return }
      
    print("WON LEVEL")
    Slot.live.completedLevels.insert(scene.name!)
      
    // TODO: report victory
      
    Router.it.navigateFrom(scene.name!, completed: true)
  }
  
  func checkForLoss() {
    guard mortalsRemaining <= 0 else { return }

    print("LOST LEVEL")

    if let name = entity?.scene.name {
      Router.it.navigateFrom(name, completed: false)
    }
  }
}
