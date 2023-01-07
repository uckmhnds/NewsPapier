//
//  SearchResultsViewController.swift
//  NewsPapier
//
//  Created by Abdurrahman Gazi Yavuz on 1/7/23.
//

import UIKit

class SearchResultsViewController: UIViewController {
    
//    weak var delegate: TopNewsViewControllerDelegate?
    let childViewController = NewsDetailViewController()
    
    public weak var delegate: SearchResultsViewControllerDelegate?
    
    private var newsCategory: Category?
    
    var topPadding: CGFloat = 0
    
//    let apiCaller = APICaller()
    
    var news: [News] = []
    
    let newsTable = NewsTableView()
    
    func navigateToDetailViewController(_ news: News){
        
        self.delegate?.searchResultsViewControllerDidTapCell(news)
        
    }
    
    func reloadNewsTable(){
        newsTable.reloadData()
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
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        newsTable.translatesAutoresizingMaskIntoConstraints = false
        newsTable.topAnchor.constraint(equalTo: view.topAnchor, constant: topPadding).isActive = true
        newsTable.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        newsTable.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        newsTable.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        self.news.removeAll(keepingCapacity: false)
        self.newsTable.reloadData()
        
    }

}
