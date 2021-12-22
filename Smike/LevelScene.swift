import SpriteKit
import GameplayKit

class LevelScene: SKScene {
    
  var entities = [GKEntity]()
  
  var heroes: [GKEntity] = []
  var demons: [GKEntity] = []
  var generators: [GKEntity] = []
  var mortals: [GKEntity] = []
  
  var ticks: CGFloat = 0.0
  var focusHero: GKEntity?
  var heroControlXRef: CGFloat?
  
  private var lastUpdateTime: TimeInterval = 0
  private var tapRecognizer: UITapGestureRecognizer? = nil
    
  override func sceneDidLoad() {
    self.lastUpdateTime = 0
    physicsWorld.contactDelegate = self
  }
  
  // Load finished callback.
  override func didMove(to view: SKView) {
    super.didMove(to: view)
    
    for generator in generators {
      generator.component(ofType: GeneratorComponent.self)!.calculatePaths()
    }
    
    heroes.sort {
      $0.heroComponent!.index < $1.heroComponent!.index
    }
    selectHero(heroes.first!)
  }
  
  override func willMove(from view: SKView) {
    if let t = tapRecognizer {
      view.removeGestureRecognizer(t)
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
      return Int(indexStr)
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
        selectHero(heroes[index])
      }
      focusHero?.heroComponent?.attack()
    } else if tapNodes.first(where: { $0.name == "attack" }) != nil {
      focusHero?.heroComponent?.attack()
    } else if tapNodes.first(where: { $0.name == "next_hero" }) != nil {
      selectNextHero()
    } else if tapNodes.first(where: { $0.name == "play_pause" }) != nil {
      self.isPaused = !self.isPaused
      self.lastUpdateTime = 0
      
      if let button = self["//play_pause"].first as? SKSpriteNode {
        button.texture = SKTexture(imageNamed: (self.isPaused ? "play" : "pause"))
      }
    }
  }
  
  func selectNextHero() {
    if let focusHeroIndex = heroes.firstIndex(of: focusHero!) {
      selectHero(heroes[focusHeroIndex + 1 < heroes.count ? focusHeroIndex + 1 : 0 ])
    }
  }
  
  func touchDown(atPoint pos : CGPoint) {
    let touchedNodes = nodes(at: pos)
    
    if let controlNode = heroControlNode(touchedNodes) {
      if let index = heroControlIndex(controlNode) {
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
