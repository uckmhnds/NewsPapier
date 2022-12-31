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
        
        switch Category.allCases[indexPath.section]{
            
        case .categories:
            break
        case .sources:
            break
        case .business:
            
                guard let news = self.responseDict[.business] else {return}
                newsDetailViewController.configure(with: news[indexPath.row])
                navigationController?.pushViewController(newsDetailViewController, animated: true)
            
        case .entertainment:
            
            guard let news = self.responseDict[.entertainment] else {return}
            newsDetailViewController.configure(with: news[indexPath.row])
            navigationController?.pushViewController(newsDetailViewController, animated: true)
        
        case .general:
            
            guard let news = self.responseDict[.general] else {return}
            newsDetailViewController.configure(with: news[indexPath.row])
            navigationController?.pushViewController(newsDetailViewController, animated: true)
        
        case .health:
            
            guard let news = self.responseDict[.health] else {return}
            newsDetailViewController.configure(with: news[indexPath.row])
            navigationController?.pushViewController(newsDetailViewController, animated: true)
        
        case .science:
            
            guard let news = self.responseDict[.science] else {return}
            newsDetailViewController.configure(with: news[indexPath.row])
            navigationController?.pushViewController(newsDetailViewController, animated: true)
        
        case .sports:
            
            guard let news = self.responseDict[.sports] else {return}
            newsDetailViewController.configure(with: news[indexPath.row])
            navigationController?.pushViewController(newsDetailViewController, animated: true)
        
        case .technology:
            
            guard let news = self.responseDict[.technology] else {return}
            newsDetailViewController.configure(with: news[indexPath.row])
            navigationController?.pushViewController(newsDetailViewController, animated: true)
        
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return Category.allCases.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        switch Category.allCases[section]{
            
            case .categories:
                return Category.allCases.count
            case .sources:
                return 38
            case .business:
                return Preferences.pageSize
            case .entertainment:
                return Preferences.pageSize
            case .general:
                return Preferences.pageSize
            case .health:
                return Preferences.pageSize
            case .science:
                return Preferences.pageSize
            case .sports:
                return Preferences.pageSize
            case .technology:
                return Preferences.pageSize
            
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    #warning("Fix this dispatches. businessNews count is 0 at first. Then it fills the cells")
    #warning("Find a better API call")
        
        switch Category.allCases[indexPath.section]{
            
            case .categories:
                
                guard let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: DiscoverMainCategoryCell.identifier, for: indexPath) as? DiscoverMainCategoryCell else {return UICollectionViewCell()}
            
                cell.setCategoryName(with: Category.allCases[indexPath.row].rawValue.capitalizeFirstLetter())
            
                return cell
                
            case .sources:
                
                guard let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: DiscoverSourcesCell.identifier, for: indexPath) as? DiscoverSourcesCell else {return UICollectionViewCell()}
            
                DispatchQueue.main.async{
//                    cell.setSourceName(self.sources[indexPath.row])
                }
                return cell
            
            case .business:
                
                guard let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: DiscoverCategoriesCell.identifier, for: indexPath) as? DiscoverCategoriesCell else {return UICollectionViewCell()}

                DispatchQueue.main.async{
                    
                    guard let response = self.responseDict[.business] else{return}
                    cell.configure(with: response[indexPath.row])
                    
                }
            
                return cell
                
            case .entertainment:
                
                guard let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: DiscoverCategoriesCell.identifier, for: indexPath) as? DiscoverCategoriesCell else {return UICollectionViewCell()}
                
                DispatchQueue.main.async{
                    
                    guard let response = self.responseDict[.entertainment] else{return}
                    cell.configure(with: response[indexPath.row])
                    
                }
                return cell
                
            case .general:
                
                guard let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: DiscoverCategoriesCell.identifier, for: indexPath) as? DiscoverCategoriesCell else {return UICollectionViewCell()}
                
                DispatchQueue.main.async{
                    
                    guard let response = self.responseDict[.general] else{return}
                    cell.configure(with: response[indexPath.row])
                    
                }
            
                return cell
                
            case .health:
                
                guard let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: DiscoverCategoriesCell.identifier, for: indexPath) as? DiscoverCategoriesCell else {return UICollectionViewCell()}
            
                DispatchQueue.main.async{
                    
                    guard let response = self.responseDict[.health] else{return}
                    cell.configure(with: response[indexPath.row])
                    
                }
                return cell
                
            case .science:
                
                guard let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: DiscoverCategoriesCell.identifier, for: indexPath) as? DiscoverCategoriesCell else {return UICollectionViewCell()}
            
                DispatchQueue.main.async{
                    
                    guard let response = self.responseDict[.science] else{return}
                    cell.configure(with: response[indexPath.row])
                    
                }
                return cell
                
            case .sports:
                
                guard let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: DiscoverCategoriesCell.identifier, for: indexPath) as? DiscoverCategoriesCell else {return UICollectionViewCell()}
            
                DispatchQueue.main.async{
                    
                    guard let response = self.responseDict[.sports] else{return}
                    cell.configure(with: response[indexPath.row])
                    
                }
                return cell
                
            case .technology:
                
                guard let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: DiscoverCategoriesCell.identifier, for: indexPath) as? DiscoverCategoriesCell else {return UICollectionViewCell()}
            
                DispatchQueue.main.async{
                    
                    guard let response = self.responseDict[.technology] else{return}
                    cell.configure(with: response[indexPath.row])
                    
                }
                return cell
            
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {

        switch kind{
            
        case Header.identifier:
            
            switch Category.allCases[indexPath.section]{
                
            case .categories:
                
                guard let header        = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                                          withReuseIdentifier: Header.identifier,
                                                                                          for: indexPath) as? Header else {return UICollectionReusableView()}
//                header.backgroundColor  = .systemGray
                header.setHeaderLabel(with: Category.allCases[indexPath.section].rawValue.capitalizeFirstLetter())
                header.category = .categories
                header.delegate = self
                
                return header
                
            case .sources:
                
                guard let header        = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                                          withReuseIdentifier: Header.identifier,
                                                                                          for: indexPath) as? Header else {return UICollectionReusableView()}
//                header.backgroundColor  = .systemGray
                header.setHeaderLabel(with: Category.allCases[indexPath.section].rawValue.capitalizeFirstLetter())
                header.category = .sources
                header.delegate = self
                
                return header
                
            case .business:
                
                guard let header        = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                                          withReuseIdentifier: Header.identifier,
                                                                                          for: indexPath) as? Header else {return UICollectionReusableView()}
//                header.backgroundColor  = .systemGray
                header.setHeaderLabel(with: Category.allCases[indexPath.section].rawValue.capitalizeFirstLetter())
                header.category = .business
                header.delegate = self
                
                return header
                
            case .entertainment:
                
                guard let header        = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                                          withReuseIdentifier: Header.identifier,
                                                                                          for: indexPath) as? Header else {return UICollectionReusableView()}
//                header.backgroundColor  = .systemGray
                header.setHeaderLabel(with: Category.allCases[indexPath.section].rawValue.capitalizeFirstLetter())
                header.category = .entertainment
                header.delegate = self
                
                return header
                
            case .general:
                
                guard let header        = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                                          withReuseIdentifier: Header.identifier,
                                                                                          for: indexPath) as? Header else {return UICollectionReusableView()}
//                header.backgroundColor  = .systemGray
                header.setHeaderLabel(with: Category.allCases[indexPath.section].rawValue.capitalizeFirstLetter())
                header.category = .general
                header.delegate = self
                
                return header
                
            case .health:
                
                guard let header        = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                                          withReuseIdentifier: Header.identifier,
                                                                                          for: indexPath) as? Header else {return UICollectionReusableView()}
//                header.backgroundColor  = .systemGray
                header.setHeaderLabel(with: Category.allCases[indexPath.section].rawValue.capitalizeFirstLetter())
                header.category = .health
                header.delegate = self
                
                return header
                
            case .science:
                
                guard let header        = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                                          withReuseIdentifier: Header.identifier,
                                                                                          for: indexPath) as? Header else {return UICollectionReusableView()}
//                header.backgroundColor  = .systemGray
                header.setHeaderLabel(with: Category.allCases[indexPath.section].rawValue.capitalizeFirstLetter())
                header.category = .science
                header.delegate = self
                
                return header
                
            case .sports:
                
                guard let header        = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                                          withReuseIdentifier: Header.identifier,
                                                                                          for: indexPath) as? Header else {return UICollectionReusableView()}
//                header.backgroundColor  = .systemGray
                header.setHeaderLabel(with: Category.allCases[indexPath.section].rawValue.capitalizeFirstLetter())
                header.category = .sports
                header.delegate = self
                
                return header
                
            case .technology:
                
                guard let header        = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                                          withReuseIdentifier: Header.identifier,
                                                                                          for: indexPath) as? Header else {return UICollectionReusableView()}
//                header.backgroundColor  = .systemGray
                header.setHeaderLabel(with: Category.allCases[indexPath.section].rawValue.capitalizeFirstLetter())
                header.category = .technology
                header.delegate = self
                
                return header
                
            }
        case PagingSectionFooterView.reuseIdentifier:
            
            let pagingFooter = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                               withReuseIdentifier: PagingSectionFooterView.reuseIdentifier,
                                                                               for: indexPath) as! PagingSectionFooterView
            
            guard let view = collectionView as? HomeCollectionView else {return UICollectionReusableView()}

            let itemCount = 10
            pagingFooter.configure(with: itemCount)

            pagingFooter.subscribeTo(subject: view.pagingInfoSubject, for: indexPath.section)

            return pagingFooter
            
        default:
            return UICollectionReusableView()
        }
    }
}
