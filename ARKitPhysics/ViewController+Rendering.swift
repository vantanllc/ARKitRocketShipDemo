//
//  ViewController+Rendering.swift
//  ARKitPhysics
//
//  Created by Thinh Luong on 4/15/18.
//  Copyright © 2018 AppCoda. All rights reserved.
//

import ARKit

extension ViewController {
  func update(_ node: inout SCNNode, withGeometry geometry: SCNGeometry, type: SCNPhysicsBodyType) {
    let shape = SCNPhysicsShape(geometry: geometry, options: nil)
    let physicsBody = SCNPhysicsBody(type: type, shape: shape)
    node.physicsBody = physicsBody
  }
}
