//
//  NewsDetailViewController.swift
//  NewsPapier
//
//  Created by Abdurrahman Gazi Yavuz on 3.10.2022.
//

import UIKit

class NewsDetailViewController: UIViewController {
    
    private lazy var mainView = NewsDetailView(frame: view.bounds)
    
    func configure(with news: News){
        
        view.addSubview(mainView)
        
        self.mainView.configure(with: news)
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.tintColor = .white
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        mainView.removeFromSuperview()
    }

}
