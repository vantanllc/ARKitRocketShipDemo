//
//  ViewController+RocketShip.swift
//  ARKitPhysics
//
//  Created by Thinh Luong on 4/15/18.
//  Copyright © 2018 AppCoda. All rights reserved.
//

import ARKit

extension ViewController {  
  @objc func addRocketshipToSceneView(withGestureRecognizer recognizer: UIGestureRecognizer) {
    let tapLocation = recognizer.location(in: sceneView)
    let hitTestResults = sceneView.hitTest(tapLocation, types: .existingPlaneUsingExtent)
    guard let hitTestResult = hitTestResults.first else { return }
    
    let translation = hitTestResult.worldTransform.translation
    let x = translation.x
    let y = translation.y + 0.1
    let z = translation.z
    
    guard let rocketshipScene = SCNScene(named: "rocketship.scn"),
      let rocketshipNode = rocketshipScene.rootNode.childNode(withName: "rocketship", recursively: false)
      else { return }
    
    rocketshipNode.position = SCNVector3(x,y,z)
    
    // TODO: Attach physics body to rocketship node
    let physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
    rocketshipNode.physicsBody = physicsBody
    rocketshipNode.name = rocketshipNodeName
    
    sceneView.scene.rootNode.addChildNode(rocketshipNode)
  }
  
  // TODO: Create get rocketship node from swipe location method
  
  // TODO: Create apply force to rocketship method
  
  // TODO: Create launch rocketship method
}
