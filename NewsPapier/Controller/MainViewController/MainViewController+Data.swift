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
        
        let sectionIndex: Int = indexPath.section
        
        if let section = self.collectionViewSections[sectionIndex] as? HomeCollectionFinanceSection
        {
            print("didSelectItemAt " + String(indexPath.row) + " for: " + section.name)
        }
        else if let section = self.collectionViewSections[sectionIndex] as? HomeCollectionWeatherSection
        {
            print("didSelectItemAt " + String(indexPath.row) + " for: " + section.name)
        }
        else if let section = self.collectionViewSections[sectionIndex] as? HomeCollectionCategorySection
        {
            var news: [News] = [News]()
            
            switch section._case{
            
            case .business:
                guard let _news = self.getNewsResponseDict(with: .business) else {return}
                news = _news
            case .entertainment:
                guard let _news = self.getNewsResponseDict(with: .entertainment) else {return}
                news = _news
            case .general:
                guard let _news = self.getNewsResponseDict(with: .general) else {return}
                news = _news
            case .health:
                guard let _news = self.getNewsResponseDict(with: .health) else {return}
                news = _news
            case .science:
                guard let _news = self.getNewsResponseDict(with: .science) else {return}
                news = _news
            case .sports:
                guard let _news = self.getNewsResponseDict(with: .sports) else {return}
                news = _news
            case .technology:
                guard let _news = self.getNewsResponseDict(with: .technology) else {return}
                news = _news
            }
            let viewController = self.getNewsDetailViewController()
            
            viewController.configure(with: news[indexPath.row])
            
            if let navController = self.navigationController{
                navController.pushViewController(viewController, animated: true)
            }
        }
        else
        {
            return
        }

    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.collectionViewSections.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if let _ = self.collectionViewSections[section] as? HomeCollectionFinanceSection
        {
            return FinanceCase.size
        }
        else if let _ = self.collectionViewSections[section] as? HomeCollectionWeatherSection
        {
            return WeatherCase.size
        }
        else if let _section = self.collectionViewSections[section] as? HomeCollectionCategorySection
        {
            switch _section._case{
                
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
        else
        {
            return 0
        }

    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let sectionIndex: Int = indexPath.section
        
        if let _ = self.collectionViewSections[sectionIndex] as? HomeCollectionFinanceSection
        {
            
            guard let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: HomeFinanceCell.identifier, for: indexPath) as? HomeFinanceCell else {return UICollectionViewCell()}
            
            let _case = FinanceCase.allCases[indexPath.row]
            
            if let finance = self.getFinanceDict(with: _case){
                cell.setFinance(finance)
            }
            return cell
            
        }
        else if let _ = self.collectionViewSections[sectionIndex] as? HomeCollectionWeatherSection
        {
            
            guard let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: HomeWeatherCell.identifier, for: indexPath) as? HomeWeatherCell else {return UICollectionViewCell()}
            
            let _case = WeatherCase.allCases[indexPath.row]
            
            if let weather = self.getWeatherDict(with: _case){
                cell.setWeather(weather)
            }
            return cell
            
        }
        else if let section = self.collectionViewSections[sectionIndex] as? HomeCollectionCategorySection
        {
            
            guard let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCategoryCell.identifier, for: indexPath) as? HomeCategoryCell else {return UICollectionViewCell()}
            
            switch section._case
            {
            case .business:
                if let response = self.getNewsResponseDict(with: .business){
                    cell.configure(with: response[indexPath.row])
                }
            case .entertainment:
                if let response = self.getNewsResponseDict(with: .entertainment){
                    cell.configure(with: response[indexPath.row])
                }
            case .general:
                if let response = self.getNewsResponseDict(with: .general){
                    cell.configure(with: response[indexPath.row])
                }
            case .health:
                if let response = self.getNewsResponseDict(with: .health){
                    cell.configure(with: response[indexPath.row])
                }
            case .science:
                if let response = self.getNewsResponseDict(with: .science){
                    cell.configure(with: response[indexPath.row])
                }
            case .sports:
                if let response = self.getNewsResponseDict(with: .sports){
                    cell.configure(with: response[indexPath.row])
                }
            case .technology:
                if let response = self.getNewsResponseDict(with: .technology){
                    cell.configure(with: response[indexPath.row])
                }
            }
            
            return cell
        }
        else
        {
            return UICollectionViewCell()
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        switch kind
        {
        case Header.identifier:
        
            let sectionIndex: Int = indexPath.section
            
            if let _ = self.collectionViewSections[sectionIndex] as? HomeCollectionFinanceSection
            {
                guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: Header.identifier, for: indexPath) as? Header else {return UICollectionReusableView()}
                header.delegate = self
                header.setHeaderLabel(with: HomeCollectionSectionType.finance.name)
                return header
            }
            else if let _ = self.collectionViewSections[sectionIndex] as? HomeCollectionWeatherSection
            {
                guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: Header.identifier, for: indexPath) as? Header else {return UICollectionReusableView()}
                header.delegate = self
                header.setHeaderLabel(with: HomeCollectionSectionType.weather.name)
                return header
            }
            else if let section = self.collectionViewSections[sectionIndex] as? HomeCollectionCategorySection
            {
                
                guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: Header.identifier, for: indexPath) as? Header else {return UICollectionReusableView()}
                
                header.delegate = self
                
                switch section._case{
                    
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
            else
            {
                return UICollectionReusableView()
            }
            
        case PagingSectionFooterView.identifier:
            
            let pagingFooter = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                               withReuseIdentifier: PagingSectionFooterView.identifier,
                                                                               for: indexPath) as! PagingSectionFooterView
            
            guard let view = collectionView as? HomeCollectionView else {return UICollectionReusableView()}

            let itemCount = Preferences.pageSize
            
            pagingFooter.configure(with: itemCount)

            pagingFooter.subscribeTo(subject: view.pagingInfoSubject, for: indexPath.section)

            return pagingFooter
            
        default:
            return UICollectionReusableView()
        }

    }
    
}
