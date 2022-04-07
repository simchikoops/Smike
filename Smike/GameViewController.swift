//
//  GameViewController.swift
//  Smike
//
//  Created by Ryan Koopmans on 11/26/21.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    
    Router.it.viewController = self
    Router.it.navigate()
  }

  override var shouldAutorotate: Bool {
    return true
  }

  override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
    if UIDevice.current.userInterfaceIdiom == .phone {
      return .allButUpsideDown
    } else {
      return .all
    }
  }

  override var prefersStatusBarHidden: Bool {
    return true
  }

  func loadGameScene(_ sceneFileName: String) {
    guard let gkScene = GKScene(fileNamed: sceneFileName) else {
      print("Scene \(sceneFileName) not found"); return
    }
    guard let scene = gkScene.rootNode as? GameScene else {
      print("Scene \(sceneFileName) is not a game scene"); return
    }
    
    scene.entities = gkScene.entities
    scene.scaleMode = .aspectFit
                
    // Present the scene
    if let view = self.view as? SKView {
      view.presentScene(scene)
                    
      view.ignoresSiblingOrder = true // major performance, apparently
      
      // TODO: development only
      view.showsFPS = true
      view.showsNodeCount = true
      view.showsPhysics = true
    }
  }
}
