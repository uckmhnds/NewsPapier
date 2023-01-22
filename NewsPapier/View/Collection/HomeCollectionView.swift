//
//  HomeCollectionView.swift
//  NewsPapier
//
//  Created by Abdurrahman Gazi Yavuz on 12/25/22.
//

import UIKit
import Combine

protocol HomeCollectionViewDataSource: AnyObject{
    var dataSource: [any HomeCollectionBaseSection] { get }
}

final class HomeCollectionView: UICollectionView {
    
    public let pagingInfoSubject = PassthroughSubject<PagingInfo, Never>()
    
    weak var sectionDataSource: HomeCollectionViewDataSource?
    
    private var sections: [any HomeCollectionBaseSection]? {
        
        if let delegate = self.sectionDataSource{
            return delegate.dataSource
        }
        
        return nil
    }
    
    //
    // Collection View
    //
    
    private lazy var headerBoundarySupplementaryItem: NSCollectionLayoutBoundarySupplementaryItem = {
        
        let item = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: .init(widthDimension: .fractionalWidth(Preferences.headerItemFractionalWidth),
                                                                                 heightDimension: .estimated(Preferences.headerItemHeight)),
                                                               elementKind: MainCollectionViewHeader.identifier,
                                                               alignment: .top,
                                                               absoluteOffset: CGPoint(x: Preferences.headerItemOffsetX, y: Preferences.headerItemOffsetY))
        return item
        
    }()
    
    private lazy var footerBoundarySupplementaryItem: NSCollectionLayoutBoundarySupplementaryItem = {
        
        let footerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(Preferences.footerItemFractionalWidth), heightDimension: .absolute(Preferences.footerItemHeight))

        let item = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: footerSize,
                                                                              elementKind: PagingSectionFooterView.identifier,
                                                                              alignment: .bottom)
        
        return item
        
    }()
    
    private lazy var collectionLayoutBackgroundDecoration: NSCollectionLayoutDecorationItem = {
        
        let item = NSCollectionLayoutDecorationItem.background(elementKind: MainCollectionBackgroundView.reuseIdentifier)
        return item
        
    }()
    
    private func financeSection() -> NSCollectionLayoutSection{
        
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
    
    private func weatherSection() -> NSCollectionLayoutSection{
        
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
            
            if let sections = self.sections,
               let section = sections[sectionIndex] as? HomeCollectionFinanceSection
            {
                return self.financeSection()
            }
            else if let sections = self.sections,
                let section = sections[sectionIndex] as? HomeCollectionWeatherSection
            {
                return self.weatherSection()
            }
            else if let sections = self.sections,
                let section = sections[sectionIndex] as? HomeCollectionCategorySection
            {
                return self.categorySection(sectionIndex)
            }
            else
            {
                return nil
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
        categoriesLayout.register(MainCollectionBackgroundView.self,
                                  forDecorationViewOfKind: MainCollectionBackgroundView.reuseIdentifier)
        
        self.collectionViewLayout = compositionalLayout
        
        self.register(HomeCategoryCell.self,
                      forCellWithReuseIdentifier: HomeCategoryCell.identifier)
        self.register(HomeFinanceCell.self,
                      forCellWithReuseIdentifier: HomeFinanceCell.identifier)
        self.register(HomeWeatherCell.self,
                      forCellWithReuseIdentifier: HomeWeatherCell.identifier)
        
        self.register(MainCollectionViewHeader.self,
                      forSupplementaryViewOfKind: MainCollectionViewHeader.identifier,
                      withReuseIdentifier: MainCollectionViewHeader.identifier)
        self.register(PagingSectionFooterView.self,
                      forSupplementaryViewOfKind: PagingSectionFooterView.identifier,
                      withReuseIdentifier: PagingSectionFooterView.identifier)
        
        self.refreshControl = scrollDownRefreshControl
        
        setColors()
        
//        for _case in HomeCollectionSectionType.allCases{
//
//            switch _case{
//
//            case .finance:
//
//                sections.append(HomeCollectionFinanceSection())
//            case .weather:
//
//                sections.append(HomeCollectionWeatherSection())
//            case .news:
//
//                for _collectionCase in CategoryCase.allCases{
//
//                    switch _collectionCase{
//
//                    case .business:
//                        sections.append(HomeCollectionCategorySection(.business))
//                    case .entertainment:
//                        sections.append(HomeCollectionCategorySection(.entertainment))
//                    case .general:
//                        sections.append(HomeCollectionCategorySection(.general))
//                    case .health:
//                        sections.append(HomeCollectionCategorySection(.health))
//                    case .science:
//                        sections.append(HomeCollectionCategorySection(.science))
//                    case .sports:
//                        sections.append(HomeCollectionCategorySection(.sports))
//                    case .technology:
//                        sections.append(HomeCollectionCategorySection(.technology))
//                    }
//
//                }
//            }
//        }
        
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
    
    private var responseDict: [CategoryCase: [News]] = [:]
    
    func setResponseDict(by categoryCase: CategoryCase, with newsResponse: [News]){
        responseDict[categoryCase] = newsResponse
        self.reloadData()
    }
    
}
