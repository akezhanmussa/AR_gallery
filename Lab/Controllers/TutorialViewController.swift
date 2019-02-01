//
//  TutorialViewController.swift
//  Lab
//
//  Created by Akezhan Mussa on 8/30/18.
//  Copyright © 2018 Akezhan Mussa. All rights reserved.
//

import UIKit
import ARKit
import EasyPeasy
import SceneKit

class TutorialViewController: UIViewController, ARSCNViewDelegate {
    private let mainView = ARSCNView()
    private let configuration = ARWorldTrackingConfiguration()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        configuration.planeDetection = .horizontal
        mainView.session.run(configuration)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.delegate = self
//        let image = UIImageView()
//        let some = NetWorkSkills(someImage: image)
//        some.someFunc()
//        self.view.addSubview(image)
//        image.easy.layout(Top(0),Left(0),Right(0),Bottom(0))
    
        let scene = SCNScene(named: "art.scnassets/ship.scn")!
//
        mainView.scene = scene
//
        setup()

//        anotherSetup()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        
        mainView.session.pause()
    }
    
    //MARK: button actions
    @objc private func addButtonAction(_ sender: UIButton){
        //Setup the root node, node is not visible
        let firstNode = SCNNode()
        firstNode.geometry = SCNPlane(width: 10, height: 10)
        firstNode.geometry?.firstMaterial?.diffuse.contents = #imageLiteral(resourceName: "mussa_sketch")
        firstNode.geometry?.firstMaterial?.specular.contents = UIColor.orange
        firstNode.position = SCNVector3(0,0,5)
        mainView.scene.rootNode.addChildNode(firstNode)
    }
    
    @objc private func resetButtonAction(_ sender: UIButton){
        self.mainView.session.pause()
        self.mainView.scene.rootNode.enumerateHierarchy { (node, _) in
            node.removeFromParentNode()
        }
        self.mainView.session.run(configuration, options: [.resetTracking, .removeExistingAnchors])
    }
    
    
    //MARK: Tutorial with SceneKit
    public func anotherSetup(){
        let scene = SCNScene()
        let stars = SCNParticleSystem(named: "Particles.scnp", inDirectory: nil)!
        let earthNode = EarthNodeClass(0.5)
        
        let lightNode = SCNNode()
        lightNode.light = SCNLight()
        lightNode.light?.type = .omni
        lightNode.position = SCNVector3(4,10,2)
        
        
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        
        cameraNode.position = SCNVector3(0, 0, 3)
        
        scene.rootNode.addChildNode(lightNode)
        scene.rootNode.addChildNode(earthNode)
        scene.rootNode.addParticleSystem( stars)
        scene.rootNode.addChildNode(cameraNode)
        
        let sceneView = self.view as! SCNView
        sceneView.scene = scene
        
        sceneView.showsStatistics = true
        sceneView.backgroundColor = UIColor.black
        sceneView.allowsCameraControl = true
         
        
    }
    
    override var prefersStatusBarHidden: Bool{
        return true
    }
    
    //MARK: setup of the environment
    public func setup(){
        var addButton = UIButton()
        var resetButton = UIButton()
        let setupEnvironment = Setup()
        
        addButton.addTarget(self, action: #selector(addButtonAction(_:)), for: .touchUpInside)
        resetButton.addTarget(self, action: #selector(resetButtonAction(_:)), for: .touchUpInside)
        
        //Helps to debug the application, feature points is discovered, starting point - showWorldOrigin
        mainView.debugOptions = [ARSCNDebugOptions.showFeaturePoints]
        mainView.session.run(configuration)
        
        addButton = setupEnvironment.setupButton(addButton, color: .red, size: 20, title: "Ad")
        resetButton = setupEnvironment.setupButton(resetButton, color: .blue, size: 20, title: "Reset")
        
        self.view.addSubview(mainView)
        self.view.addSubview(resetButton)
        self.view.addSubview(addButton)
        
        addButton.easy.layout(Bottom(10), Left(10), Width(30), Height(30))
        resetButton.easy.layout(Bottom(10), Right(10),Width(50), Height(50))
        mainView.easy.layout(Top(0),Right(0),Left(0),Bottom(0))
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        // Create a custom object to visualize the plane geometry and extent.
        
        // Add the visualization to the ARKit-managed node so that it tracks
        // changes in the plane anchor as plane estimation continues.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        let location = touch?.location(in: mainView)
        
        let hitResults = mainView.hitTest(location!, types: .featurePoint)
        if let hitTestResult = hitResults.first{
            let transform = hitTestResult.worldTransform
            let position = SCNVector3(x: transform.columns.3.x, y: transform.columns.3.y, z: transform.columns.3.z)
//            let earthNode = EarthNodeClass(0.05)
//            earthNode.position = position
            
                
                // finally the box is added to the scene.
            }
        }
//            let firstNode = SCNNode()
//            firstNode.geometry = SCNPlane(width: 1, height: 1)
//            firstNode.geometry?.firstMaterial?.diffuse.contents = #imageLiteral(resourceName: "sketch1")
//            firstNode.position = position
//            firstNode.eulerAngles = SCNVector3(-Double.pi/2, 0, 0)
//            mainView.debugOptions = []
//            mainView.scene.rootNode.addChildNode(firstNode)
        }
    
    func sessionWasInterrupted(_ session: ARSession) {
        print("The session was interupted")
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didRemove node: SCNNode, for anchor: ARAnchor) {
        guard let planeAnchor = anchor as? ARPlaneAnchor else { return }
        DispatchQueue.main.async {
            print("Plane was detected")
        }
        let container = SCNScene(named: "mesh.dae", inDirectory: "art.scnassets")
        print(container?.rootNode.name)

        
    }
    
    





