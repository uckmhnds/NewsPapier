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
                     tintColor: UIColor? = nil,
                     backgroundColor: UIColor? = nil,
                     cornerRadius: CGFloat? = nil,
                     gesture: UIGestureRecognizer? = nil){
        
        self.init()
        
        if let image = image{
            self.image = image
        }
        
        if let contentMode = contentMode{
            self.contentMode = contentMode
        }
        
        if let autoLayout = autoLayout{
            self.translatesAutoresizingMaskIntoConstraints = autoLayout
        }
        
        if let clipsToBounds = clipsToBounds{
            self.clipsToBounds = clipsToBounds
        }
        
        if let tintColor = tintColor{
            self.tintColor = tintColor
        }
        
        if let cornerRadius = cornerRadius{
            self.layer.cornerRadius = cornerRadius
        }
        
        if let gesture = gesture{
            self.addGestureRecognizer(gesture)
        }
        
    }
    
}
