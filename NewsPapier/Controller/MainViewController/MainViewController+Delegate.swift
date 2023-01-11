//
//  MainViewController+Protocol.swift
//  NewsPapier
//
//  Created by Abdurrahman Gazi Yavuz on 12/12/22.
//

import UIKit

protocol MainViewControllerDelegate: AnyObject{
    
    func presentSideMenu()
    func tapGestureDidTap()
    
}

//extension MainViewController: NewsViewControllerDelegate{
//
//    func newsViewControllerDidTapCell(_ news: News) {
//
//        DispatchQueue.main.async { [weak self] in
//
//            if let viewController = self?.getNewsDetailViewController(),
//                let navController = self?.navigationController
//            {
//
//                viewController.configure(with: news)
//                navController.pushViewController(viewController, animated: true)
//
//            }
//
//        }
//
//    }
//
//}

extension MainViewController: HeaderDelegate{
    
    func headerDidTap(_ categoryCase: CategoryCase) {
        
        let viewController = NewsViewController()
        print("headerDidTap at MainViewController")
        if let navController = self.navigationController{
            
            viewController.setViewController(with: categoryCase)
            navController.pushViewController(viewController, animated: true)
            
        }
    }
    
    
}

extension MainViewController: SearchResultsViewControllerDelegate{
    
    func searchResultsViewControllerDidTapCell(_ news: News) {
        
        let viewController = NewsDetailViewController()
        
        if let navController = self.navigationController{
            
            viewController.configure(with: news)
            navController.pushViewController(viewController, animated: true)
            
        }
        
    }
    
    
}


extension MainViewController: SideMenuViewControllerDelegate{
    
    func categorySelected(_ categoryCase: CategoryCase) {
        
        let viewController = NewsViewController()
        let blurryView = self.getBlurryView()
        
        if let delegate = self.delegate,
            let navController = self.navigationController{
            
            delegate.tapGestureDidTap()
            blurryView.removeFromSuperview()
            
            viewController.setViewController(with: categoryCase)
            navController.pushViewController(viewController, animated: true)
            
        }
        
    }
    
    
}
