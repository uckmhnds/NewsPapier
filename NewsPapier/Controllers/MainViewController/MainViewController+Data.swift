//
//  MainViewController+Data.swift
//  NewsPapier
//
//  Created by Abdurrahman Gazi Yavuz on 12/12/22.
//

import UIKit

extension MainViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        switch categories[indexPath.section]{
            
        case .categories:
            break
        case .sources:
            break
        case .business:
            let news = getBusinessNews(at: indexPath.row)
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
