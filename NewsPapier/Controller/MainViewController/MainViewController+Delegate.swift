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

extension MainViewController: NewsViewControllerDelegate{
    
    func newsViewControllerDidTapCell(_ news: News) {
        
        DispatchQueue.main.async { [weak self] in
            
            if let viewController = self?.getNewsDetailViewController(),
                let navController = self?.navigationController
            {
                
                viewController.configure(with: news)
                navController.pushViewController(viewController, animated: true)
                
            }
            
        }
        
    }
    
}

extension MainViewController: HeaderDelegate{
    
    func headerDidTap(_ category: Category) {
        
        let viewController = self.getNewsViewController()
        
        if let navController = self.navigationController{
            
            viewController.setViewController(with: category)
            navController.pushViewController(viewController, animated: true)
            
        }
    }
    
    
}

extension MainViewController: SearchResultsViewControllerDelegate{
    
    func searchResultsViewControllerDidTapCell(_ news: News) {
        
        let viewController = self.getNewsDetailViewController()
        
        if let navController = self.navigationController{
            
            viewController.configure(with: news)
            navController.pushViewController(viewController, animated: true)
            
        }
        
    }
    
    
}


extension MainViewController: SideMenuViewControllerDelegate{
    
    func categorySelected(_ category: TestCategory) {
        #warning("Type casted from Test to Real. Merge all later")
        let viewController = self.getNewsViewController()
        let blurryView = self.getBlurryView()
        
        if let delegate = self.delegate,
            let test: Category = Category(rawValue: category.code),
            let navController = self.navigationController{
            
            delegate.tapGestureDidTap()
            blurryView.removeFromSuperview()
            
            viewController.setViewController(with: test)
            navController.pushViewController(viewController, animated: true)
            
        }
        
    }
    
    
}
