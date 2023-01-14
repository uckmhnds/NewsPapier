//
//  SideMenuViewController+Data.swift
//  NewsPapier
//
//  Created by Abdurrahman Gazi Yavuz on 12/28/22.
//

import UIKit

extension SideMenuViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let presentSection = self.sections[section]
        
        return presentSection.viewedSize
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let presentSection = self.sections[indexPath.section]
        
        switch presentSection.type{
        
        case .category:
            
            if indexPath.row == 0{
                
                guard let cell = tableView.dequeueReusableCell(withIdentifier: SideMenuCategoryCellA.identifier, for: indexPath) as? SideMenuCategoryCellA else {return UITableViewCell()}
                
                cell.selectionStyle = .none
                
                return cell
            }else{
                
                guard let cell = tableView.dequeueReusableCell(withIdentifier: SideMenuCategoryCellAA.identifier, for: indexPath) as? SideMenuCategoryCellAA else {return UITableViewCell()}

                switch CategoryCase.allCases[indexPath.row - 1]{

                case .business:
                    cell.setContent(.business)
                case .entertainment:
                    cell.setContent(.entertainment)
                case .general:
                    cell.setContent(.general)
                case .health:
                    cell.setContent(.health)
                case .science:
                    cell.setContent(.science)
                case .sports:
                    cell.setContent(.sports)
                case .technology:
                    cell.setContent(.technology)
                }
                
                return cell
            }
            
        case .region:
            
            if indexPath.row == 0{
                
                guard let cell = tableView.dequeueReusableCell(withIdentifier: SideMenuRegionCellA.identifier, for: indexPath) as? SideMenuRegionCellA else {return UITableViewCell()}
                
                cell.selectionStyle = .none
                
                return cell
            }else{
                
                guard let cell = tableView.dequeueReusableCell(withIdentifier: SideMenuRegionCellAA.identifier, for: indexPath) as? SideMenuRegionCellAA else {return UITableViewCell()}
                
                switch CountryCase.allCases[indexPath.row - 1]{
                    
                case .us:
                    cell.setContent(.us)
                case .de:
                    cell.setContent(.de)
                case .fr:
                    cell.setContent(.fr)
                case .gb:
                    cell.setContent(.gb)
                case .it:
                    cell.setContent(.it)
                case .nl:
                    cell.setContent(.nl)
                }
                
                return cell
            }
            
        }
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.sections.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        let presentSection = self.sections[indexPath.section]
        
        if indexPath.row == 0 {
            
            presentSection.toggle()
            
            tableView.reloadSections(IndexSet(integer: indexPath.section), with: .none)
            
        }else{
            
            switch presentSection.type{
                
            case .category:
                
                if let delegate = self.delegate,
                    let section = self.sections[indexPath.section] as? SideMenuCategorySection{
                    delegate.categorySelected(section.items[indexPath.row - 1])
                }
                
            case .region:
                
                if let delegate = self.delegate,
                    let section = self.sections[indexPath.section] as? SideMenuCountrySection{
                    delegate.countrySelected(section.items[indexPath.row - 1])
                }
                
            }
            
        }
        
    }
    
}
