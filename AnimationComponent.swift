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
  
  var loop: LoopComponent? {
    entity?.node.parent?.entity?.component(ofType: LoopComponent.self)
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

    if let track = loop?.track {
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
    guard let loop = loop, let track = loop.track else { return }
    guard let node = entity?.node as? SKSpriteNode else { return }
    
    // Can't start animating until the first update comes.
    if unstarted && entity!.scene.live, let action = mainAction {
      node.run(action)
      unstarted = false
    }
    
    let increment = (seconds / loop.duration) * speed
    alongTrack += increment
    
    let loopFraction = alongTrack.truncatingRemainder(dividingBy: 1.0)
    var (position, depth, layer, facing) = track.fixFractionAlong(loopFraction)
    
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
