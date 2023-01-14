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
    
    var collectionViewSections: [any HomeCollectionBaseSection] = [any HomeCollectionBaseSection]()
    
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
    
    private func setCollectionViewSections(){
        
        for _case in HomeCollectionSectionType.allCases{
            
            switch _case{
                
            case .finance:
                
                collectionViewSections.append(HomeCollectionFinanceSection())
                
            case .weather:
                
                collectionViewSections.append(HomeCollectionWeatherSection())
                
            case .news:
                
                for _collectionCase in CategoryCase.allCases{
                    
                    switch _collectionCase{
                        
                    case .business:
                        collectionViewSections.append(HomeCollectionCategorySection(.business))
                    case .entertainment:
                        collectionViewSections.append(HomeCollectionCategorySection(.entertainment))
                    case .general:
                        collectionViewSections.append(HomeCollectionCategorySection(.general))
                    case .health:
                        collectionViewSections.append(HomeCollectionCategorySection(.health))
                    case .science:
                        collectionViewSections.append(HomeCollectionCategorySection(.science))
                    case .sports:
                        collectionViewSections.append(HomeCollectionCategorySection(.sports))
                    case .technology:
                        collectionViewSections.append(HomeCollectionCategorySection(.technology))
                    }
                    
                }
            }
        }
        
    }
    
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
        setCollectionViewSections()

        view.addSubview(collectionView)

        collectionView.delegate     = self
        collectionView.dataSource   = self
        collectionView.sectionDataSource = self

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

