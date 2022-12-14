//
//  DiscoverViewController.swift
//  NewsPapier
//
//  Created by Abdurrahman Gazi Yavuz on 12/11/22.
//

import UIKit
import Combine

enum Category{
    case categories
    case sources
    case business
    case entertainment
    case general
    case health
    case science
    case sports
    case technology
}

class MainViewController: UIViewController {
    
    weak var delegate: MainViewControllerDelegate?
    
    let newsViewController = NewsViewController()
    let newsDetailViewController = NewsDetailViewController()
    
    private let categoriesContentInset: NSDirectionalEdgeInsets = .init(top: 0, leading: 0, bottom: 10, trailing: 0)
    private let categoriesItemPadding: CGFloat = 5
    private let categoriesItemWidthFraction: CGFloat = 1
    private let categoriesItemHeightFraction: CGFloat = 1
    private let categoriesGroupWidthFraction: CGFloat = 1
    private let categoriesGroupHeightFraction: CGFloat = 0.28
    
    private let mainCategoryContentInset: NSDirectionalEdgeInsets = .init(top: 0, leading: 0, bottom: 24, trailing: 0)
    private let mainCategoriesItemPadding: CGFloat = 5
    private let mainCategoriesItemWidthFraction: CGFloat = 1
    private let mainCategoriesItemHeightFraction: CGFloat = 1
    private let mainCategoriesGroupWidthFraction: CGFloat = 0.25
    private let mainCategoriesGroupHeightFraction: CGFloat = 0.14
    
    private let sourcesCategoryContentInset: NSDirectionalEdgeInsets = .init(top: 0, leading: 0, bottom: 20, trailing: 0)
    private let sourcesCategoriesItemPadding: CGFloat = 5
    private let sourcesCategoriesItemWidthFraction: CGFloat = 1
    private let sourcesCategoriesItemHeightFraction: CGFloat = 1
    private let sourcesCategoriesGroupWidthFraction: CGFloat = 0.4
    private let sourcesCategoriesGroupHeightFraction: CGFloat = 0.08
    
    #warning("Do it with mapping instead of hardcoding")
    let categories = [Category.categories,
                              Category.sources,
                              Category.business,
                              Category.entertainment,
                              Category.general,
                              Category.health,
                              Category.science,
                              Category.sports,
                              Category.technology]
    
    let categoryHeaders: [String] = ["Categories",
                                             "Sources",
                                             "Business",
                                             "Entertainment",
                                             "General",
                                             "Health",
                                             "Science",
                                             "Sports",
                                             "Technology"]
    
    let categoryNames: [String] = ["Business",
                                             "Entertainment",
                                             "General",
                                             "Health",
                                             "Science",
                                             "Sports",
                                             "Technology"]
    
    var businessNews: [News] = []
    var entertainmentNews: [News] = []
    var generalNews: [News] = []
    var healthNews: [News] = []
    var scienceNews: [News] = []
    var sportsNews: [News] = []
    var technologyNews: [News] = []
    
    // Setters and getters
    #warning("better encapsulation for setter getter but set privates as open for now")
    func getBusinessNews() -> [News]{
        return businessNews
    }

    func getBusinessNews(at index: Int) -> News{
        return businessNews[index]
    }
    
    var sources: [Source] = []
    
    let apiCaller = APICaller()
    
    let pagingInfoSubject = PassthroughSubject<PagingInfo, Never>()
    
    //
    // Collection View
    //
    
    private lazy var headerBoundarySupplementaryItem: NSCollectionLayoutBoundarySupplementaryItem = {
        
        let item = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: .init(widthDimension: .fractionalWidth(1.0),
                                                                                 heightDimension: .estimated(44)),
                                                               elementKind: Header.identifier,
                                                               alignment: .top,
                                                               absoluteOffset: CGPoint(x: 0, y: 0))
        return item
        
    }()
    
    private lazy var footerBoundarySupplementaryItem: NSCollectionLayoutBoundarySupplementaryItem = {
        
        
        
        let footerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(20))

        let item = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: footerSize,
                                                                              elementKind: PagingSectionFooterView.reuseIdentifier,
                                                                              alignment: .bottom)
        
        return item
        
    }()
    
    private lazy var collectionLayoutBackgroundDecoration: NSCollectionLayoutDecorationItem = {
        
        let item = NSCollectionLayoutDecorationItem.background(elementKind: RoundedBackgroundView.reuseIdentifier)
        return item
        
    }()
    
    private func mainCategorySection() -> NSCollectionLayoutSection{
        
        let item = CompositionalLayout.createItem(width: .fractionalWidth(self.mainCategoriesItemWidthFraction),
                                                  height: .fractionalHeight(self.mainCategoriesItemHeightFraction),
                                                  spacing: self.mainCategoriesItemPadding)

        let group = CompositionalLayout.createGroup(alignment: .vertical,
                                                    width: .fractionalWidth(self.mainCategoriesGroupWidthFraction),
                                                    height: .fractionalHeight(self.mainCategoriesGroupHeightFraction),
                                                    items: [item])

        let section = NSCollectionLayoutSection(group: group)

        section.contentInsets                   = self.mainCategoryContentInset
        section.orthogonalScrollingBehavior     = .continuous
        section.boundarySupplementaryItems      = [self.headerBoundarySupplementaryItem]
        section.decorationItems                 = [self.collectionLayoutBackgroundDecoration]

        return section
        
    }
    
    private func sourcesSection() -> NSCollectionLayoutSection{
        
        let item = CompositionalLayout.createItem(width: .fractionalWidth(self.sourcesCategoriesItemWidthFraction),
                                                  height: .fractionalHeight(self.sourcesCategoriesItemHeightFraction),
                                                  spacing: self.sourcesCategoriesItemPadding)

        let group = CompositionalLayout.createGroup(alignment: .vertical,
                                                    width: .fractionalWidth(self.sourcesCategoriesGroupWidthFraction),
                                                    height: .fractionalHeight(self.sourcesCategoriesGroupHeightFraction),
                                                    items: [item])

        let section = NSCollectionLayoutSection(group: group)

        section.contentInsets                   = self.sourcesCategoryContentInset
        section.orthogonalScrollingBehavior     = .continuous
        section.boundarySupplementaryItems      = [self.headerBoundarySupplementaryItem]
        section.decorationItems                 = [self.collectionLayoutBackgroundDecoration]

        return section
        
    }
    
    private func categorySection(_ sectionIndex: Int) -> NSCollectionLayoutSection {
        
        let item = CompositionalLayout.createItem(width: .fractionalWidth(self.categoriesItemWidthFraction),
                                                  height: .fractionalHeight(self.categoriesItemHeightFraction),
                                                  spacing: self.categoriesItemPadding)

        let group = CompositionalLayout.createGroup(alignment: .vertical,
                                                    width: .fractionalWidth(self.categoriesGroupWidthFraction),
                                                    height: .fractionalHeight(self.categoriesGroupHeightFraction),
                                                    items: [item])

        let section = NSCollectionLayoutSection(group: group)

        section.contentInsets                   = self.categoriesContentInset
        section.orthogonalScrollingBehavior     = .groupPagingCentered
        section.boundarySupplementaryItems      = [self.headerBoundarySupplementaryItem]
        section.decorationItems                 = [self.collectionLayoutBackgroundDecoration]
        
        section.boundarySupplementaryItems      += [self.footerBoundarySupplementaryItem]

        section.visibleItemsInvalidationHandler = { [weak self] (items, offset, env) -> Void in
            guard let self = self else { return }

            let page = round(offset.x / self.view.bounds.width)

            self.pagingInfoSubject.send(PagingInfo(sectionIndex: sectionIndex, currentPage: Int(page)))
        }

        return section
        
    }
    
    private lazy var compositionalLayout: UICollectionViewCompositionalLayout = {
        
        return UICollectionViewCompositionalLayout { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
            #warning("boilerplate code")
            switch self.categories[sectionIndex]{
                
            case .categories:
                
                return self.mainCategorySection()
                
            case .sources:
                
                return self.sourcesSection()
                
            case .business:

                return self.categorySection(sectionIndex)
                
            case .entertainment:

                return self.categorySection(sectionIndex)
                
            case .general:
                
                return self.categorySection(sectionIndex)

                
            case .health:
                
                return self.categorySection(sectionIndex)

                
            case .science:
                
                return self.categorySection(sectionIndex)

                
            case .sports:
                
                return self.categorySection(sectionIndex)

                
            case .technology:
                
                return self.categorySection(sectionIndex)
                
            }

        }
        
    }()
    
    private lazy var collectionView: UICollectionView = {
        
        let categoriesLayout    = compositionalLayout
        
        // Background decoration
        categoriesLayout.register(RoundedBackgroundView.self,
                                  forDecorationViewOfKind: RoundedBackgroundView.reuseIdentifier)
        
        let view                = UICollectionView(frame: view.bounds,
                                                   collectionViewLayout: categoriesLayout)
        
        view.register(DiscoverCategoriesCell.self,
                      forCellWithReuseIdentifier: DiscoverCategoriesCell.identifier)
        view.register(DiscoverMainCategoryCell.self,
                      forCellWithReuseIdentifier: DiscoverMainCategoryCell.identifier)
        view.register(DiscoverSourcesCell.self,
                      forCellWithReuseIdentifier: DiscoverSourcesCell.identifier)
        
        view.register(Header.self,
                      forSupplementaryViewOfKind: Header.identifier,
                      withReuseIdentifier: Header.identifier)
        view.register(PagingSectionFooterView.self,
                      forSupplementaryViewOfKind: PagingSectionFooterView.reuseIdentifier,
                      withReuseIdentifier: PagingSectionFooterView.reuseIdentifier)
        
        return view
        
    }()

    private func fetchNews(){
        
        for category in categories {
            
            switch category{
                
            case .categories:
                break
            case .sources:
                apiCaller.getSource { [weak self] result in
                    switch result{
                    case .success(let sources):
                        DispatchQueue.main.async {
                            self?.sources = sources
                        }
                    case .failure(let err):
                        print(err.localizedDescription)
                    }
                }
            case .business:
                apiCaller.getNews(with: category) { [weak self] result in
                    switch result {
                    case .success(let news):
                            DispatchQueue.main.async {
                                self?.businessNews  = news
//                                self?.collectionView.reloadData()
                            }
                        
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
            case .entertainment:
                apiCaller.getNews(with: category) { [weak self] result in
                    switch result {
                    case .success(let news):
                            DispatchQueue.main.async {
                                self?.entertainmentNews  = news
//                                self?.collectionView.reloadData()
                            }
                        
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
            case .general:
                apiCaller.getNews(with: category) { [weak self] result in
                    switch result {
                    case .success(let news):
                            DispatchQueue.main.async {
                                self?.generalNews  = news
//                                self?.collectionView.reloadData()
                            }
                        
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
            case .health:
                apiCaller.getNews(with: category) { [weak self] result in
                    switch result {
                    case .success(let news):
                            DispatchQueue.main.async {
                                self?.healthNews  = news
//                                self?.collectionView.reloadData()
                            }
                        
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
            case .science:
                apiCaller.getNews(with: category) { [weak self] result in
                    switch result {
                    case .success(let news):
                            DispatchQueue.main.async {
                                self?.scienceNews  = news
//                                self?.collectionView.reloadData()
                            }
                        
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
            case .sports:
                apiCaller.getNews(with: category) { [weak self] result in
                    switch result {
                    case .success(let news):
                            DispatchQueue.main.async {
                                self?.sportsNews  = news
//                                self?.collectionView.reloadData()
                            }
                        
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
            case .technology:
                apiCaller.getNews(with: category) { [weak self] result in
                    switch result {
                    case .success(let news):
                            DispatchQueue.main.async {
                                self?.technologyNews  = news
//                                self?.collectionView.reloadData()
                            }
                        
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
            }
        }

    }
    
    // Scroll Down Refresh
    
    @objc private func didScrollDownToRefresh(){
        
        self.collectionView.refreshControl?.beginRefreshing()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3){
            
            self.fetchNews()
            
            self.collectionView.refreshControl?.endRefreshing()
            
        }
        
    }
    
    private lazy var scrollDownRefreshControl: UIRefreshControl = {
        
        let refreshControl  = UIRefreshControl()
        
        refreshControl.addTarget(self, action: #selector(didScrollDownToRefresh), for: .valueChanged)
        
        refreshControl.tintColor    = .white
        
        return refreshControl
        
    }()
    
    /// SEARCH CONTROLLER CONFIG
    
    private lazy var searchController: UISearchController = {
        
        let controller                      = UISearchController(searchResultsController: newsViewController)
        
        controller.searchBar.placeholder    = "Search"
        controller.searchBar.searchBarStyle = .minimal
        controller.searchBar.sizeToFit()
//        controller.searchBar.showsCancelButton = false
        
        controller.searchResultsUpdater = self
        controller.searchBar.delegate = self
        
        controller.hidesNavigationBarDuringPresentation = false
        
        return controller
        
    }()
    
    /// SEARCH BAR CONFIG
    
    private lazy var searchBar: UISearchBar = {
        
        let bar = UISearchBar()
        
        bar.placeholder = "Search"
        bar.searchBarStyle = .minimal
        bar.sizeToFit()
        
//        bar.delegate = self
        
        return bar
        
    }()
    
    // NAVIGATION BAR CONFIG
    
    @objc private func filterBarButtonAction(){
        
        print("clicked")
        
        /// GO TO PREFERENCES
        ///
        view.addSubview(testView)
        delegate?.test()
    }
    
    private func configureNavigationBar(){
        
        let filterBarImage          = UIImage(systemName: "slider.horizontal.3")
        
        let filterBar               = UIBarButtonItem(image: filterBarImage,
                                                      style: .done,
                                                      target: self,
                                                      action: #selector(filterBarButtonAction))
        
//        navigationItem.titleView = searchBar
        
//        let test = UISearchBar()
//        test.sizeToFit()
        
        navigationItem.leftBarButtonItem                   = filterBar
        
        navigationController?.navigationBar.tintColor       = .white
        
        navigationItem.titleView = searchController.searchBar
        
//        navigationItem.searchController = searchController
        
        definesPresentationContext = true

//        searchController.searchResultsUpdater  = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
//        fetchNews()
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        title = "Discover"
        
        configureNavigationBar()
        
        view.addSubview(collectionView)
        
        collectionView.delegate     = self
        collectionView.dataSource   = self
        
        collectionView.refreshControl = scrollDownRefreshControl

    }
    
    private lazy var testView: UIView = {
        let view = UIView(frame: view.bounds)
        view.backgroundColor = .black
        view.alpha = 0.6
        let t = UITapGestureRecognizer(target: self, action: #selector(tapGestureDidTap))
        view.addGestureRecognizer(t)
        return view
    }()
    
    @objc private func tapGestureDidTap(_ sender: UITapGestureRecognizer) {
        
        testView.removeFromSuperview()
        
        delegate?.tapGestureDidTap()
    }
    

}
