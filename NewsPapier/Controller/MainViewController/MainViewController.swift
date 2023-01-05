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
    
    let newsViewController = NewsViewController()
    let newsDetailViewController = NewsDetailViewController()
    
    // MARK: - Views
    
    private lazy var collectionView = HomeCollectionView(frame: view.bounds)
    private lazy var blurryView = BlurryView(frame: view.bounds, delegate: delegate)
    private lazy var searchController = SearchController(searchResultsController: newsViewController)
    
    // MARK: - Network
    
    var responseDict: [Category: [News]] = [:]
    var isLoading: Bool = true
    let dispatchGroup = DispatchGroup()
    
    func fetchNews(){
        
        for category in Category.allCases
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
    
    // MARK: - Private Methods
    
    @objc private func filterBarButtonAction(){
        
        /// GO TO PREFERENCES
        ///
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
        
        fetchNews()
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationBar()
        
        view.addSubview(collectionView)
        
        collectionView.delegate     = self
        collectionView.dataSource   = self
        
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
    }

}
