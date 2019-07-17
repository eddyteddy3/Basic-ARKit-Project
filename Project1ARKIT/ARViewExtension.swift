//
//  ARViewExtension.swift
//  Project1ARKIT
//
//  Created by Moazzam Tahir on 17/07/2019.
//  Copyright © 2019 Moazzam Tahir. All rights reserved.
//

import ARKit
import SceneKit

extension ViewController: ARSCNViewDelegate {
    
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        
        guard anchor is ARPlaneAnchor else { return }
            print("Plane Detected")
            
            let planeAnchor = anchor as! ARPlaneAnchor //downcasted as planeAnchor
            
            let planeNode = addPlaneNode(planeAnchor: planeAnchor)
            node.addChildNode(planeNode )
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
        
        guard anchor is ARPlaneAnchor else { return }
        
        print("plane detected")
        
        let plane = anchor as! ARPlaneAnchor
        
        node.enumerateChildNodes { (childNode, _) in
            childNode.removeFromParentNode()
        }
        
        let planeNode = addPlaneNode(planeAnchor: plane)
        node.addChildNode(planeNode)
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didRemove node: SCNNode, for anchor: ARAnchor) {
        
        guard anchor is ARPlaneAnchor else {return}
        
        print("Plane removed")
        
        node.enumerateChildNodes { (childNode, _) in
            childNode.removeFromParentNode()
        }
        
    }
    
    func addPlaneNode(planeAnchor: ARPlaneAnchor) -> SCNNode {
        
        let plane = SCNPlane(width: CGFloat(planeAnchor.extent.x), height: CGFloat(planeAnchor.extent.z))
        
        plane.firstMaterial?.diffuse.contents = UIImage(named: "grid")
        plane.firstMaterial?.isDoubleSided = true
        
        let planeNode = SCNNode(geometry: plane)
        planeNode.position = SCNVector3(planeAnchor.center.x, planeAnchor.center.y, planeAnchor.center.z)
        planeNode.eulerAngles.x = GLKMathDegreesToRadians(-90)
        
        return planeNode
    }
}
