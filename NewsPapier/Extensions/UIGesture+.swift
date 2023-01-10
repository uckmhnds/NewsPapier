//
//  UIGesture+.swift
//  NewsPapier
//
//  Created by Abdurrahman Gazi Yavuz on 1/3/23.
//

import UIKit

extension UITapGestureRecognizer{
    
    public convenience init(target: Any?,
                            action: Selector?,
                            delegate: UIGestureRecognizerDelegate? = nil,
                            name: String? = nil)
    {
        self.init(target: target, action: action)
        
        if let delegate = delegate{
            self.delegate = delegate
        }
        
        if let name = name{
            self.name = name
        }
        
    }
    
}

extension UISwipeGestureRecognizer{
    
    public convenience init(target: Any?,
                            action: Selector?,
                            delegate: UIGestureRecognizerDelegate? = nil,
                            direction: UISwipeGestureRecognizer.Direction? = nil,
                            name: String? = nil)
    {
        self.init(target: target, action: action)
        
        if let delegate = delegate{
            self.delegate = delegate
        }
        
        if let direction = direction{
            self.direction = direction
        }
        
        if let name = name{
            self.name = name
        }
        
    }
    
}
