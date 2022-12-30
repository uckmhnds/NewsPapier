//
//  HomeCollectionView.swift
//  NewsPapier
//
//  Created by Abdurrahman Gazi Yavuz on 12/25/22.
//

import UIKit
import Combine

final class HomeCollectionView: UICollectionView {
    
    public let pagingInfoSubject = PassthroughSubject<PagingInfo, Never>()
    
    //
    // Collection View
    //
    
    private lazy var headerBoundarySupplementaryItem: NSCollectionLayoutBoundarySupplementaryItem = {
        
        let item = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: .init(widthDimension: .fractionalWidth(Preferences.headerItemFractionalWidth),
                                                                                 heightDimension: .estimated(Preferences.headerItemHeight)),
                                                               elementKind: Header.identifier,
                                                               alignment: .top,
                                                               absoluteOffset: CGPoint(x: Preferences.headerItemOffsetX, y: Preferences.headerItemOffsetY))
        return item
        
    }()
    
    private lazy var footerBoundarySupplementaryItem: NSCollectionLayoutBoundarySupplementaryItem = {
        
        let footerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(Preferences.footerItemFractionalWidth), heightDimension: .absolute(Preferences.footerItemHeight))

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
        
        let item = CompositionalLayout.createItem(width: .fractionalWidth(Preferences.primaryItemWidthFraction),
                                                  height: .fractionalHeight(Preferences.primaryItemHeightFraction),
                                                  spacing: Preferences.primaryItemPadding)

        let group = CompositionalLayout.createGroup(alignment: .vertical,
                                                    width: .fractionalWidth(Preferences.primaryGroupWidthFraction),
                                                    height: .fractionalHeight(Preferences.primaryGroupHeightFraction),
                                                    items: [item])

        let section = NSCollectionLayoutSection(group: group)

        section.contentInsets                   = Preferences.primaryContentInset
        section.orthogonalScrollingBehavior     = .continuous
        section.boundarySupplementaryItems      = [self.headerBoundarySupplementaryItem]
        section.decorationItems                 = [self.collectionLayoutBackgroundDecoration]

        return section
        
    }
    
    private func sourcesSection() -> NSCollectionLayoutSection{
        
        let item = CompositionalLayout.createItem(width: .fractionalWidth(Preferences.secondaryItemWidthFraction),
                                                  height: .fractionalHeight(Preferences.secondaryItemHeightFraction),
                                                  spacing: Preferences.secondaryItemPadding)

        let group = CompositionalLayout.createGroup(alignment: .vertical,
                                                    width: .fractionalWidth(Preferences.secondaryGroupWidthFraction),
                                                    height: .fractionalHeight(Preferences.secondaryGroupHeightFraction),
                                                    items: [item])

        let section = NSCollectionLayoutSection(group: group)

        section.contentInsets                   = Preferences.secondaryContentInset
        section.orthogonalScrollingBehavior     = .continuous
        section.boundarySupplementaryItems      = [self.headerBoundarySupplementaryItem]
        section.decorationItems                 = [self.collectionLayoutBackgroundDecoration]

        return section
        
    }
    
    private func categorySection(_ sectionIndex: Int) -> NSCollectionLayoutSection {
        
        let item = CompositionalLayout.createItem(width: .fractionalWidth(Preferences.tertiaryItemWidthFraction),
                                                  height: .fractionalHeight(Preferences.tertiaryItemHeightFraction),
                                                  spacing: Preferences.tertiaryItemPadding)

        let group = CompositionalLayout.createGroup(alignment: .vertical,
                                                    width: .fractionalWidth(Preferences.tertiaryGroupWidthFraction),
                                                    height: .fractionalHeight(Preferences.tertiaryGroupHeightFraction),
                                                    items: [item])

        let section = NSCollectionLayoutSection(group: group)

        section.contentInsets                   = Preferences.tertiaryContentInset
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
    
    private func setColors(){
        backgroundColor = Theme.primaryBackground
    }
    
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
        
        setColors()
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
        
        refreshControl.tintColor    = Theme.primaryText
        
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
