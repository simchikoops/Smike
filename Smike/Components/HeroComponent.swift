import SpriteKit
import GameplayKit

enum HeroType: String {
  case samurai
  case woodpecker
  
  var imageName: String {
    switch self {
    case .samurai: return "samurai"
    case .woodpecker: return "woodpecker"
    }
  }
  
  var anchorPoint: CGPoint {
    switch self {
    case .samurai: return CGPoint(x: 0.5, y: 0.2)
    case .woodpecker: return CGPoint(x: 0.5, y: 0.6)
    }
  }
  
  var minimumAttackInterval: CGFloat {
    switch self {
    case .samurai: return CGFloat(1.0)
    case .woodpecker: return CGFloat(0.7)
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
  
  var alongTrack: CGFloat = 0.0
  var moving: HeroMotion = .stopped
  var lastAttackTicks: CGFloat = 0.0
  
  var hasFocus: Bool = false {
    didSet {
      trackNode?.strokeColor = hasFocus ? selectedColor : unselectedColor
    }
  }

  override func didAddToEntity() {
    guard let printNode = entity?.printNode else { return }
    
    self.heroType = HeroType(rawValue: type)
    createControl()
    
    self.track = createTrack()
    alongTrack = track!.distance / 2
    
    self.trackNode = createTrackNode()
    printNode.addChild(trackNode!)
    
    let (position, depth, layer) = track!.dotAlong(alongTrack)
    let nodeComponent = NodeComponent(imageNamed: heroType!.imageName, position: position, depth: depth, layer: layer)
    nodeComponent.spriteNode?.anchorPoint = heroType!.anchorPoint // towards the feet
    
    entity?.addComponent(nodeComponent)
    printNode.addChild(entity!.node)
    
    if let scene = entity?.scene {
      scene.heroes.append(entity!)
    }
  }
  
  override class var supportsSecureCoding: Bool {
    true
  }
  
  func attack() {
    guard entity!.scene.ticks - lastAttackTicks > heroType!.minimumAttackInterval else { return }
    
    let attack = GKEntity()
    entity!.scene.entities.append(attack)
    
    let attackComponent = HeroAttackComponent(originHero: entity!)
    attack.addComponent(attackComponent)
    
    entity!.node.parent!.addChild(attack.node)
    attackComponent.launch()
    
    lastAttackTicks = entity!.scene.ticks
  }

  private func createControl() {
    let rect = entity!.node.calculateAccumulatedFrame().insetBy(dx: -40, dy: -40)
    let controlNode = SKShapeNode(rect: rect)
    
    controlNode.name = "hero_control_\(index)"
    controlNode.strokeColor = .clear
    controlNode.zPosition = Layer.dash.rawValue
    
    entity!.node.parent?.addChild(controlNode)
  }
  
  private func createTrack() -> Track? {
    guard let printNode = entity!.printNode else { return nil }
    
    var trackNodes = entity!.node.children.filter { node in
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
    return Track(orderedDots: trackDots)
  }
  
  private func createTrackNode() -> SKShapeNode {
    let node = SKShapeNode(path: track!.asCGPath())
    
    node.strokeColor = unselectedColor
    node.alpha = 0.85
    node.lineWidth = 5
    node.glowWidth = 5
    node.lineCap = .round
    node.zPosition = Layer.tracks.rawValue

    return node;
  }
  
  override func update(deltaTime seconds: TimeInterval) {
    guard let node = entity?.node as? SKSpriteNode, let track = self.track else { return }
    
    let speed = Slot.live.heroStats[heroType!]!["speed"]! * seconds
    
    switch moving {
    case .toLeft:
      node.xScale = -1 // look direction
      alongTrack = (alongTrack - speed).clamped(to: 0...track.distance)
    case .toRight:
      node.xScale = 1
      alongTrack = (alongTrack + speed).clamped(to: 0...track.distance)
    case .stopped: return // nothing to do
    }
    
    let (position, depth, layer) = track.dotAlong(alongTrack)
    node.position = position
    node.depth = depth
    node.zPosition = layer
  }
}
