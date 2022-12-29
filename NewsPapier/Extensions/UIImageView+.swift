//
//  UIImageView.swift
//  NewsPapier
//
//  Created by Abdurrahman Gazi Yavuz on 12/29/22.
//

import UIKit


extension UIImageView{
    
    convenience init(image: UIImage? = nil,
                     contentMode: UIView.ContentMode? = nil,
                     autoLayout: Bool? = nil,
                     clipsToBounds: Bool? = nil,
                     tintColor: UIColor? = nil){
        
        self.init()
        
        if let image = image{
            self.image = image
        }
        
    }
    
}
