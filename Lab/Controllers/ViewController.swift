//
//  ViewController.swift
//  Lab
//
//  Created by Akezhan Mussa on 8/25/18.
//  Copyright © 2018 Akezhan Mussa. All rights reserved.
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
        let scene = SCNScene(named: "art.scnassets/fightRomanSoldier.scn")!
        
        // Set the scene to the view
        sceneView.scene = scene
        
        setupScene()  
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()

        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
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
    
    func setupScene(){
        let node = SCNNode()
        node.position = SCNVector3.init(0, 0, 0)
        
        let leftWall = BoxModel.createBox(false)
        leftWall.position = SCNVector3.init(-boxl/2, 0, 0)
        leftWall.eulerAngles = SCNVector3.init(0, 180.0.degrToRadians, 0)
        
        let rightWall = BoxModel.createBox(false)
        rightWall.position = SCNVector3.init(boxl/2, 0, 0)


        let topWall = BoxModel.createBox(false)
        topWall.position = SCNVector3.init(0, boxh/2, 0)
        topWall.eulerAngles = SCNVector3.init(0, 0, 90.0.degrToRadians)

        let bottomWall = BoxModel.createBox(false)
        bottomWall.position = SCNVector3.init(0, -boxh/2, 0)
        bottomWall.eulerAngles = SCNVector3.init(0, 0, -90.0.degrToRadians)

        let backWall = BoxModel.createBox(false)
        backWall.position = SCNVector3.init(0, 0, -boxl/2)
        backWall.eulerAngles = SCNVector3.init(0, 90.0.degrToRadians, 0)

        let leftDoorSide = BoxModel.createBox(true)
        leftDoorSide.position = SCNVector3.init(-doorL/2, 0, boxl/2)
        leftDoorSide.eulerAngles = SCNVector3.init(0, -90.0.degrToRadians, 0)
        
        let rightDoorSide = BoxModel.createBox(true)
        rightDoorSide.position = SCNVector3.init(doorL/2, 0, boxl/2)
        rightDoorSide.eulerAngles = SCNVector3.init(0, -90.0.degrToRadians, 0)
        
        let light = SCNLight()
        light.type = .spot
        light.spotInnerAngle = 70
        light.spotOuterAngle = 120
        light.zNear = 5
        light.castsShadow = true
        light.shadowBias = 200
        light.shadowColor = UIColor.black
        let constraint = SCNLookAtConstraint(target: bottomWall)
        constraint.isGimbalLockEnabled = true
        
        let ligthNode = SCNNode()
        ligthNode.light = light
        ligthNode.position =  SCNVector3.init(0, boxh/2, 0)
        ligthNode.constraints = [constraint]
        node.addChildNode(ligthNode)
        
        //Adding the nodes to the Main Node
        node.addChildNode(leftWall)
        node.addChildNode(rightWall)
        node.addChildNode(topWall)
        node.addChildNode(backWall)
        node.addChildNode(leftDoorSide)
        node.addChildNode(rightDoorSide)
        node.addChildNode(bottomWall)

        self.sceneView.scene.rootNode.addChildNode(node)
    }
    
}
