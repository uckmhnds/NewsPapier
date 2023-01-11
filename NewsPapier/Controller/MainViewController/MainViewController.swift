//
//  DiscoverViewController.swift
//  NewsPapier
//
//  Created by Abdurrahman Gazi Yavuz on 12/11/22.
//

import UIKit
import Combine

class MainViewController: UIViewController {
    
    // MARK: - Delegate
    
    weak var delegate: MainViewControllerDelegate?
    
    // MARK: - ViewControllers
    
    private let searchResultsViewController = SearchResultsViewController()
    private let newsViewController = NewsViewController()
    private let newsDetailViewController = NewsDetailViewController()
    
    // MARK: - Views
    
    private lazy var collectionView = HomeCollectionView(frame: view.bounds)
    private lazy var blurryView = BlurryView(frame: view.bounds, delegate: delegate)
    private lazy var searchController = SearchController(searchResultsController: searchResultsViewController)
    
    // MARK: - Network
    
    private var responseDict: [CategoryCase: [News]] = [:]
    private var isLoading: Bool = true
    private let dispatchGroup = DispatchGroup()
    
    private func fetchNews(){
        
        for category in CategoryCase.allCases
        {
            
            self.dispatchGroup.enter()
            
            ExternalAPIClient.shared.fetch(NewsRequest(category: category,
                                                       country: Preferences.country,
                                                       pageSize: Preferences.pageSize,
                                                       pageNumber: Preferences.pageNumber)) { response in
                DispatchQueue.main.async {
                    
                    switch response{
                    case .failure(let err):
                        print(err.localizedDescription)
                    case .success(let results):
                        self.responseDict[category] = results.articles
                    }
                    
                    self.dispatchGroup.leave()
                    
                }
            }
        }
        
        self.dispatchGroup.notify(queue: .main){
            
            self.isLoading = false
            self.collectionView.reloadData()
            
        }

    }
    
    private func loadLocalNews(){
        
        for category in CategoryCase.allCases{
            
            self.dispatchGroup.enter()
            
            DispatchQueue.main.async {
                
                if let test = DecodeLocal.shared.fetch(fileName: category.code) as NewsResponse?,
                   let articles = test.articles
                {
                    self.responseDict[category] = articles
                }
                
                self.dispatchGroup.leave()
            }
            
            self.dispatchGroup.notify(queue: .main){
                
                self.isLoading = false
                self.collectionView.reloadData()
                
            }
            
        }
        
    }
    
    // Scroll Down Refresh
    
//    @objc private func didScrollDownToRefresh(){
//
//        self.collectionView.refreshControl?.beginRefreshing()
//
//        DispatchQueue.main.asyncAfter(deadline: .now() + 3){
//
//            self.fetchNews()
//
//            self.collectionView.refreshControl?.endRefreshing()
//
//        }
//
//    }
//
//    private lazy var scrollDownRefreshControl: UIRefreshControl = {
//
//        let refreshControl  = UIRefreshControl()
//
//        refreshControl.addTarget(self, action: #selector(didScrollDownToRefresh), for: .valueChanged)
//
//        refreshControl.tintColor    = .white
//
//        return refreshControl
//
//    }()
    
    /// SEARCH CONTROLLER CONFIG
    ///
    
//    private lazy var searchController: UISearchController = {
//
//        let controller                      = UISearchController(searchResultsController: newsViewController)
//
//        controller.searchBar.placeholder    = "Search"
//        controller.searchBar.searchBarStyle = .minimal
//        controller.searchBar.sizeToFit()
////        controller.searchBar.showsCancelButton = false
//
//        controller.searchResultsUpdater = self
//        controller.searchBar.delegate = self
//
//        controller.hidesNavigationBarDuringPresentation = false
//
//        return controller
//
//    }()
    
    /// SEARCH BAR CONFIG
    
//    private lazy var searchBar: UISearchBar = {
//
//        let bar = UISearchBar()
//
//        bar.placeholder = "Search"
//        bar.searchBarStyle = .minimal
//        bar.sizeToFit()
//
//        return bar
//
//    }()
    
    // NAVIGATION BAR CONFIG
    
    // MARK: - Getter Methods
    
    func getResponseDict() -> [CategoryCase: [News]] {
        return self.responseDict
    }
    
    func getResponseDict(with categoryCase: CategoryCase) -> [News]? {
        return self.responseDict[categoryCase]
    }
    
    func getIsLoading() -> Bool {
        return self.isLoading
    }
    
    func getBlurryView() -> UIView {
        return self.blurryView
    }
    
    func getCollectionView() -> UICollectionView {
        return self.collectionView
    }
    
    func getSearchController() -> UISearchController {
        return self.searchController
    }
    
    func getSearchResultsViewController() -> SearchResultsViewController {
        return self.searchResultsViewController
    }
    
    func getNewsViewController() -> NewsViewController {
        return self.newsViewController
    }
    
    func getNewsDetailViewController() -> NewsDetailViewController {
        return self.newsDetailViewController
    }
    
    // MARK: - Private Methods
    
    @objc private func filterBarButtonAction(){
        
        /// GO TO PREFERENCES
        ///
        #warning("Add blurry view to sidemenuVC because it is tricky to removeFromSuperview this view when selecting tableView item from sideMenu")
        view.addSubview(blurryView)
        delegate?.presentSideMenu()
    }
    
    private func configureNavigationBar(){
        
        let filterBarImage          = UIImage(systemName: "gearshape")
        
        let filterBar               = UIBarButtonItem(image: filterBarImage,
                                                      style: .done,
                                                      target: self,
                                                      action: #selector(filterBarButtonAction))
        
        navigationItem.leftBarButtonItem                   = filterBar
        
        navigationController?.navigationBar.tintColor       = .white
        
        navigationItem.titleView = searchController.searchBar
        
        definesPresentationContext = true
        
    }
    
    // MARK: - Life-cycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        switch Preferences.appState{
            
        case .online:
            fetchNews()
            
        case .offline:
            loadLocalNews()
            
        }
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationBar()
        
        view.addSubview(collectionView)
        
        collectionView.delegate     = self
        collectionView.dataSource   = self
        
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.delegate = self
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        #warning("Those are tightly coupled")
        searchResultsViewController.topPadding = topBarHeight
        
    }

}
