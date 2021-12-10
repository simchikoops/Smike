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

class HeroComponent: GKComponent {
  @GKInspectable var type: String = ""
  
  var heroType: HeroType?
  var track: Track?
  var alongTrack: CGFloat = 0.5

  override func didAddToEntity() {
    guard let printNode = entity?.printNode else { return }
    self.track = createTrack()
    
    let trackNode = SKShapeNode(path: track!.asCGPath())
    trackNode.strokeColor = .gray
    trackNode.alpha = 0.85
    trackNode.lineWidth = 5
    trackNode.glowWidth = 5
    trackNode.lineCap = .round
    printNode.addChild(trackNode)
    
    self.heroType = HeroType(rawValue: type)
    
    let (position, depth) = track!.positionAndDepthAlong(alongTrack)
    let renderComponent = RenderComponent(imageNamed: heroType!.imageName, position: position, depth: depth)
    entity?.addComponent(renderComponent)
    printNode.addChild(entity!.node)
  }
  
  override class var supportsSecureCoding: Bool {
    true
  }
  
  private func createTrack() -> Track? {
    guard let printNode = entity!.printNode else { return nil }
    print(printNode)
    
    var trackNodes = entity!.baseNode.children.filter { node in
      if let name = node.name {
        return name.starts(with: "PT")
      } else {
        return false
      }
    }
    
    trackNodes.sort { $0.name! < $1.name! }

    let trackDots = trackNodes.map {
      (position: entity!.node.convert($0.position, to: printNode), depth: $0.entity!.depth)
    }
    print(trackDots)
    
    trackNodes.forEach { $0.removeFromParent() }
    return Track(dots: trackDots)
  }
}
