//
//  RootNavigationController+Delegate.swift
//  NewsPapier
//
//  Created by Abdurrahman Gazi Yavuz on 12/28/22.
//

import UIKit

extension RootNavigationController: MainViewControllerDelegate {
    
    func test() {
        
        UIView.animate(withDuration: Preferences.sideMenuDidShowDuration,
                       delay: Preferences.sideMenuDidShowDelay,
                       usingSpringWithDamping: Preferences.sideMenuDidShowDamping,
                       initialSpringVelocity: Preferences.sideMenuDidShowVelocity,
                       options: Preferences.sideMenuDidShowOption)
        {
            
            self.sideMenuTrailingConstraint.constant = 0
            self.view.layoutIfNeeded()
            
        } completion: { done in
            if done {
                self.menuState = .opened
            }
        }
        
    }
    
    func tapGestureDidTap() {
        
        switch menuState {
            
        case .closed:
            break
            
        case .opened:
            
            UIView.animate(withDuration: Preferences.sideMenuDidDisappearDuration,
                           delay: Preferences.sideMenuDidDisappearDelay,
                           usingSpringWithDamping: Preferences.sideMenuDidDisappearDamping,
                           initialSpringVelocity: Preferences.sideMenuDidDisappearVelocity,
                           options: Preferences.sideMenuDidDisappearOption)
            {
                
                self.sideMenuTrailingConstraint.constant = -self.sideMenuWidth
                self.view.layoutIfNeeded()

            } completion: { done in
                if done {
                    self.menuState = .closed
                }
            }
            
            break
        }
        
    }
    
    
}
