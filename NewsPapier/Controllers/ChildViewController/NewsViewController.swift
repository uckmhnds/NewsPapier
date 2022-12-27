//
//  TopNewsViewController.swift
//  NewsPapier
//
//  Created by Abdurrahman Gazi Yavuz on 12/10/22.
//

import UIKit

//protocol TopNewsViewControllerDelegate: AnyObject {
//
//    func navigateToDetailViewController()
//
//}

class NewsViewController: UIViewController {
    
//    weak var delegate: TopNewsViewControllerDelegate?
    let childViewController = NewsDetailViewController()
    
    public weak var delegate: SearchResultsViewControllerDelegate?
    
    private var newsCategory: Category?
    
//    let apiCaller = APICaller()
    
    var news: [News] = []
    
    private let newsTable = NewsTableView()
    
    func navigateToDetailViewController(){
        
        navigationController?.pushViewController(childViewController, animated: true)
        
    }
    
    private func fetchNews(){
        
        guard let category = newsCategory else{return}
        
        ExternalAPIClient.shared.fetch(NewsRequest(category: category)) { response in
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
    
    func setViewController(with category: Category){
        
        newsCategory = category
        title = category.rawValue.capitalizeFirstLetter()
        
    }
    
    // Scroll Down Refresh
    
    @objc private func didScrollDownToRefresh(){
        
        self.newsTable.refreshControl?.beginRefreshing()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1){
            
            self.fetchNews()
            
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
        
        print("viewDidLoad")
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        newsTable.frame = view.bounds
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        fetchNews()
        
        print("viewWillAppear")
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("viewDidDisappear")
        
        news = []
        self.newsTable.reloadData()
//        navigationController?.popViewController(animated: true)
    }

}


