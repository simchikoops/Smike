import SpriteKit
import GameplayKit

protocol Attack {
  var power: Int { get }
  var spent: Bool { get set }
}
