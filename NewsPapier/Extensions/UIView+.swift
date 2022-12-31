//
//  UIView+.swift
//  NewsPapier
//
//  Created by Abdurrahman Gazi Yavuz on 12/31/22.
//

import UIKit

extension UIView {
    
    public func anchor(top: NSLayoutYAxisAnchor,
                       leading: NSLayoutXAxisAnchor,
                       bottom: NSLayoutYAxisAnchor,
                       trailing: NSLayoutXAxisAnchor,
                       padding: UIEdgeInsets = .zero) {
        
        topAnchor.constraint(equalTo: top,
                             constant: padding.top).isActive = true
        
        bottomAnchor.constraint(equalTo: bottom,
                                constant: -padding.bottom).isActive = true
        
        leadingAnchor.constraint(equalTo: leading,
                                 constant: padding.left).isActive = true
        
        trailingAnchor.constraint(equalTo: trailing,
                            constant: -padding.right).isActive = true
        
    }
    
}
