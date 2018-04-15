//
//  ViewController+ARSCNViewDelegate.swift
//  ARKitPhysics
//
//  Created by Thinh Luong on 4/15/18.
//  Copyright © 2018 AppCoda. All rights reserved.
//

import ARKit

extension ViewController: ARSCNViewDelegate {
  
  func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
    guard let planeAnchor = anchor as? ARPlaneAnchor else { return }
    
    let width = CGFloat(planeAnchor.extent.x)
    let height = CGFloat(planeAnchor.extent.z)
    let plane = SCNPlane(width: width, height: height)
    
    plane.materials.first?.diffuse.contents = UIColor.transparentWhite
    
    var planeNode = SCNNode(geometry: plane)
    
    let x = CGFloat(planeAnchor.center.x)
    let y = CGFloat(planeAnchor.center.y)
    let z = CGFloat(planeAnchor.center.z)
    planeNode.position = SCNVector3(x,y,z)
    planeNode.eulerAngles.x = -.pi / 2
    
    update(&planeNode, withGeometry: plane, type: .static)
    
    node.addChildNode(planeNode)
    
    // TODO: Append plane node to plane nodes array if appropriate
  }
  
  // TODO: Remove plane node from plane nodes array if appropriate
  
  func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
    guard let planeAnchor = anchor as?  ARPlaneAnchor,
      var planeNode = node.childNodes.first,
      let plane = planeNode.geometry as? SCNPlane
      else { return }
    
    let width = CGFloat(planeAnchor.extent.x)
    let height = CGFloat(planeAnchor.extent.z)
    plane.width = width
    plane.height = height
    
    let x = CGFloat(planeAnchor.center.x)
    let y = CGFloat(planeAnchor.center.y)
    let z = CGFloat(planeAnchor.center.z)
    
    planeNode.position = SCNVector3(x, y, z)
    
    update(&planeNode, withGeometry: plane, type: .static)
  }
  
  // TODO: Create update plane node method
  
}
