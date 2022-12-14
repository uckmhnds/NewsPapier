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
    
    let apiCaller = APICaller()
    
    var news: [News] = []
    
    private lazy var newsTable: UITableView  = {
        
        let table                       = UITableView()
        table.register(TopNewsTableViewCell.self, forCellReuseIdentifier: TopNewsTableViewCell.identifier)
        table.frame = view.bounds
        return table
        
    }()
    
    func navigateToDetailViewController(){
        
        navigationController?.pushViewController(childViewController, animated: true)
        
    }
    
    private func fetchNews(){
        guard let category = newsCategory else{return}
        
        apiCaller.getNews(with: category) { result in
            switch result {
            case .success(let news):
                // To prevent blocking main thread
                DispatchQueue.main.async {
                    self.news = news
                    self.newsTable.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func setViewController(with category: Category){
        
        newsCategory = category
        
        switch category {
            
        case .categories:
            break
        case .sources:
            break
        case .business:
            title = "Business"
            break
        case .entertainment:
            title = "Entertainment"
            break
        case .general:
            title = "General"
            break
        case .health:
            title = "Health"
            break
        case .science:
            title = "Science"
            break
        case .sports:
            title = "Sports"
            break
        case .technology:
            title = "Technology"
            break
            
        }
        
    }
    
    // Scroll Down Refresh
    
    @objc private func didScrollDownToRefresh(){
        
        self.newsTable.refreshControl?.beginRefreshing()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2){
            
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
    
    func reloadNewsTable(){
        self.newsTable.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(newsTable)

        newsTable.delegate              = self
        newsTable.dataSource            = self
        
        newsTable.refreshControl        = setScrollDownRefreshControl()
        
        print("viewDidLoad")
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
//        fetchNews()
        
        print("viewWillAppear")
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("viewDidDisappear")
//        navigationController?.popViewController(animated: true)
    }

}


