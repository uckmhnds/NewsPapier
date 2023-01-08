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
                            text: String? = nil,
                            lineBreakMode: NSLineBreakMode? = nil,
                            numberOfLines: Int? = nil){
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
        
        if let text = text{
            
            self.text = text
            
        }
        
        if let lineBreakMode = lineBreakMode{
            
            self.lineBreakMode = lineBreakMode
            
        }
        
        if let numberOfLines = numberOfLines{
            
            self.numberOfLines = numberOfLines
            
        }
        
    }
    
}
