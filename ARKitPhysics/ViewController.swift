//
//  ViewController.swift
//  ARKitPhysics
//
//  Created by Jayven Nhan on 12/24/17.
//  Copyright © 2017 AppCoda. All rights reserved.
//

import UIKit
import ARKit

class ViewController: UIViewController {
  
  @IBOutlet weak var sceneView: ARSCNView!
  
  // TODO: Declare rocketship node name constant
  let rocketshipNodeName = "rocketship"
  
  // TODO: Initialize an empty array of type SCNNode
  var planeNodes = [SCNNode]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    addTapGestureToSceneView()
    addSwipeGestureToSceneView()
    configureLighting()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    setUpSceneView()
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    sceneView.session.pause()
  }
  
  func setUpSceneView() {
    let configuration = ARWorldTrackingConfiguration()
    configuration.planeDetection = .horizontal
    
    sceneView.session.run(configuration)
    
    sceneView.delegate = self
  }
  
  func configureLighting() {
    sceneView.autoenablesDefaultLighting = true
    sceneView.automaticallyUpdatesLighting = true
  }
  
  func addTapGestureToSceneView() {
    let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.addRocketshipToSceneView(withGestureRecognizer:)))
    sceneView.addGestureRecognizer(tapGestureRecognizer)
  }
  
  // TODO: Create add swipe gestures to scene view method
  func addSwipeGestureToSceneView() {
    let swipeUpGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(ViewController.applyForceToRocketship(withGestureRecognizer:)))
    swipeUpGestureRecognizer.direction = .up
    sceneView.addGestureRecognizer(swipeUpGestureRecognizer)
    
    let swipeDownGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(ViewController.launchRocketship(withGestureRecognizer:)))
    swipeDownGestureRecognizer.direction = .down
    sceneView.addGestureRecognizer(swipeDownGestureRecognizer)
  }
}

extension float4x4 {
  var translation: float3 {
    let translation = self.columns.3
    return float3(translation.x, translation.y, translation.z)
  }
}

extension UIColor {
  open class var transparentWhite: UIColor {
    return UIColor.white.withAlphaComponent(0.20)
  }
}
