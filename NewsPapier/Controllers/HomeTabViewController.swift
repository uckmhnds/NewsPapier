//
//  HomeTabViewController.swift
//  NewsPapier
//
//  Created by Abdurrahman Gazi Yavuz on 30.09.2022.
//

import UIKit
import SwiftUI

class HomeTabViewController: UIViewController {
    
//    private let swiftUIController   = UIHostingController(rootView: HomeTabHeaderNews())
    
    public var currentPage: Int = 1
    
//    private let apiCaller = APICaller()
    
    private var news: [News] = [News]()
    
    private let newsTable: UITableView  = {
        
        let table                       = UITableView()
        table.register(NewsTableViewCell.self, forCellReuseIdentifier: NewsTableViewCell.identifier)
        return table
        
    }()
    
    /// SEARCH BAR CONFIG
    
    private let searchBar: UISearchController = {
        
        let controller                      = UISearchController(searchResultsController: SearchResultsViewController())
        
        controller.searchBar.placeholder    = "Search"
        controller.searchBar.searchBarStyle = .default
        
        return controller
        
    }()
    
    // NAVIGATION BAR CONFIG
    
    @objc private func filterBarButtonAction(){
        
        print("clicked")
        
        /// GO TO PREFERENCES
    }
    
    private func configureNavigationBar(){
        
        let filterBarImage          = UIImage(systemName: "slider.horizontal.3")
        
        let filterBar               = UIBarButtonItem(image: filterBarImage,
                                                      style: .done,
                                                      target: self,
                                                      action: #selector(filterBarButtonAction))
        
        navigationItem.rightBarButtonItem                   = filterBar
        
        navigationController?.navigationBar.tintColor       = .white
        
    }
    /*
    func fetchSomeNews(){
        
        apiCaller.getSomeNews { [weak self] result in
            switch result {
            case .success(let news):
                DispatchQueue.main.async {
                    self?.news  = news
                    self?.newsTable.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func fetchFewNews(){
        
        apiCaller.getFewNews { [weak self] result in
            switch result {
            case .success(let news):
                DispatchQueue.main.async {
                    self?.news  = news
                    self?.newsTable.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func fetchNewsScrollBottomDidEnd(with page: Int){
        
        apiCaller.getNews(with: page) { [weak self] result in
            switch result {
            case .success(let news):
                DispatchQueue.main.async {
                    self?.news.removeFirst(5)
                    self?.news.append(contentsOf: news)
//                    self?.news  = news
                    self?.newsTable.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
    }
    */
    // Scroll Down Refresh
    
    @objc private func didScrollDownToRefresh(){
        
        self.newsTable.refreshControl?.beginRefreshing()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3){
            
//            self.fetchSomeNews()
            
            self.newsTable.refreshControl?.endRefreshing()
            
        }
        
    }
    
    private func setScrollDownRefreshControl() -> UIRefreshControl{
        
        let refreshControl  = UIRefreshControl()
        
        refreshControl.addTarget(self, action: #selector(didScrollDownToRefresh), for: .valueChanged)
        
        refreshControl.tintColor    = .white
        
        return refreshControl
        
    }

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        view.addSubview(newsTable)
        
        navigationItem.searchController = searchBar
        
        searchBar.searchResultsUpdater  = self
        
        newsTable.delegate              = self
        newsTable.dataSource            = self
        
        newsTable.refreshControl        = setScrollDownRefreshControl()
        
        configureNavigationBar()
        
//        fetchSomeNews()
        
    }
    
    override func viewDidLayoutSubviews() {
        
        super.viewDidLayoutSubviews()
        
//        addChild(swiftUIController)
        
//        swiftUIController.didMove(toParent: self)
        
        newsTable.frame                 = view.bounds
        
//        swiftUIController.view.frame    = CGRect(x: 0, y: 0, width: view.bounds.width, height: 360)
    }
}


extension HomeTabViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return news.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell  = tableView.dequeueReusableCell(withIdentifier: NewsTableViewCell.identifier, for: indexPath) as? NewsTableViewCell else {return UITableViewCell()}
        
        cell.configure(with: news[indexPath.row])
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 260
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        tableView.deselectRow(at: indexPath, animated: true)
        
        let selectedNews            = news[indexPath.row]
        
        DispatchQueue.main.async { [weak self] in
            let viewController      = NewsDetailViewController()
            viewController.configure(with: selectedNews)
            self?.navigationController?.pushViewController(viewController, animated: true)

        }
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        
        let bookmarkAction  = UIContextualAction(style: .normal, title: nil) { _, _, completion in
            print("Bookmark Action is clicked")
        }
        
        bookmarkAction.image            = UIImage(systemName: "bookmark")
        bookmarkAction.backgroundColor  = .systemGray
        
        let shareAction = UIContextualAction(style: .normal, title: nil) { _, _, completion in
            print("Share Action is clicked")
        }
        
        shareAction.image               = UIImage(systemName: "square.and.arrow.up")
        shareAction.backgroundColor     = .systemBackground
        
        // When you put an action into actions array first element, it will be default for long swipe action
        let config      = UISwipeActionsConfiguration(actions: [bookmarkAction, shareAction])
        
        // Remove default first element action
        config.performsFirstActionWithFullSwipe = false
        
        return config
        
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let shareAction = UIContextualAction(style: .normal, title: nil) { _, _, completion in
            print("Test")
        }
        
        shareAction.image           = UIImage(systemName: "square.and.arrow.up")
        shareAction.backgroundColor = .systemBackground
        
        let config      = UISwipeActionsConfiguration(actions: [shareAction])
        
        return config
    }
    
//    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//
//        let currentItem     = indexPath.row
//
//        if currentItem + 2 > news.count {
//            print(self.currentPage)
//            self.currentPage += 1
//
//            self.fetchNewsScrollBottomDidEnd()
//            print(self.currentPage)
//        }
//
//    }
}


extension HomeTabViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        
        let searchBar   = searchController.searchBar
        
        guard let query = searchBar.text,
              !query.trimmingCharacters(in: .whitespaces).isEmpty,
              query.trimmingCharacters(in: .whitespaces).count >= 3,
              let resultsController = searchController.searchResultsController as? SearchResultsViewController
        else { return }
        
        // To access SearchResultsViewControllerDelegate via the protocol
        resultsController.delegate  = self
        
//        apiCaller.search(with: query) { result in
//
//            DispatchQueue.main.async {
//
//                switch result {
//                case .success(let result):
//
//                    resultsController.news  = result
//                    resultsController.newsTable.reloadData()
//
//                case .failure(let error):
//                    print(error.localizedDescription)
//                }
//
//            }
//
//        }
        
    }
    
}

extension HomeTabViewController: SearchResultsViewControllerDelegate{
    
    func searchResultsViewControllerDidTapCell(_ news: News) {
        
        DispatchQueue.main.async { [weak self] in
            
            let viewController  = NewsDetailViewController()
            viewController.configure(with: news)
            self?.navigationController?.pushViewController(viewController, animated: true)
            
        }
        
    }
    
}

extension HomeTabViewController: UIScrollViewDelegate{
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        var pagination      = false
        let scrollOffset    = scrollView.contentOffset.y
        let tableOffset     = newsTable.contentSize.height
        
        if tableOffset != 0 && scrollOffset > tableOffset - scrollView.frame.size.height - 50
        {
            pagination       = true
        }else
        {
            pagination       = false
        }
        
        if pagination
        {
                
//            guard !apiCaller.isPaginating else {return}
//            
//            self.currentPage += 1
//            apiCaller.getNews(with: self.currentPage ) { [weak self] result in
//                switch result{
//                case .success(let result):
//                    self?.news.append(contentsOf: result)
//                    DispatchQueue.main.async {
//                        self?.newsTable.reloadData()
//                    }
//                case .failure(let error):
//                    print(error.localizedDescription)
//                }
//            }
            
        }
        
    }
    
}
