import SpriteKit
import GameplayKit

class LevelScene: GameScene {
  
  var generators: [GKEntity] = []
  var mortals: [GKEntity] = []
  
  var live: Bool = false // can't use isPaused for initial dealy
  var ticks: CGFloat = 0.0
  
  var mortalAllowanceRemaining: Int = 0
  
  var attackPower: Int = 0 {
    didSet { attackPowerCount?.text = String(attackPower) }
  }
  var pinches: Int = 0
  var swipes: Int = 0
  
  private var lastUpdateTime: TimeInterval = 0
  private var tapRecognizer: UITapGestureRecognizer? = nil
  
  private var attackPowerCount: SKLabelNode?
    
  override func sceneDidLoad() {
    physicsWorld.contactDelegate = self

    self.lastUpdateTime = 0
    self.live = false
  }
  
  // Load finished callback.
  override func didMove(to view: SKView) {
    super.didMove(to: view)

    self.attackPowerCount = self.childNode(withName: "//attack_power_count") as? SKLabelNode

    if let level = self.entity?.component(ofType: LevelComponent.self) {
      self.mortalAllowanceRemaining = level.mortalAllowance
      self.attackPower = level.startingAttackPower
    }
    
    tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapped(_:)))
    view.addGestureRecognizer(tapRecognizer!)
    
    if let print = self["print"].first as? SKSpriteNode {
      let shake = SKAction.shake(initialPosition: print.position, duration: 0.4)
      print.run(SKAction.sequence([SKAction.wait(forDuration: 2.5), shake]))
    }
     
    run(SKAction.sequence([SKAction.wait(forDuration: 3.0), // contemplate the picture
                           SKAction.run { self.live = true }]))
  }
  
  override func willMove(from view: SKView) {
    if let t = tapRecognizer {
      view.removeGestureRecognizer(t)
    }
  }
  
  func nearestLivingMortal(scenePosition: CGPoint) -> GKEntity? {
    mortals
      .filter({ !$0.component(ofType: MortalComponent.self)!.dying })
      .sorted {
        let d0 = convert($0.node.position, from: $0.node.parent!).distance(to: scenePosition)
        let d1 = convert($1.node.position, from: $1.node.parent!).distance(to: scenePosition)
        return d0 < d1
      }
      .first
  }
  
  func checkForWin() {
    guard generators.allSatisfy({ $0.component(ofType: GeneratorComponent.self)!.exhausted }) else { return }
      
    print("WON LEVEL")
    Slot.live.completedLevels.insert(name!)
      
    // TODO: report victory
      
    Router.it.navigateFrom(name!, completed: true)
  }
  
  func checkForLoss() {
    guard mortalAllowanceRemaining <= 0 else { return }

    print("LOST LEVEL")

    if let name = self.name {
      Router.it.navigateFrom(name, completed: false)
    }
  }
    
  func powerStrike() {
    guard live else { return }
    
    // TODO -- check enough, use up, enact
    print("POWER STRIKE")
  }
  
  @objc func tapped(_ tap: UITapGestureRecognizer) {
    if tap.state != .ended { return }
      
    let viewPoint = tap.location(in: tap.view)
    let scenePoint = convertPoint(fromView: viewPoint)
    let tapNodes = nodes(at: scenePoint)
    
    if tapNodes.first(where: { $0.name == "play_pause" }) != nil {
      self.isPaused = !self.isPaused
      self.lastUpdateTime = 0
      
      if let button = self["//play_pause"].first as? SKSpriteNode {
        button.texture = SKTexture(imageNamed: (self.isPaused ? "play" : "pause"))
      }
    } else if !self.isPaused {
      if let tappable = tappedEntity(nodes: tapNodes, scenePoint: scenePoint) {
        tappable.component(conformingTo: Tappable.self)!.tapped()
      }
    }
  }
  
  func tappedEntity(nodes: [SKNode], scenePoint: CGPoint) -> GKEntity? {
    nodes.filter {
      if let tappable = $0.entity?.component(conformingTo: Tappable.self) {
        return tappable.isTappedAt(scenePoint: scenePoint)
      } else {
        return false
      }
    }.sorted { $0.zPosition < $1.zPosition }
    .last?.entity
  }
      
  func touchDown(atPoint pos : CGPoint) {
    // let touchedNodes = nodes(at: pos)
  }
  
  func touchMoved(toPoint pos : CGPoint) {
  }
  
  func touchUp(atPoint pos : CGPoint) {
  }
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    for t in touches { self.touchDown(atPoint: t.location(in: self)) }
  }
  
  override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
    for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
  }
  
  override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    for t in touches { self.touchUp(atPoint: t.location(in: self)) }
  }
  
  override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
    for t in touches { self.touchUp(atPoint: t.location(in: self)) }
  }
  
  override func update(_ currentTime: TimeInterval) {
    guard live else { return }
    // Called before each frame is rendered
      
    // Initialize _lastUpdateTime if it has not already been
    if (self.lastUpdateTime == 0) {
      self.lastUpdateTime = currentTime
    }
      
    // Calculate time since last update
    let dt = currentTime - self.lastUpdateTime
      
    // Update entities
    for entity in self.entities {
      entity.update(deltaTime: dt)
    }
      
    self.ticks += dt
    self.lastUpdateTime = currentTime
  }
}
