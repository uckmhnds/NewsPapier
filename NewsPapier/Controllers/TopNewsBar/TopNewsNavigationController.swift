//
//  TopNewsNavigationController.swift
//  NewsPapier
//
//  Created by Abdurrahman Gazi Yavuz on 12/10/22.
//

import UIKit

class TopNewsNavigationController: UINavigationController {
    
    private let rootViewController = NewsViewController()
    private let childViewController = TopNewsDetailViewController()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        pushViewController(rootViewController, animated: true)
        view.addSubview(rootViewController.view)
//        testVC.delegate = self
        
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


//extension TopNewsNavigationController: TopNewsViewControllerDelegate {
//    
//    func navigateToDetailViewController() {
//        
//        pushViewController(childViewController, animated: true)
//        
//    }
//    
//}
