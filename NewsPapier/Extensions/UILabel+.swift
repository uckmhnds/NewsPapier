//
//  UILabel+.swift
//  NewsPapier
//
//  Created by Abdurrahman Gazi Yavuz on 12/29/22.
//

import UIKit

extension UILabel{
    
    public convenience init(autoLayout: Bool? = nil,
                            font: UIFont? = nil,
                            color: UIColor? = nil,
                            lineBreakMode: NSLineBreakMode? = nil){
        self.init()
        
        if let autoLayout = autoLayout{
            
            self.translatesAutoresizingMaskIntoConstraints = autoLayout
            
        }
        
        if let font = font{
            
            self.font = font
            
        }
        
        if let color = color{
            
            self.textColor = color
            
        }
        
        if let lineBreakMode = lineBreakMode{
            
            self.lineBreakMode = lineBreakMode
            
        }
        
    }
    
}
