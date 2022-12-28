//
//  HomeCollectionView.swift
//  NewsPapier
//
//  Created by Abdurrahman Gazi Yavuz on 12/25/22.
//

import UIKit
import Combine

final class HomeCollectionView: UICollectionView {
    
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
    
    public let pagingInfoSubject = PassthroughSubject<PagingInfo, Never>()
    
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
            
            let page = round(offset.x / self.superview!.bounds.width)
            self.pagingInfoSubject.send(PagingInfo(sectionIndex: sectionIndex, currentPage: Int(page)))
            
        }

        return section
        
    }
    
    private lazy var compositionalLayout: UICollectionViewCompositionalLayout = {
        
        return UICollectionViewCompositionalLayout { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
            #warning("boilerplate code")
            
            switch Category.allCases[sectionIndex]{
                
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
    
    public init(frame: CGRect){
        
        super.init(frame: frame, collectionViewLayout: UICollectionViewFlowLayout())
        
        let categoriesLayout    = compositionalLayout
        
        // Background decoration
        categoriesLayout.register(RoundedBackgroundView.self,
                                  forDecorationViewOfKind: RoundedBackgroundView.reuseIdentifier)
        
        self.collectionViewLayout = compositionalLayout
        
        self.register(DiscoverCategoriesCell.self,
                      forCellWithReuseIdentifier: DiscoverCategoriesCell.identifier)
        self.register(DiscoverMainCategoryCell.self,
                      forCellWithReuseIdentifier: DiscoverMainCategoryCell.identifier)
        self.register(DiscoverSourcesCell.self,
                      forCellWithReuseIdentifier: DiscoverSourcesCell.identifier)
        
        self.register(Header.self,
                      forSupplementaryViewOfKind: Header.identifier,
                      withReuseIdentifier: Header.identifier)
        self.register(PagingSectionFooterView.self,
                      forSupplementaryViewOfKind: PagingSectionFooterView.reuseIdentifier,
                      withReuseIdentifier: PagingSectionFooterView.reuseIdentifier)
        
        self.refreshControl = scrollDownRefreshControl
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Scroll Down Refresh
    
    @objc private func didScrollDownToRefresh(){
        
        self.refreshControl?.beginRefreshing()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + Preferences.scrollDownRefreshTime){
            
//            self.viewcontro.fetchNews()
            
            self.refreshControl?.endRefreshing()
            
        }
        
    }
    
    private lazy var scrollDownRefreshControl: UIRefreshControl = {
        
        let refreshControl  = UIRefreshControl()
        
        refreshControl.addTarget(self, action: #selector(didScrollDownToRefresh), for: .valueChanged)
        
        refreshControl.tintColor    = .white
        
        return refreshControl
        
    }()
    
    private var responseDict: [Category: [News]] = [:]
    
    func setResponseDict(by category: Category, with newsResponse: [News]){
        responseDict[category] = newsResponse
        self.reloadData()
    }
    
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//
//        switch Category.allCases[section]{
//
//            case .categories:
//                return Category.allCases.count
//            case .sources:
//                return 5
//            case .business:
//                return Preferences.pageSize
//            case .entertainment:
//                return Preferences.pageSize
//            case .general:
//                return Preferences.pageSize
//            case .health:
//                return Preferences.pageSize
//            case .science:
//                return Preferences.pageSize
//            case .sports:
//                return Preferences.pageSize
//            case .technology:
//                return Preferences.pageSize
//
//        }
//
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        return UICollectionViewCell()
//    }
    
}
