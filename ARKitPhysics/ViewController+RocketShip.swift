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
  func getRocketshipNode(from swipeLocation: CGPoint) -> SCNNode? {
    let hitTestResults = sceneView.hitTest(swipeLocation)
    
    guard let parentNode = hitTestResults.first?.node.parent,
      parentNode.name == rocketshipNodeName else { return nil }
    
    return parentNode
  }
  
  // TODO: Create apply force to rocketship method
  @objc func applyForceToRocketship(withGestureRecognizer recognizer: UIGestureRecognizer) {
    guard recognizer.state == .ended else { return }
    
    let swipeLocation = recognizer.location(in: sceneView)
    
    guard let rocketshipNode = getRocketshipNode(from: swipeLocation),
      let physicsBody = rocketshipNode.physicsBody else { return }
    
    let direction = SCNVector3(0, 3, 0)
    physicsBody.applyForce(direction, asImpulse: true)
  }
  
  // TODO: Create launch rocketship method
  @objc func launchRocketship(withGestureRecognizer recognizer: UIGestureRecognizer) {
    guard recognizer.state == .ended else { return }
    
    let swipeLocation = recognizer.location(in: sceneView)
    guard let rocketshipNode = getRocketshipNode(from: swipeLocation),
      let physicsBody = rocketshipNode.physicsBody,
      let reactorParticleSystem = SCNParticleSystem(named: "reactor", inDirectory: nil),
      let engineNode = rocketshipNode.childNode(withName: "node2", recursively: false) else { return }
    
    physicsBody.isAffectedByGravity = false
    physicsBody.damping = 0
    
    reactorParticleSystem.colliderNodes = planeNodes
    engineNode.addParticleSystem(reactorParticleSystem)
    
    let action = SCNAction.moveBy(x: 0, y: 0.3, z: 0, duration: 3)
    action.timingMode = .easeInEaseOut
    rocketshipNode.runAction(action)
  }
}
