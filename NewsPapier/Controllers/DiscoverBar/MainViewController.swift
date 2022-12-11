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
    
    private let newsViewController = NewsViewController()
    private let newsDetailViewController = NewsDetailViewController()
    
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
    private let categories = [Category.categories,
                              Category.sources,
                              Category.business,
                              Category.entertainment,
                              Category.general,
                              Category.health,
                              Category.science,
                              Category.sports,
                              Category.technology]
    
    private let categoryHeaders: [String] = ["Categories",
                                             "Sources",
                                             "Business",
                                             "Entertainment",
                                             "General",
                                             "Health",
                                             "Science",
                                             "Sports",
                                             "Technology"]
    
    private let categoryNames: [String] = ["Business",
                                             "Entertainment",
                                             "General",
                                             "Health",
                                             "Science",
                                             "Sports",
                                             "Technology"]
    
    private var businessNews: [News] = []
    private var entertainmentNews: [News] = []
    private var generalNews: [News] = []
    private var healthNews: [News] = []
    private var scienceNews: [News] = []
    private var sportsNews: [News] = []
    private var technologyNews: [News] = []
    
    private var sources: [Source] = []
    
    private let apiCaller = APICaller()
    
    private let pagingInfoSubject = PassthroughSubject<PagingInfo, Never>()
    
    private lazy var collectionView: UICollectionView = {
        
        let categoriesLayout    = createLayout()
        
        // Background decoration
        categoriesLayout.register(RoundedBackgroundView.self,
                                  forDecorationViewOfKind: RoundedBackgroundView.reuseIdentifier)
        
        let view                = UICollectionView(frame: view.bounds,
                                                   collectionViewLayout: categoriesLayout)
        
        view.register(DiscoverCategoriesCell.self, forCellWithReuseIdentifier: DiscoverCategoriesCell.identifier)
        view.register(DiscoverMainCategoryCell.self, forCellWithReuseIdentifier: DiscoverMainCategoryCell.identifier)
        view.register(DiscoverSourcesCell.self, forCellWithReuseIdentifier: DiscoverSourcesCell.identifier)
//        view.register(FourthCollectionViewCell.self, forCellWithReuseIdentifier: FourthCollectionViewCell.identifier)
//        view.register(FifthCollectionViewCell.self, forCellWithReuseIdentifier: FifthCollectionViewCell.identifier)
        return view
        
    }()
    
    private lazy var collectionLayoutBackgroundDecoration: NSCollectionLayoutDecorationItem = {
        let item = NSCollectionLayoutDecorationItem.background(elementKind: RoundedBackgroundView.reuseIdentifier)
        return item
    }()
    
    private func createLayout() -> UICollectionViewCompositionalLayout {

        return UICollectionViewCompositionalLayout { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in

            switch self.categories[sectionIndex]{
                
            case .categories:
                
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
                
            case .sources:
                
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
                
            case .business:
                
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
                
            case .entertainment:
                
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
                
            case .general:
                
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
                
            case .health:
                
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
                
            case .science:
                
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
                
            case .sports:
                
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
                
            case .technology:
                
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

        }
    }
    
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

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        fetchNews()
        
        title = "Discover"
        
        view.addSubview(collectionView)
        
        collectionView.delegate     = self
        collectionView.dataSource   = self
        
        collectionView.register(Header.self, forSupplementaryViewOfKind: Header.identifier, withReuseIdentifier: Header.identifier)
        collectionView.register(PagingSectionFooterView.self,
                                forSupplementaryViewOfKind: PagingSectionFooterView.reuseIdentifier,
                                withReuseIdentifier: PagingSectionFooterView.reuseIdentifier)

    }

}

extension MainViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        switch categories[indexPath.section]{
            
        case .categories:
            break
        case .sources:
            break
        case .business:
            let news = businessNews[indexPath.row]
            newsDetailViewController.configure(with: news)
            navigationController?.pushViewController(newsDetailViewController, animated: true)
        case .entertainment:
            let news = entertainmentNews[indexPath.row]
            newsDetailViewController.configure(with: news)
            navigationController?.pushViewController(newsDetailViewController, animated: true)
        case .general:
            let news = generalNews[indexPath.row]
            newsDetailViewController.configure(with: news)
            navigationController?.pushViewController(newsDetailViewController, animated: true)
        case .health:
            let news = healthNews[indexPath.row]
            newsDetailViewController.configure(with: news)
            navigationController?.pushViewController(newsDetailViewController, animated: true)
        case .science:
            let news = scienceNews[indexPath.row]
            newsDetailViewController.configure(with: news)
            navigationController?.pushViewController(newsDetailViewController, animated: true)
        case .sports:
            let news = sportsNews[indexPath.row]
            newsDetailViewController.configure(with: news)
            navigationController?.pushViewController(newsDetailViewController, animated: true)
        case .technology:
            let news = technologyNews[indexPath.row]
            newsDetailViewController.configure(with: news)
            navigationController?.pushViewController(newsDetailViewController, animated: true)
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return categories.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        switch categories[section]{
            
            case .categories:
                return 7
            case .sources:
                return 38
            case .business:
                return 10
            case .entertainment:
                return 10
            case .general:
                return 10
            case .health:
                return 10
            case .science:
                return 10
            case .sports:
                return 10
            case .technology:
                return 10
            
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    #warning("Fix this dispatches. businessNews count is 0 at first. Then it fills the cells")
    #warning("Find a better API call")
        switch categories[indexPath.section]{
            
            case .categories:
                
                guard let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: DiscoverMainCategoryCell.identifier, for: indexPath) as? DiscoverMainCategoryCell else {return UICollectionViewCell()}
                cell.setCategoryName(with: categoryNames[indexPath.row])
                return cell
                
            case .sources:
                
                guard let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: DiscoverSourcesCell.identifier, for: indexPath) as? DiscoverSourcesCell else {return UICollectionViewCell()}
            
                DispatchQueue.main.async{
                    if self.businessNews.count != 0 {
                        cell.setSourceName(self.sources[indexPath.row])
                    }
                }
                return cell
            
            case .business:
                
                guard let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: DiscoverCategoriesCell.identifier, for: indexPath) as? DiscoverCategoriesCell else {return UICollectionViewCell()}

                DispatchQueue.main.async{
                    if self.businessNews.count != 0 {
                        cell.configure(with: self.businessNews[indexPath.row])
                    }
                }
                return cell
                
            case .entertainment:
                
                guard let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: DiscoverCategoriesCell.identifier, for: indexPath) as? DiscoverCategoriesCell else {return UICollectionViewCell()}
                
                DispatchQueue.main.async{
                    if self.entertainmentNews.count != 0 {
                        cell.configure(with: self.entertainmentNews[indexPath.row])
                    }
                }
                return cell
                
            case .general:
                
                guard let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: DiscoverCategoriesCell.identifier, for: indexPath) as? DiscoverCategoriesCell else {return UICollectionViewCell()}
                
                DispatchQueue.main.async{
                    if self.generalNews.count != 0 {
                        cell.configure(with: self.generalNews[indexPath.row])
                    }
                }
            
                return cell
                
            case .health:
                
                guard let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: DiscoverCategoriesCell.identifier, for: indexPath) as? DiscoverCategoriesCell else {return UICollectionViewCell()}
            
            DispatchQueue.main.async{
                if self.healthNews.count != 0 {
                    cell.configure(with: self.healthNews[indexPath.row])
                }
            }
                return cell
                
            case .science:
                
                guard let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: DiscoverCategoriesCell.identifier, for: indexPath) as? DiscoverCategoriesCell else {return UICollectionViewCell()}
            
            DispatchQueue.main.async{
                if self.scienceNews.count != 0 {
                    cell.configure(with: self.scienceNews[indexPath.row])
                }
            }
                return cell
                
            case .sports:
                
                guard let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: DiscoverCategoriesCell.identifier, for: indexPath) as? DiscoverCategoriesCell else {return UICollectionViewCell()}
            
            DispatchQueue.main.async{
                if self.sportsNews.count != 0 {
                    cell.configure(with: self.sportsNews[indexPath.row])
                }
            }
                return cell
                
            case .technology:
                
                guard let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: DiscoverCategoriesCell.identifier, for: indexPath) as? DiscoverCategoriesCell else {return UICollectionViewCell()}
            
            DispatchQueue.main.async{
                if self.technologyNews.count != 0 {
                    cell.configure(with: self.technologyNews[indexPath.row])
                }
            }
                return cell
            
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {

        switch kind{
        case Header.identifier:
            
            switch self.categories[indexPath.section]{
                
            case .categories:
                
                guard let header        = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                                          withReuseIdentifier: Header.identifier,
                                                                                          for: indexPath) as? Header else {return UICollectionReusableView()}
//                header.backgroundColor  = .systemGray
                header.setHeaderLabel(with: self.categoryHeaders[indexPath.section])
                header.category = .categories
                header.delegate = self
                
                return header
                
            case .sources:
                
                guard let header        = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                                          withReuseIdentifier: Header.identifier,
                                                                                          for: indexPath) as? Header else {return UICollectionReusableView()}
//                header.backgroundColor  = .systemGray
                header.setHeaderLabel(with: self.categoryHeaders[indexPath.section])
                header.category = .sources
                header.delegate = self
                
                return header
                
            case .business:
                
                guard let header        = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                                          withReuseIdentifier: Header.identifier,
                                                                                          for: indexPath) as? Header else {return UICollectionReusableView()}
//                header.backgroundColor  = .systemGray
                header.setHeaderLabel(with: self.categoryHeaders[indexPath.section])
                header.category = .business
                header.delegate = self
                
                return header
                
            case .entertainment:
                
                guard let header        = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                                          withReuseIdentifier: Header.identifier,
                                                                                          for: indexPath) as? Header else {return UICollectionReusableView()}
//                header.backgroundColor  = .systemGray
                header.setHeaderLabel(with: self.categoryHeaders[indexPath.section])
                header.category = .entertainment
                header.delegate = self
                
                return header
                
            case .general:
                
                guard let header        = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                                          withReuseIdentifier: Header.identifier,
                                                                                          for: indexPath) as? Header else {return UICollectionReusableView()}
//                header.backgroundColor  = .systemGray
                header.setHeaderLabel(with: self.categoryHeaders[indexPath.section])
                header.category = .general
                header.delegate = self
                
                return header
                
            case .health:
                
                guard let header        = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                                          withReuseIdentifier: Header.identifier,
                                                                                          for: indexPath) as? Header else {return UICollectionReusableView()}
//                header.backgroundColor  = .systemGray
                header.setHeaderLabel(with: self.categoryHeaders[indexPath.section])
                header.category = .health
                header.delegate = self
                
                return header
                
            case .science:
                
                guard let header        = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                                          withReuseIdentifier: Header.identifier,
                                                                                          for: indexPath) as? Header else {return UICollectionReusableView()}
//                header.backgroundColor  = .systemGray
                header.setHeaderLabel(with: self.categoryHeaders[indexPath.section])
                header.category = .science
                header.delegate = self
                
                return header
                
            case .sports:
                
                guard let header        = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                                          withReuseIdentifier: Header.identifier,
                                                                                          for: indexPath) as? Header else {return UICollectionReusableView()}
//                header.backgroundColor  = .systemGray
                header.setHeaderLabel(with: self.categoryHeaders[indexPath.section])
                header.category = .sports
                header.delegate = self
                
                return header
                
            case .technology:
                
                guard let header        = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                                          withReuseIdentifier: Header.identifier,
                                                                                          for: indexPath) as? Header else {return UICollectionReusableView()}
//                header.backgroundColor  = .systemGray
                header.setHeaderLabel(with: self.categoryHeaders[indexPath.section])
                header.category = .technology
                header.delegate = self
                
                return header
                
            }
        case PagingSectionFooterView.reuseIdentifier:
            
            let pagingFooter = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                               withReuseIdentifier: PagingSectionFooterView.reuseIdentifier,
                                                                               for: indexPath) as! PagingSectionFooterView

            let itemCount = 10
            pagingFooter.configure(with: itemCount)

            pagingFooter.subscribeTo(subject: pagingInfoSubject, for: indexPath.section)

            return pagingFooter
            
        default:
            return UICollectionReusableView()
        }
    }
}

extension MainViewController: HeaderDelegate{
    
    func headerDidTap(_ category: Category) {
        newsViewController.setViewController(with: category)
        navigationController?.pushViewController(newsViewController, animated: true)
    }
    
    
}

protocol HeaderDelegate: AnyObject{
    func headerDidTap(_ category: Category)
}

class Header: UICollectionReusableView {

    static let identifier       = "Header"
    var category: Category?
    weak var delegate: HeaderDelegate?
    
    private let titleLeadingPadding: CGFloat = 13
    private let imageViewTrailingPadding: CGFloat = 13

    private lazy var label: UILabel  = {

        let label   = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false

        return label

    }()
    
    private lazy var imageView: UIImageView = {
        
        let image = UIImage(systemName: "chevron.right")
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.tintColor = .white
        return imageView
        
    }()
    
    func setHeaderLabel(with sectionName: String){
        self.label.text = sectionName
    }
    
    private func applyConstraints(){
        
        let labelConstraints = [
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: titleLeadingPadding),
            label.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 5)
        ]
        
        let imageViewConstraints = [
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -imageViewTrailingPadding),
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ]
        
        NSLayoutConstraint.activate(labelConstraints)
        NSLayoutConstraint.activate(imageViewConstraints)
    }
    
    @objc private func headerDidTap(_ sender: UITapGestureRecognizer){
        print("headerDidTap")
        delegate?.headerDidTap(category!)
    }
    
    private lazy var tapGesture: UITapGestureRecognizer = {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(headerDidTap(_:)))
        
        return gesture
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(label)
        addSubview(imageView)
        
        addGestureRecognizer(tapGesture)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
        applyConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

struct PagingInfo: Equatable, Hashable {
    let sectionIndex: Int
    let currentPage: Int
}

class PagingSectionFooterView: UICollectionReusableView {
    
    static let reuseIdentifier = "PagingSectionFooterView"
    
    private lazy var pageControl: UIPageControl = {
        let control = UIPageControl()
        control.translatesAutoresizingMaskIntoConstraints = false
        control.isUserInteractionEnabled = true
        control.currentPageIndicatorTintColor = .systemOrange
        control.pageIndicatorTintColor = .systemGray2
        return control
    }()

    private var pagingInfoToken: AnyCancellable?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }

    func configure(with numberOfPages: Int) {
        pageControl.numberOfPages = numberOfPages
    }

    func subscribeTo(subject: PassthroughSubject<PagingInfo, Never>, for section: Int) {
        pagingInfoToken = subject
            .filter { $0.sectionIndex == section }
            .receive(on: DispatchQueue.main)
            .sink { [weak self] pagingInfo in
                self?.pageControl.currentPage = pagingInfo.currentPage
            }
    }

    private func setupView() {
        backgroundColor = .clear

        addSubview(pageControl)

        NSLayoutConstraint.activate([
            pageControl.centerXAnchor.constraint(equalTo: centerXAnchor),
            pageControl.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -10)
        ])
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        pagingInfoToken?.cancel()
        pagingInfoToken = nil
    }
}

class RoundedBackgroundView: UICollectionReusableView {
    
    static let reuseIdentifier = "RoundedBackgroundView"
    
    private var insetView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .secondarySystemFill
        view.layer.cornerRadius = 0
        view.clipsToBounds = true
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        addSubview(insetView)

        NSLayoutConstraint.activate([
            insetView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            insetView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            insetView.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            insetView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
}
