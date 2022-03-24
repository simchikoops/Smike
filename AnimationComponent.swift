import SpriteKit
import GameplayKit

class AnimationComponent: GKComponent {
  @GKInspectable var textures: String = ""
  @GKInspectable var frameCount: Int = 1
  @GKInspectable var timePerFrame: CGFloat = 1.0
  
  var mainAction: SKAction?
  var unstarted: Bool = true
  
  override class var supportsSecureCoding: Bool {
    true
  }
  
  override func didAddToEntity() {
    let textures = loadTextures()
    let animation = SKAction.animate(with: textures, timePerFrame: timePerFrame)

    self.mainAction = SKAction.repeatForever(animation)
  }
  
  func loadTextures() -> [SKTexture] {
    var textureArray: [SKTexture] = []
    
    for i in 0..<frameCount {
      let textureName = "\(textures)_\(i)"
      textureArray.append(SKTexture(imageNamed: textureName))
    }
    
    return textureArray
  }
  
  override func update(deltaTime seconds: TimeInterval) {
    guard let node = entity?.node as? SKSpriteNode else { return }
    
    // Can't start animating until the first update comes.
    if unstarted && entity!.scene.live, let action = mainAction {
      node.run(action)
      unstarted = false
    }
  }
}
