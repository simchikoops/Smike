import SpriteKit

struct Router {
  static var it = Router()
  
  var viewController: GameViewController?
  
  // Figure out what scene is appropriate and go there.
  func navigate() {
    viewController?.loadGameScene("Tutorial") // !!!
  }
  
  func navigateFrom(_ name: String, completed: Bool) {
    viewController?.loadGameScene("Q1M1L2") // !!!
  }
}
