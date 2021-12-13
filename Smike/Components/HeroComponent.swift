import SpriteKit
import GameplayKit

enum HeroType: String {
  case samurai
  
  var imageName: String {
    switch self {
    case .samurai: return "Samurai"
    }
  }
}

enum HeroMotion {
  case toLeft
  case toRight
  case stopped
}

class HeroComponent: GKComponent {
  @GKInspectable var type: String = ""
  @GKInspectable var index: Int = 0
  
  let unselectedColor: UIColor = .gray
  let selectedColor: UIColor = .yellow
  
  var heroType: HeroType?
  
  var track: Track?
  var trackNode: SKShapeNode?
  
  var alongTrack: CGFloat = 0.5
  var moving: HeroMotion = .stopped

  override func didAddToEntity() {
    guard let printNode = entity?.printNode else { return }
    self.track = createTrack()
    
    trackNode = SKShapeNode(path: track!.asCGPath())
    trackNode?.strokeColor = unselectedColor
    trackNode?.alpha = 0.85
    trackNode?.lineWidth = 5
    trackNode?.glowWidth = 5
    trackNode?.lineCap = .round
    trackNode?.zPosition = Layer.tracks.rawValue
    printNode.addChild(trackNode!)
    
    self.heroType = HeroType(rawValue: type)
    
    let (position, depth, layer) = track!.dotAlong(alongTrack)
    let renderComponent = RenderComponent(imageNamed: heroType!.imageName, position: position, depth: depth, layer: layer)
    renderComponent.spriteNode?.anchorPoint = CGPoint(x: 0.5, y: 0.2) // towards the feet
    
    entity?.addComponent(renderComponent)
    printNode.addChild(entity!.node)
    
    if let scene = entity?.scene as? LevelScene {
      scene.heroes.append(entity!)
    }
  }
  
  override class var supportsSecureCoding: Bool {
    true
  }
  
  private func createTrack() -> Track? {
    guard let printNode = entity!.printNode else { return nil }
    
    var trackNodes = entity!.baseNode.children.filter { node in
      if let name = node.name {
        return name.starts(with: "pt")
      } else {
        return false
      }
    }
    
    trackNodes.sort { $0.name! < $1.name! }

    let trackDots = trackNodes.map {
      (position: entity!.node.convert($0.position, to: printNode), depth: $0.entity!.depth, layer: $0.entity!.layer)
    }
    
    trackNodes.forEach { $0.removeFromParent() }
    return Track(dots: trackDots)
  }
  
  override func update(deltaTime seconds: TimeInterval) {
    guard let node = entity?.node as? SKSpriteNode, let track = self.track else { return }
    
    let speed = 0.001 // TODO: lookup
    
    switch moving {
    case .toLeft:
      node.xScale = -1 // look direction
      alongTrack = (alongTrack - speed).clamped(to: 0...1)
    case .toRight:
      node.xScale = 1
      alongTrack = (alongTrack + speed).clamped(to: 0...1)
    case .stopped: return // nothing to do
    }
    
    let (position, depth, layer) = track.dotAlong(alongTrack)
    node.position = position
    node.depth = depth
    node.zPosition = layer
  }
  
  func gainFocus() {
    trackNode?.strokeColor = selectedColor
  }
  
  func loseFocus() {
    trackNode?.strokeColor = unselectedColor
  }
}
