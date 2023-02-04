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
    private let financeViewController = FinanceViewController()
    private let newsDetailViewController = NewsDetailViewController()
    
    // MARK: - Views
    
    private lazy var collectionView = HomeCollectionView(frame: view.bounds)
    private lazy var blurryView = BlurryView(frame: view.bounds, delegate: delegate)
    private lazy var searchController = SearchController(searchResultsController: searchResultsViewController)
    
    var collectionViewSections: [any HomeCollectionBaseSection] = [any HomeCollectionBaseSection]()
    
    // MARK: - Network
    
    private var newsResponseDict: [CategoryCase: [News]] = [:]
    private var financeResponseDict: [FinanceCase: Finance] = [:]
    private var weatherResponseDict: [WeatherCase: WeatherResponse] = [:]
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
                        self.newsResponseDict[category] = results.articles
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
                
                if let response = DecodeLocal.shared.fetch(fileName: category.code) as NewsResponse?,
                   let articles = response.articles
                {
                    self.newsResponseDict[category] = articles
                }
                
                self.dispatchGroup.leave()
            }
            
        }
        
        for finance in FinanceCase.allCases{
            
            self.dispatchGroup.enter()
            
            DispatchQueue.main.async {
                
                if let response = DecodeLocal.shared.fetch(fileName: finance.code) as FinanceResponse?
                {
                    self.financeResponseDict[finance] = response.data
                }
                
                self.dispatchGroup.leave()
            }
            
        }
        
        for weather in WeatherCase.allCases{
            
            self.dispatchGroup.enter()
            
            DispatchQueue.main.async {
                
                if let response = DecodeLocal.shared.fetch(fileName: weather.code) as WeatherResponse?
                {
                    self.weatherResponseDict[weather] = response
                }
                
                self.dispatchGroup.leave()
            }
            
        }
        
        self.dispatchGroup.notify(queue: .main){
            
            self.isLoading = false
            self.collectionView.reloadData()
            
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
        return self.newsResponseDict
    }
    
    func getNewsResponseDict(with categoryCase: CategoryCase) -> [News]? {
        return self.newsResponseDict[categoryCase]
    }
    
    func getFinanceDict() -> [FinanceCase: Finance] {
        return self.financeResponseDict
    }
    
    func getFinanceDict(with financeCase: FinanceCase) -> Finance? {
        return self.financeResponseDict[financeCase]
    }
    
    func getWeatherDict() -> [WeatherCase: WeatherResponse] {
        return self.weatherResponseDict
    }
    
    func getWeatherDict(with weatherCase: WeatherCase) -> WeatherResponse? {
        return self.weatherResponseDict[weatherCase]
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
        view.addSubview(blurryView)
        
        if let delegate = self.delegate{
            delegate.presentSideMenu()
        }
    }
    
    private func configureNavigationBar(){
        
        let filterBarImage          = UIImage(systemName: "gearshape")
        
        let filterBar               = UIBarButtonItem(image: filterBarImage,
                                                      style: .done,
                                                      target: self,
                                                      action: #selector(filterBarButtonAction))
        
        navigationItem.leftBarButtonItem                   = filterBar
        
        if let navController = navigationController{
            navController.navigationBar.tintColor = .white
        }
        navigationItem.titleView = searchController.searchBar
        
        definesPresentationContext = true
        
    }
    
    private func configureSearchBar(){
        
        searchController.searchBar.placeholder = "Search"
        searchController.searchBar.setPlaceholder(textColor: Theme.secondaryText)
        searchController.searchBar.setSearchImage(color: Theme.secondaryText)
        
        searchController.searchBar.set(textColor: Theme.primaryText)
        searchController.searchBar.setTextField(color: Theme.primaryBackground)
        searchController.searchBar.setClearButton(color: Theme.tertiaryText)
        
    }
    
    private func setCollectionViewDelegates(){
        
        collectionView.delegate     = self
        collectionView.dataSource   = self
        collectionView.sectionDataSource = self
        
    }
    
    private func setSearchDelegates(){
        
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.delegate = self
        
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
        configureSearchBar()
        
        setCollectionViewSections()

        view.addSubview(collectionView)
        
        setCollectionViewDelegates()
        setSearchDelegates()
        
        if let navController = self.navigationController{
            navController.hidesBarsOnSwipe = false
        }
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        #warning("Those are tightly coupled")
        searchResultsViewController.topPadding = topBarHeight
        
    }

}

