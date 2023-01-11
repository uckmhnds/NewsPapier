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
        
        let section: Int = indexPath.section
        
        let section1: Int = section <= 2 ? section : 2
        let section2: Int = section <= 7 ? section - 2 : 6
        
        var news: [News] = [News]()
        
        switch HomeCollectionViewLayoutCase.allCases[section1]{
            
        case .finance:
            print("didSelectItemAt " + String(indexPath.row) + " for: " + HomeCollectionViewLayoutCase.finance.name)
        case .weather:
            print("didSelectItemAt " + String(indexPath.row) + " for: " + HomeCollectionViewLayoutCase.weather.name)
        case .news:
            
            switch CategoryCase.allCases[section2]{
                
            case .business:
                
                    guard let _news = self.getResponseDict(with: .business) else {return}
                    news = _news
                
            case .entertainment:
                
                guard let _news = self.getResponseDict(with: .entertainment) else {return}
                news = _news
            
            case .general:
                
                guard let _news = self.getResponseDict(with: .general) else {return}
                news = _news
            
            case .health:
                
                guard let _news = self.getResponseDict(with: .health) else {return}
                news = _news
            
            case .science:
                
                guard let _news = self.getResponseDict(with: .science) else {return}
                news = _news
            
            case .sports:
                
                guard let _news = self.getResponseDict(with: .sports) else {return}
                news = _news
            
            case .technology:
                
                guard let _news = self.getResponseDict(with: .technology) else {return}
                news = _news
            
            }
            
            let viewController = self.getNewsDetailViewController()
            
            viewController.configure(with: news[indexPath.row])
            
            if let navController = self.navigationController{
                navController.pushViewController(viewController, animated: true)
            }
            
        }
        

    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return HomeCollectionViewLayoutCase.size
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        let section1: Int = section <= 2 ? section : 2
        let section2: Int = section <= 7 ? section - 2 : 6
        
        switch HomeCollectionViewLayoutCase.allCases[section1]{
            
        case .finance:
            return Preferences.pageSize
        case .weather:
            return Preferences.pageSize
        case .news:
            switch CategoryCase.allCases[section2]{
                
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
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let section: Int = indexPath.section
        
        let section1: Int = section <= 2 ? section : 2
        let section2: Int = section <= 7 ? section - 2 : 6
        
        switch HomeCollectionViewLayoutCase.allCases[section1]{
            
        case .finance:
            guard let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: HomeFinanceCell.identifier, for: indexPath) as? HomeFinanceCell else {return UICollectionViewCell()}
            return cell
        case .weather:
            guard let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: HomeWeatherCell.identifier, for: indexPath) as? HomeWeatherCell else {return UICollectionViewCell()}
            return cell
        case .news:
            
            guard let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCategoryCell.identifier, for: indexPath) as? HomeCategoryCell else {return UICollectionViewCell()}
            
            DispatchQueue.main.async{
                
                switch CategoryCase.allCases[section2]{
                    
                case .business:
                    if let response = self.getResponseDict(with: .business){
                        cell.configure(with: response[indexPath.row])
                    }
                case .entertainment:
                    if let response = self.getResponseDict(with: .entertainment){
                        cell.configure(with: response[indexPath.row])
                    }
                case .general:
                    if let response = self.getResponseDict(with: .general){
                        cell.configure(with: response[indexPath.row])
                    }
                case .health:
                    if let response = self.getResponseDict(with: .health){
                        cell.configure(with: response[indexPath.row])
                    }
                case .science:
                    if let response = self.getResponseDict(with: .science){
                        cell.configure(with: response[indexPath.row])
                    }
                case .sports:
                    if let response = self.getResponseDict(with: .sports){
                        cell.configure(with: response[indexPath.row])
                    }
                case .technology:
                    if let response = self.getResponseDict(with: .technology){
                        cell.configure(with: response[indexPath.row])
                    }
                }
            }
            return cell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let section: Int = indexPath.section
        
        let section1: Int = section <= 2 ? section : 2
        let section2: Int = section <= 7 ? section - 2 : 6
        
        switch kind{
            
        case Header.identifier:
            
            switch HomeCollectionViewLayoutCase.allCases[section1]{
                
            case .finance:
                
                guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: Header.identifier, for: indexPath) as? Header else {return UICollectionReusableView()}
                header.delegate = self
                return header
            case .weather:
                
                guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: Header.identifier, for: indexPath) as? Header else {return UICollectionReusableView()}
                header.delegate = self
                return header
            case .news:
                
                guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: Header.identifier, for: indexPath) as? Header else {return UICollectionReusableView()}
                
                header.delegate = self
                
                switch CategoryCase.allCases[section2]{
                    
                case .business:
                    header.setHeaderLabel(with: CategoryCase.business.object.name)
                    header.categoryCase = .business
                case .entertainment:
                    header.setHeaderLabel(with: CategoryCase.entertainment.object.name)
                    header.categoryCase = .entertainment
                case .general:
                    header.setHeaderLabel(with: CategoryCase.general.object.name)
                    header.categoryCase = .general
                case .health:
                    header.setHeaderLabel(with: CategoryCase.health.object.name)
                    header.categoryCase = .health
                case .science:
                    header.setHeaderLabel(with: CategoryCase.science.object.name)
                    header.categoryCase = .science
                case .sports:
                    header.setHeaderLabel(with: CategoryCase.sports.object.name)
                    header.categoryCase = .sports
                case .technology:
                    header.setHeaderLabel(with: CategoryCase.technology.object.name)
                    header.categoryCase = .technology
                }
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
