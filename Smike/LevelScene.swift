import SpriteKit
import GameplayKit

class LevelScene: SKScene {
    
  var entities = [GKEntity]()
  var heroes: [GKEntity] = []
  
  var focusHero: GKEntity?
  
  private var lastUpdateTime : TimeInterval = 0
    
  override func sceneDidLoad() {
    self.lastUpdateTime = 0
  }
  
  // Load finished callback.
  override func didMove(to: SKView) {
    heroes.sort {
      $0.component(ofType: HeroComponent.self)!.index < $1.component(ofType: HeroComponent.self)!.index
    }
    selectHero(heroes.first!)
  }
  
  func selectHero(_ hero: GKEntity) {
    focusHero?.component(ofType: HeroComponent.self)?.moving = .immobile
    focusHero?.component(ofType: HeroComponent.self)?.loseFocus()
    
    self.focusHero = hero
    focusHero?.component(ofType: HeroComponent.self)?.gainFocus()
  }
    
  func touchDown(atPoint pos : CGPoint) {
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
