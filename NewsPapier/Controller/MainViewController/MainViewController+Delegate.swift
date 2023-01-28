//
//  MainViewController+Protocol.swift
//  NewsPapier
//
//  Created by Abdurrahman Gazi Yavuz on 12/12/22.
//

import UIKit


extension MainViewController: HeaderDelegate{
    
    func headerDidTapNews(_ categoryCase: CategoryCase) {
        
        let viewController = NewsViewController()
        if let navController = self.navigationController{
            
            viewController.setViewController(with: categoryCase)
            navController.pushViewController(viewController, animated: true)
            
        }
    }
    
    func headerDidTapFinance() {
        
        let viewController = FinanceViewController()
        if let navController = self.navigationController{
            
            navController.pushViewController(viewController, animated: true)
            
        }
    }
    
    func headerDidTapWeather() {
        
        let viewController = WeatherViewController()
        if let navController = self.navigationController{
            
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
    
    func countrySelected(_ countryCase: CountryCase) {
        print(countryCase.code)
    }
    
    
    func categorySelected(_ categoryCase: CategoryCase) {
        print("didSelect")
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

extension MainViewController: HomeCollectionViewDataSource{
    
    var dataSource: [HomeCollectionBaseSection] {
        
        return self.collectionViewSections
        
    }
    
}
