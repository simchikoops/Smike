import SpriteKit
import GameplayKit

class AnimationComponent: GKComponent {
  @GKInspectable var speed: CGFloat = 1.0
  @GKInspectable var facesLeft: Bool = false
  @GKInspectable var facingFrozen: Bool = false
  
  @GKInspectable var textures: String = ""
  @GKInspectable var frameCount: Int = 1
  @GKInspectable var timePerFrame: Double = 1.0
  
  var positionOffset: CGVector = CGVector(dx: 0, dy: 0)
  var baseDepth: CGFloat = 1.0
  var alongTrack: CGFloat = 0
  
  var mainAction: SKAction?
  var unstarted: Bool = true
  
  var path: PathComponent? {
    entity?.node.parent?.entity?.component(ofType: PathComponent.self)
  }

  override class var supportsSecureCoding: Bool {
    true
  }
  
  override func didAddToEntity() {
    guard let node = entity?.node else { return }
    
    if frameCount > 1 {
      let textures = loadTextures()
      let animation = SKAction.animate(with: textures, timePerFrame: timePerFrame)
      self.mainAction = SKAction.repeatForever(animation)
    }

    if let track = path?.track {
      let refDot = track.referenceDot
      let refPosition = node.position
    
      positionOffset = CGVector(dx: refPosition.x - refDot.position.x, dy: refPosition.y - refDot.position.y)
      baseDepth = refDot.depth
    }
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
    guard let path = path, let track = path.track else { return }
    guard let node = entity?.node as? SKSpriteNode else { return }
    
    // Can't start animating until the first update comes.
    if unstarted && entity!.scene.live, let action = mainAction {
      node.run(action)
      unstarted = false
    }
    
    let increment = (seconds / path.duration) * speed
    alongTrack += increment
    
    if alongTrack >= 1.0 {
      if path.isLoop { // start over
        alongTrack = alongTrack.truncatingRemainder(dividingBy: 1.0)
      } else {
        if path.removeWhenFinished {
          entity!.remove()
        }
        return
      }
    }
    
    var (position, depth, layer, facing) = track.fixFractionAlong(alongTrack)
    
    position.x += positionOffset.dx
    position.y += positionOffset.dy
    
    node.position = position
    node.depth = 1 - depth / baseDepth
    node.zPosition = layer
    
    if !facingFrozen {
      node.facing = facesLeft ? facing.opposite : facing
    }
  }
}
