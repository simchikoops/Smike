import SpriteKit

struct Router {
  static var it = Router()
  
  var viewController: GameViewController?
  
  // Figure out what scene is appropriate and go there.
  func navigate() {
    viewController?.loadLevelScene("M1L1") // !!!
  }
}
