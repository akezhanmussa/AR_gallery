//
//  Extension.swift
//  Lab
//
//  Created by Akezhan Mussa on 8/25/18.
//  Copyright © 2018 Akezhan Mussa. All rights reserved.
//

import Foundation
import SceneKit
import ARKit
import UIKit

var boxw: CGFloat =  0.02
var boxh: CGFloat =  0.2
var boxl: CGFloat =  0.2
var doorL: CGFloat = 1

public class BoxModel{
    
     public static func createBox(_ isDoor: Bool) -> SCNNode{
        let node = SCNNode()
        
        //Add first box
        let firstBox = SCNBox(width: boxw, height: boxh, length: isDoor ? doorL:boxl, chamferRadius: 0)
        let firstBoxNode = SCNNode(geometry: firstBox)
        firstBoxNode.renderingOrder = 200
        
        node.addChildNode(firstBoxNode)
        
        //Add Masked Box
        
        let maskedBox = SCNBox(width: boxw, height: boxh, length: isDoor ? doorL:boxl, chamferRadius: 0)
        maskedBox.firstMaterial?.diffuse.contents = UIColor.white
        maskedBox.firstMaterial?.transparency = 0.00001
        
        let maskedBoxNode = SCNNode(geometry: maskedBox)
        maskedBoxNode.renderingOrder = 100
        maskedBoxNode.position = SCNVector3.init(boxw, 0, 0)
        
        node.addChildNode(maskedBoxNode)
        
        return node
    }
}

extension FloatingPoint{
    var degrToRadians: Self{
        return  self * .pi / 180
    }
    
    var radToDegrees: Self{
        return self * 180 / .pi
    }
}

extension UIFont{
    public static func getAvenir(size: CGFloat) -> UIFont {
        let font = UIFont(name: "Avenir Next Medium", size: size)
        guard let realFont = font else {
            return UIFont()
        }
        return realFont
    }
}

