//
//  ViewController.swift
//  Project1ARKIT
//
//  Created by Moazzam Tahir on 16/07/2019.
//  Copyright © 2019 Moazzam Tahir. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController {

    @IBOutlet var sceneView: ARSCNView!
    
    //declaring focus class variable to use it
    var focusSquare: FocusSquare? //declaring it optional because sometimes it won't have. The properties will immediately be instanciated from init() method
    var screenCenter: CGPoint! //to make the focusSquare follow the mobile screen
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
        //testing out another debug options in ARKit refrecning to sceneView
        sceneView.debugOptions = [SCNDebugOptions.showWorldOrigin, SCNDebugOptions.showFeaturePoints]
        
        //enabling the autoLightening features
        sceneView.autoenablesDefaultLighting = true
        //sceneView.automaticallyUpdatesLighting = true
        
        screenCenter = view.center //setting the view's center
        
        // Create a new scene
        //let scene = SCNScene(named: "art.scnassets/ship.scn")!
        
        // Set the scene to the view
        //sceneView.scene = scene
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()
        
        //enabling the horizontal plane detection
        configuration.planeDetection = .horizontal

        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
   override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        let viewCenter = CGPoint(x: size.width/2, y: size.height/2)
        screenCenter = viewCenter
    }
    
    func updateFocusSquare() {
        //just to know if Focus Square exists
        guard let focusSquareLocal = focusSquare else {return}
                
        //again we will perform hit test to know the size of existing plane, that we will use as anchor.
        //to get the size we will use extent of existing plane
        let hitTest = sceneView.hitTest(screenCenter, types: .existingPlaneUsingExtent)
        
        if let hitTestResult = hitTest.first {
            print("Focus squares hits a plane")
            
            let addNewModel = hitTestResult.anchor is ARPlaneAnchor
            focusSquareLocal.isClosed = addNewModel
        } else {
            print("Does not hit a plane")
            
            focusSquareLocal.isClosed = false
        }
    }

    // MARK: - ARSCNViewDelegate
    
/*
    // Override to create and configure nodes for anchors added to the view's session.
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        let node = SCNNode()
     
        return node
    }
*/
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }
}
