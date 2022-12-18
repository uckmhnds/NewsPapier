//
//  DiscoverNavigationController.swift
//  NewsPapier
//
//  Created by Abdurrahman Gazi Yavuz on 12/11/22.
//

import UIKit

class RootNavigationController: UINavigationController {
    
    enum MenuState {
        case opened
        case closed
    }
    
    private var menuState: MenuState = .closed
    
    private let sideMenuViewController = SideMenuViewController()
    private lazy var sideMenuWidth: CGFloat = view.frame.width * 0.4
    private var sideMenuTrailingConstraint: NSLayoutConstraint!
    private var navigationViewController: UINavigationController?

    private let rootViewController = MainViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addChild(sideMenuViewController)
        view.addSubview(sideMenuViewController.view)
        
        sideMenuViewController.view.translatesAutoresizingMaskIntoConstraints = false
        sideMenuViewController.view.widthAnchor.constraint(equalToConstant: sideMenuWidth).isActive = true
        sideMenuTrailingConstraint = sideMenuViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: -sideMenuWidth)
        sideMenuTrailingConstraint.isActive = true
        sideMenuViewController.view.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        sideMenuViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        sideMenuViewController.didMove(toParent: self)
        
        // Do any additional setup after loading the view.
        pushViewController(rootViewController, animated: true)
        rootViewController.delegate = self
        
    }

}


extension RootNavigationController: MainViewControllerDelegate {
    func test() {
        
        UIView.animate(withDuration: 0.25, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseIn) {
            
            self.sideMenuTrailingConstraint.constant = 0
            self.view.layoutIfNeeded()
            
        } completion: { done in
            if done {
                self.menuState = .opened
            }
        }
    }
    
    func tapGestureDidTap() {
        print("didTap")
        switch menuState {
            
        case .closed:
            break
            
        case .opened:
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseIn) {
                
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
