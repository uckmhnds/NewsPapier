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
            print("asdadjljS")
            self?.newsDetailViewController.configure(with: news)
            self?.navigationController?.pushViewController(self!.newsDetailViewController, animated: true)
            
        }
        
    }
    
}

extension MainViewController: HeaderDelegate{
    
    func headerDidTap(_ category: Category) {
        
        newsViewController.setViewController(with: category)
        #warning("Once searchResultsController is pushed. animated: true slows the animation")
        navigationController?.pushViewController(newsViewController, animated: true)
    }
    
    
}
