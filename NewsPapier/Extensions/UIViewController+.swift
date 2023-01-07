//
//  UIViewController+.swift
//  NewsPapier
//
//  Created by Abdurrahman Gazi Yavuz on 1/7/23.
//

import UIKit

extension UIViewController{
    
    var topBarHeight: CGFloat {
        return (view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0.0) +
            (self.navigationController?.navigationBar.frame.height ?? 0.0)
    }
    
    var statusBarHeight: CGFloat {
        return view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0.0
    }
    
}
