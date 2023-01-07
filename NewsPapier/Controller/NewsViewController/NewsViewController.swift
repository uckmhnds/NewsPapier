//
//  TopNewsViewController.swift
//  NewsPapier
//
//  Created by Abdurrahman Gazi Yavuz on 12/10/22.
//

import UIKit

class NewsViewController: UIViewController {
    
    let childViewController = NewsDetailViewController()
    
    public weak var delegate: NewsViewControllerDelegate?
    
    private var newsCategory: Category?
    
    var news: [News] = []
    
    let newsTable = NewsTableView()
    
    func navigateToDetailViewController(){
        
        navigationController?.pushViewController(childViewController, animated: true)
        
    }
    
    private func fetchNews(){
        
        guard let category = newsCategory else{ return }
        
        ExternalAPIClient.shared.fetch(NewsRequest(category: category,
                                                   country: Preferences.country,
                                                   pageSize: Preferences.pageSize,
                                                   pageNumber: Preferences.pageNumber))
        { response in
            switch response{
            case .success(let results):
                // To prevent blocking main thread
                DispatchQueue.main.async {
                    guard let articles = results.articles else {return}
                    self.news = articles
                    self.newsTable.reloadData()
                }
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
    
    private func loadLocalNews(){
        
        guard let category = newsCategory else{ return }
        
        DispatchQueue.main.async {
            
            if let test = DecodeLocal.shared.fetch(fileName: category.name) as NewsResponse?,
               let articles = test.articles
            {
                self.news = articles
                self.newsTable.reloadData()
            }
            
        }
    }
    
    func setViewController(with category: Category){
        
        newsCategory = category
        title = category.rawValue.capitalizeFirstLetter()
        
    }
    
    func reloadNewsTable(){
        newsTable.reloadData()
    }
    
    // Scroll Down Refresh
    
    @objc private func didScrollDownToRefresh(){
        
        self.newsTable.refreshControl?.beginRefreshing()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + Preferences.scrollDownRefreshTime){
            
            switch Preferences.appState{
                
            case .online:
                self.fetchNews()
                
            case .offline:
                self.loadLocalNews()
                
            }
            
            self.newsTable.refreshControl?.endRefreshing()
            
        }
        
    }
    
    private func setScrollDownRefreshControl() -> UIRefreshControl{
        
        let refreshControl  = UIRefreshControl()
        
        refreshControl.addTarget(self, action: #selector(didScrollDownToRefresh), for: .valueChanged)
        
        refreshControl.tintColor    = .white
        
        return refreshControl
        
    }
    
    #warning("put getter and setter in every class")
    
    func setNews(_ news: [News]){
        self.news = news
    }
    
    func getNews() -> [News]{
        return self.news
    }

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        view.addSubview(newsTable)

        newsTable.delegate              = self
        newsTable.dataSource            = self
        
        newsTable.refreshControl        = setScrollDownRefreshControl()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        newsTable.frame = view.bounds
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        switch Preferences.appState{
            
        case .online:
            fetchNews()
            
        case .offline:
            loadLocalNews()
            
        }
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        self.news.removeAll(keepingCapacity: false)
        self.newsTable.reloadData()
        
    }

}


