//
//  Setup.swift
//  Lab
//
//  Created by Akezhan Mussa on 8/30/18.
//  Copyright © 2018 Akezhan Mussa. All rights reserved.
//

import Foundation
import UIKit

protocol Settable{
    func setupButton(_ button: UIButton, color: UIColor, size: CGFloat, title: String) -> UIButton
}

struct Setup: Settable{
    
    /**
     Adds the custom configuration to the button
     - Parameter button: any button
     - Parameter color: any color you like
     - Parameter size: any size you like
     - Parameter title: any title
     - Returns: the button with custom config
     */
    func setupButton(_ button: UIButton, color: UIColor, size: CGFloat, title: String) -> UIButton {
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = UIFont.getAvenir(size: size)
        button.backgroundColor = color
        return button
    }
}
