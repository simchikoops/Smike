import SpriteKit
import GameplayKit

class MortalGroupComponent: GKComponent {
  var mortals: [GKEntity] = []
  
  override class var supportsSecureCoding: Bool {
    true
  }
  
  override func didAddToEntity() {
    entity!.node.enumerateChildNodes(withName: ".//*") { node, stop in
      if node.entity?.component(ofType: MortalComponent.self) != nil {
        self.mortals.append(node.entity!)
      }
    }
    mortals.sort {
      $0.component(ofType: MortalComponent.self)!.seq < $1.component(ofType: MortalComponent.self)!.seq
    }
  }
}
