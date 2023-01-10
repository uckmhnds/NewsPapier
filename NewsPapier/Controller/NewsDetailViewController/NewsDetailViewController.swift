//
//  NewsDetailViewController.swift
//  NewsPapier
//
//  Created by Abdurrahman Gazi Yavuz on 3.10.2022.
//

import UIKit

class NewsDetailViewController: UIViewController {
    
    // MARK: - Members
    
    private lazy var swipeLeft = UISwipeGestureRecognizer(target: self,
                                                          action: #selector(didSwipeLeft(_:)),
                                                          delegate: self,
                                                          direction: .left,
                                                          name: Preferences.newsDetailSwipeLeft)
    
    private lazy var swipeRight = UISwipeGestureRecognizer(target: self,
                                                           action: #selector(didSwipeRight(_:)),
                                                           delegate: self,
                                                           direction: .right,
                                                           name: Preferences.newsDetailSwipeRight)
    
    private lazy var mainView = NewsDetailView(frame: view.bounds)
    
    // MARK: - Getters
    
    func getMainView() -> NewsDetailView{
        self.mainView
    }
    
    func getSwipeLeft() -> UISwipeGestureRecognizer{
        self.swipeLeft
    }
    
    func getSwipeRight() -> UISwipeGestureRecognizer{
        self.swipeRight
    }
    
    // MARK: - Public Methods
    
    func configure(with news: News){
        
        view.addSubview(mainView)
        
        self.mainView.configure(with: news)
        
    }
    
    // MARK: - Private Methods
    
    @objc private func didSwipeLeft(_ sender: UITapGestureRecognizer){
        //
        print("didSwipeLeft")
    }
    
    @objc private func didSwipeRight(_ sender: UITapGestureRecognizer){
        //
        print("didSwipeRight")
    }
    
    private func configureNavBar(){
        
        if let navController = self.navigationController{
            navController.navigationBar.tintColor = Theme.primaryText
        }
        
    }
    
    private func addGestures(){
        
        view.addGestureRecognizer(swipeLeft)
        view.addGestureRecognizer(swipeRight)
        
    }
    
    // MARK: - Life-cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavBar()
        
        addGestures()
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        mainView.removeFromSuperview()
    }

}


extension NewsDetailViewController: UIGestureRecognizerDelegate{
    
}
