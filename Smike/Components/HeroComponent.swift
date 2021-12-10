import SpriteKit
import GameplayKit

enum HeroType: String {
  case samurai
}

class HeroComponent: GKComponent {
  @GKInspectable var type: String = ""
  
  var heroType: HeroType?
  var track: Track?

  override func didAddToEntity() {
    self.track = createTrack()
    
    let trackNode = SKShapeNode(path: track!.asCGPath())
    trackNode.strokeColor = .gray
    trackNode.alpha = 0.85
    trackNode.lineWidth = 5
    trackNode.glowWidth = 5
    trackNode.lineCap = .round
    entity!.printNode?.addChild(trackNode)
    
    self.heroType = HeroType(rawValue: type)
    
    // let renderComponent = RenderComponent(imageNamed: "\(monsterType)_0", scale: 0.65)
    // monsterEntity.addComponent(renderComponent)
  }
  
  override class var supportsSecureCoding: Bool {
    true
  }
  
  private func createTrack() -> Track? {
    guard let printNode = entity!.printNode else { return nil }
    
    var trackNodes = entity!.node.children.filter { node in
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
    
    trackNodes.forEach { $0.removeFromParent() }
    return Track(dots: trackDots)
  }
}
