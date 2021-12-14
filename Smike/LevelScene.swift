import SpriteKit
import GameplayKit

class LevelScene: SKScene {
    
  var entities = [GKEntity]()
  var heroes: [GKEntity] = []
  
  var focusHero: GKEntity?
  var heroControlXRef: CGFloat?
  
  private var lastUpdateTime : TimeInterval = 0
    
  override func sceneDidLoad() {
    self.lastUpdateTime = 0
  }
  
  // Load finished callback.
  override func didMove(to: SKView) {
    heroes.sort {
      $0.heroComponent!.index < $1.heroComponent!.index
    }
    selectHero(heroes.first!)
  }
  
  func selectHero(_ hero: GKEntity) {
    focusHero?.heroComponent?.moving = .stopped
    focusHero?.heroComponent?.hasFocus = false
    
    self.focusHero = hero
    focusHero?.heroComponent?.hasFocus = true
  }
  
  func touchDown(atPoint pos : CGPoint) {
    let touchedNodes = nodes(at: pos)
    if let controlNode = touchedNodes.first(where: { $0.name?.hasPrefix("hero_control") ?? false } ) {
      if let indexStr = controlNode.name!.components(separatedBy: "_").last, let index = Int(indexStr) {
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
      
    self.lastUpdateTime = currentTime
  }
}
