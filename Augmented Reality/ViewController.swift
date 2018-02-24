//
//  ViewController.swift
//  Augmented Reality
//
//  Created by Rahul Avale on 2/23/18.
//  Copyright © 2018 Rahul Avale. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
        // Create a new scene
        let scene = SCNScene(named: "art.scnassets/ship.scn")!
        
        // Set the scene to the view
        sceneView.scene = scene
        
        for node in sceneView.scene.rootNode.childNodes {
            
            let moveUp = SCNAction.moveBy(x: 0, y: 2, z: 0, duration: 2)
            let moveDown = SCNAction.moveBy(x: 0, y: -2, z: 0, duration: 2)
            let routine = SCNAction.sequence([moveUp, moveDown])
            let continuousRoutine = SCNAction.repeatForever(routine)
            node.runAction(continuousRoutine)
            
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()
        
        configuration.planeDetection = .horizontal

        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {

        if let plane = anchor as? ARPlaneAnchor {
            print("X : \(plane.extent.x), Z : \(plane.extent.z)")
        }
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
        
        if let plane = anchor as? ARPlaneAnchor {
            print("X : \(plane.extent.x), Z : \(plane.extent.z)")
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
}
