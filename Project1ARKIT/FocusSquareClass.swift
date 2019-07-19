//
//  FocusSquareClass.swift
//  Project1ARKIT
//
//  Created by Moazzam Tahir on 18/07/2019.
//  Copyright © 2019 Moazzam Tahir. All rights reserved.
//

import SceneKit

class FocusSquare: SCNNode {
    
    var isClosed: Bool = true {
        didSet {
            geometry?.firstMaterial?.diffuse.contents = self.isClosed ? UIImage(named: "FocusSquare/close") : UIImage(named: "FocusSquare/open")
        }
    }
    
    override init() {
        super.init() //this sets the eveything before executing other functions
        
        let plane = SCNPlane(width: 0.1, height: 0.1) //assigning the constant height and width
        plane.firstMaterial?.diffuse.contents = UIImage(named: "FocusSquare/close")
        plane.firstMaterial?.isDoubleSided = true
        
        geometry = plane
        eulerAngles.x = GLKMathDegreesToRadians(-90)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
