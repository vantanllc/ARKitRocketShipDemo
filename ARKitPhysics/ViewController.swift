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
    
    // TODO: Initialize an empty array of type SCNNode
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addTapGestureToSceneView()
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
        
        sceneView.scene.rootNode.addChildNode(rocketshipNode)
    }
    
    // TODO: Create get rocketship node from swipe location method
    
    // TODO: Create apply force to rocketship method
    
    // TODO: Create launch rocketship method
    
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
