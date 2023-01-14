//
//  MainViewController+Protocol.swift
//  NewsPapier
//
//  Created by Abdurrahman Gazi Yavuz on 1/14/23.
//

import Foundation

protocol MainViewControllerDelegate: AnyObject{
    
    func presentSideMenu()
    func tapGestureDidTap()
    
}
