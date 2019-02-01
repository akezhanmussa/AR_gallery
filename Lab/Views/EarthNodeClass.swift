//
//  EarthNodeClass.swift
//  Lab
//
//  Created by Akezhan Mussa on 8/31/18.
//  Copyright © 2018 Akezhan Mussa. All rights reserved.
//

import UIKit
import SceneKit

class EarthNodeClass: SCNNode {
    
    init(_ radius: CGFloat) {
        super.init()
        self.geometry = SCNSphere(radius: radius)
        self.geometry?.firstMaterial?.diffuse.contents = UIImage(named: "Diffuse")
        self.geometry?.firstMaterial?.emission.contents = UIImage(named: "Emission")
        self.geometry?.firstMaterial?.normal.contents = UIImage(named: "Normal")
        self.geometry?.firstMaterial?.specular.contents = UIImage(named: "Specular")
        self.geometry?.firstMaterial?.shininess = 100
        
        let action = SCNAction.rotate(by: 360 * CGFloat(Double.pi/180), around: SCNVector3(0,1,0), duration: 9)
        let repeatAction = SCNAction.repeatForever(action)
        
        self.runAction(repeatAction)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

