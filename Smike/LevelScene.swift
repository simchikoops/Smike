import SpriteKit
import GameplayKit

class LevelScene: GameScene {
  
  var heroes: [GKEntity] = []
  var demons: [GKEntity] = []
  var mortals: [GKEntity] = []
  var generators: [GKEntity] = []
  
  var live: Bool = false
  var ticks: CGFloat = 0.0
  var focusHero: GKEntity?
  var heroControlXRef: CGFloat?
  
  private var lastUpdateTime: TimeInterval = 0
  private var tapRecognizer: UITapGestureRecognizer? = nil
    
  override func sceneDidLoad() {
    physicsWorld.contactDelegate = self

    self.lastUpdateTime = 0
    self.live = false
  }
  
  // Load finished callback.
  override func didMove(to view: SKView) {
    super.didMove(to: view)
    
    tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapped(_:)))
    view.addGestureRecognizer(tapRecognizer!)
    
    heroes.sort {
      $0.heroComponent!.index < $1.heroComponent!.index
    }
    if let hero = heroes.first {
      selectHero(hero)
    } else {
      print("Level \(String(describing: name)) has no heroes")
    }
    
    titleCard("protect the mortals!", duration: 3.0) { [unowned self] in self.live = true }
  }
  
  override func willMove(from view: SKView) {
    if let t = tapRecognizer {
      view.removeGestureRecognizer(t)
    }
  }
  
  func checkWhetherDemonsDefeated() {
    if demons.isEmpty && generators.allSatisfy({
      $0.component(ofType: GeneratorComponent.self)!.exhausted
    }) {
      if let name = self.name {
        print("Demons are defeated!")
        Slot.live.completedLevels.insert(name)
        // TODO: report victory
        Router.it.navigateFrom(name, completed: true)
      }
    }
  }
  
  func checkWhetherHeroesDefeated() {
    if mortals.isEmpty {
      print("Heroes are defeated!")
      // TODO: report defeat
      if let name = self.name {
        Router.it.navigateFrom(name, completed: false)
      }
    }
  }
  
  func selectHero(_ hero: GKEntity) {
    focusHero?.heroComponent?.moving = .stopped
    focusHero?.heroComponent?.hasFocus = false
    
    self.focusHero = hero
    focusHero?.heroComponent?.hasFocus = true
  }
  
  private func heroControlNode(_ nodes: [SKNode]) -> SKNode? {
    return nodes.first(where: { $0.name?.hasPrefix("hero_control") ?? false })
  }
  
  private func heroControlIndex(_ node: SKNode) -> Int? {
    if let indexStr = node.name!.components(separatedBy: "_").last {
      return Int(indexStr) ?? focusHeroIndex
    } else {
      return nil
    }
  }
  
  @objc func tapped(_ tap: UITapGestureRecognizer) {
    if tap.state != .ended { return }
      
    let viewPoint = tap.location(in: tap.view)
    let scenePoint = convertPoint(fromView: viewPoint)
    let tapNodes = nodes(at: scenePoint)
    
    if let controlNode = heroControlNode(tapNodes) {
      if let index = heroControlIndex(controlNode) {
        if index != focusHeroIndex {
          selectHero(heroes[index])
        }
        focusHero?.heroComponent?.attack()
      }
    } else if tapNodes.first(where: { $0.name == "play_pause" }) != nil {
      self.isPaused = !self.isPaused
      self.lastUpdateTime = 0
      
      if let button = self["//play_pause"].first as? SKSpriteNode {
        button.texture = SKTexture(imageNamed: (self.isPaused ? "play" : "pause"))
      }
    }
  }
  
  var focusHeroIndex: Int? {
    return heroes.firstIndex(of: focusHero!)
  }
  
  func touchDown(atPoint pos : CGPoint) {
    let touchedNodes = nodes(at: pos)
    
    if let controlNode = heroControlNode(touchedNodes) {
      if let index = heroControlIndex(controlNode), index != focusHeroIndex {
        selectHero(heroes[index])
      }
      heroControlXRef = pos.x
    }
  }
  
  func touchMoved(toPoint pos : CGPoint) {
    if let xRef = heroControlXRef {
      focusHero?.heroComponent?.moving = pos.x < xRef ? .toLeft : .toRight
    }
  }
  
  func touchUp(atPoint pos : CGPoint) {
    heroControlXRef = nil
    focusHero?.heroComponent?.moving = .stopped
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
