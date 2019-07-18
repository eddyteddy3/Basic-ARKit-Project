//
//  ARViewExtension.swift
//  Project1ARKIT
//
//  Created by Moazzam Tahir on 17/07/2019.
//  Copyright © 2019 Moazzam Tahir. All rights reserved.
//

import SceneKit
import ARKit

extension ViewController: ARSCNViewDelegate {
    
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        
        //if the anchor is plane then proceed
        guard anchor is ARPlaneAnchor else {return}
        print("Plane Detected")
        
        let plane = anchor as! ARPlaneAnchor
        
        let planeNode = createPlaneNode(plane)
        
        //adding the child node to the root node "node"
        node.addChildNode(planeNode)
        
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
        
        guard anchor is ARPlaneAnchor else {return}
        
        print("plane updated")
        
        let planeAnchor = anchor as! ARPlaneAnchor
        
        //we are removing the child nodes becuase everytime the scene update the new updated size of node will be added, so previous child will be removed
        node.enumerateChildNodes { (childNode, _) in
            childNode.removeFromParentNode() //this child node will be removed from parent's node
        }
        
        //adding the updated child node to the parent node
        let planeNode = createPlaneNode(planeAnchor)
        node.addChildNode(planeNode)
        
    }
    
    //the scene was detecting more than one anchors for a plane. To remove the other anchor the following method was used.
    func renderer(_ renderer: SCNSceneRenderer, didRemove node: SCNNode, for anchor: ARAnchor) {
        
        guard anchor is ARPlaneAnchor else {return}
        
        node.enumerateChildNodes { (childNode, _) in
            childNode.removeFromParentNode()
        }
        
    }
    
    //this function will take plane as parameter and return the node attached in result which will attach to the node
    func createPlaneNode(_ planeAnchor: ARPlaneAnchor) -> SCNNode {
        
        //setting the geometry for the plane using anchor
        let plane = SCNPlane(width: CGFloat(planeAnchor.extent.x), height: CGFloat(planeAnchor.extent.z))
        
        //giving texture to the plane to show it visually on the screen
        plane.firstMaterial?.diffuse.contents = UIImage(named: "grid")
        
        //making the grid image double sided to show completely
        plane.firstMaterial?.isDoubleSided = true
        
        //now creating node with geometry of plane we just defined
        let planeNode = SCNNode(geometry: plane)
        
        //now placing the node in the center of the detect surface
        planeNode.position = SCNVector3(planeAnchor.center.x, planeAnchor.center.y, planeAnchor.center.z)
        
        //rotating the plane node to 90 degrees as it will display standing in the middle
        //euler angles are used to position, orientation the node
        planeNode.eulerAngles.x = GLKMathDegreesToRadians(-90)
        
        //finally returning the node that will be place on detected surface
        return planeNode
        
    }
    
}
