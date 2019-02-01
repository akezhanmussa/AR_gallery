//
//  File.swift
//  Lab
//
//  Created by Akezhan Mussa on 9/2/18.
//  Copyright © 2018 Akezhan Mussa. All rights reserved.
//

import Foundation
import UIKit

class NetWorkSkills{
    
    public var someImage:UIImageView? = nil
    
    public init(someImage:UIImageView){
        self.someImage = someImage
    }
    
    public func someFunc(){
        let imageUrl = URL(string: "https://upload.wikimedia.org/wikipedia/commons/4/4d/Cat_November_2010-1a.jpg")
        //MARK: singleton object/ one instance of the object
        let task = URLSession.shared.dataTask(with: imageUrl!) { (data, resp, error) in
            
            if error == nil{
                let download = UIImage(data: data!)
                DispatchQueue.main.async {
                    self.someImage?.image = download
               }
            }else {
                print("Sorry something went wrong")
            }
            
            print("finished")
        }
        task.resume()
    }
}
