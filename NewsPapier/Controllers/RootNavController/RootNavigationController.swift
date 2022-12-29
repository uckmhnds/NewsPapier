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
    lazy var sideMenuWidth: CGFloat = view.frame.width * Preferences.sideMenuWidthRation
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
        navigationBar.backgroundColor = Theme.primaryBackground

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
