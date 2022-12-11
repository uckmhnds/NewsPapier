//
//  MainTabBarViewController.swift
//  NewsPapier
//
//  Created by Abdurrahman Gazi Yavuz on 30.09.2022.
//

import UIKit

class MainTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let topNewsBar                  = TopNewsNavigationController()
        topNewsBar.title                = "Top News"
        topNewsBar.tabBarItem.image     = UIImage(systemName: "star.circle")
        
        let discoverBar                 = RootNavigationController()
        discoverBar.title               = "Discover"
        discoverBar.tabBarItem.image    = UIImage(systemName: "star.circle")

        let homeVC                      = UINavigationController(rootViewController: HomeTabViewController())
        let testVC                      = UINavigationController(rootViewController: TestViewController())

        homeVC.title                    = "Home"
        testVC.title                    = "Test"

        homeVC.tabBarItem.image         = UIImage(systemName: "globe.europe.africa.fill")
        testVC.tabBarItem.image         = UIImage(systemName: "star.circle")

        tabBar.tintColor                = .label

//        setViewControllers([topNewsBar, homeVC, testVC], animated: true)
        setViewControllers([topNewsBar, discoverBar, homeVC, testVC], animated: true)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
