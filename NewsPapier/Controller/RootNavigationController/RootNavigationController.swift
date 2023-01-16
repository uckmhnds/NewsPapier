//
//  DiscoverNavigationController.swift
//  NewsPapier
//
//  Created by Abdurrahman Gazi Yavuz on 12/11/22.
//

import UIKit

class RootNavigationController: UINavigationController {
    
    var menuState: SideMenuState = .closed
    
    let sideMenuViewController = SideMenuViewController()
    lazy var sideMenuWidth: CGFloat = view.frame.width * Preferences.sideMenuWidthRatio
    var sideMenuTrailingConstraint: NSLayoutConstraint!
    var navigationViewController: UINavigationController?
    
    let rootViewController = MainViewController()
    
    private func applyConstraints(){
        
        sideMenuViewController.view.translatesAutoresizingMaskIntoConstraints = false
        sideMenuViewController.view.widthAnchor.constraint(equalToConstant: sideMenuWidth).isActive = true
        sideMenuTrailingConstraint = sideMenuViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: -sideMenuWidth)
        sideMenuTrailingConstraint.isActive = true
        sideMenuViewController.view.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        sideMenuViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
    }
    
    private func setColors(){
        
        view.backgroundColor = Theme.primaryBackground
        
        navigationBar.tintColor = Theme.tertiaryBackground
        navigationBar.barTintColor = Theme.tertiaryBackground
        
        navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.font: Theme.h0Title
        ]
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sideMenuViewController.delegate = rootViewController.self
        
        addChild(sideMenuViewController)
        view.addSubview(sideMenuViewController.view)
        
        sideMenuViewController.didMove(toParent: self)
        
        applyConstraints()
        
        // Do any additional setup after loading the view.
        pushViewController(rootViewController, animated: true)
        rootViewController.delegate = self
        
        setColors()
        
    }

}
