//
//  UIView+.swift
//  NewsPapier
//
//  Created by Abdurrahman Gazi Yavuz on 12/31/22.
//

import UIKit

extension UIView {
    
    public func anchor(top: NSLayoutYAxisAnchor? = nil,
                       leading: NSLayoutXAxisAnchor? = nil,
                       bottom: NSLayoutYAxisAnchor? = nil,
                       trailing: NSLayoutXAxisAnchor? = nil,
                       padding: UIEdgeInsets = .zero,
                       height: CGFloat? = nil,
                       width: CGFloat? = nil,
                       centerX: NSLayoutXAxisAnchor? = nil,
                       centerY: NSLayoutYAxisAnchor? = nil) {
        
        if let top = top{
            
            topAnchor.constraint(equalTo: top,
                                 constant: padding.top).isActive = true
            
        }
        
        if let leading = leading{
            
            leadingAnchor.constraint(equalTo: leading,
                                    constant: padding.left).isActive = true
            
        }
        
        if let bottom = bottom{
            
            bottomAnchor.constraint(equalTo: bottom,
                                    constant: -padding.bottom).isActive = true
            
        }
        
        if let trailing = trailing{
            
            trailingAnchor.constraint(equalTo: trailing,
                                    constant: -padding.right).isActive = true
            
        }
        
        if let height = height{
            
            heightAnchor.constraint(equalToConstant: height).isActive = true
            
        }
        
        if let width = width{
            
            widthAnchor.constraint(equalToConstant: width).isActive = true
            
        }
        
        if let centerX = centerX{
            centerXAnchor.constraint(equalTo: centerX).isActive = true
        }
        
        if let centerY = centerY{
            centerYAnchor.constraint(equalTo: centerY).isActive = true
        }
        
    }
    
}
