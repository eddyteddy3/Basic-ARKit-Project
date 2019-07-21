//
//  FocusSquareClass.swift
//  Project1ARKIT
//
//  Created by Moazzam Tahir on 18/07/2019.
//  Copyright © 2019 Moazzam Tahir. All rights reserved.
//	

import SceneKit

//we are creating the focus class, which is derived from SCNNode Class, to customize it according to our own requirements, for future as well.
class FocusSquare: SCNNode {
    
    var isClosed: Bool = true {
        didSet {
            //using ternary operator, if focusPoint detects the surface the image will be close otherwise open
            geometry?.firstMaterial?.diffuse.contents = self.isClosed ? UIImage(named: "FocusSquare/close") : UIImage(named: "FocusSquare/open")
        }
    }
    
    //overriding the initializer from the SCNNode Class
    override init() {
        super.init() //this sets the eveything before executing other functions
        //super inherits the functionlaties implemented in init() in SCNNode Class
        
        //declaring the plane for focusPoint
        let plane = SCNPlane(width: 0.1, height: 0.1) //assigning the constant height and width
        plane.firstMaterial?.diffuse.contents = UIImage(named: "FocusSquare/close")
        plane.firstMaterial?.isDoubleSided = true
        
        //we don't need a plane node as the Plane itself is a node, so we are assigning some geometric properties to it.
        geometry = plane
        eulerAngles.x = GLKMathDegreesToRadians(-90) //to make it flat
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
