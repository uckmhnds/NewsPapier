//
//  SideMenuViewController+Data.swift
//  NewsPapier
//
//  Created by Abdurrahman Gazi Yavuz on 12/28/22.
//

import UIKit

extension SideMenuViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch SideMenuSectionCase.allCases[section]{
            
        case .category:
            return SideMenuSectionCase.category.object.isOpened ? SideMenuSectionCase.category.size : 1
        case .region:
            return SideMenuSectionCase.category.object.isOpened ? SideMenuSectionCase.region.size : 1
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
            
        switch SideMenuSectionCase.allCases[indexPath.section]{
            
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
                return cell
            }else{
                guard let cell = tableView.dequeueReusableCell(withIdentifier: SideMenuRegionCellAA.identifier, for: indexPath) as? SideMenuRegionCellAA else {return UITableViewCell()}
                return cell
            }
        }
        
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return SideMenuSectionCase.allCases.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch SideMenuSectionCase.allCases[indexPath.section]{
            
        case .category:
            
            if indexPath.row == 0 {
                
//                sections[indexPath.section].object.isOpened.toggle()
//
//                tableView.reloadSections([indexPath.section], with: .none)

                guard let cell = tableView.dequeueReusableCell(withIdentifier: SideMenuCategoryCellA.identifier, for: indexPath) as? SideMenuCategoryCellA else {return}
                
    //            cell.setSelected(true, animated: false)
                cell.animateWhenSelected()
                
            }else{
                
                switch CategoryCase.allCases[indexPath.row - 1]{
                    
                case .business:
                    if let delegate = self.delegate{
                        delegate.categorySelected(.business)
                    }
                case .entertainment:
                    if let delegate = self.delegate{
                        delegate.categorySelected(.entertainment)
                    }
                case .general:
                    if let delegate = self.delegate{
                        delegate.categorySelected(.general)
                    }
                case .health:
                    if let delegate = self.delegate{
                        delegate.categorySelected(.health)
                    }
                case .science:
                    if let delegate = self.delegate{
                        delegate.categorySelected(.science)
                    }
                case .sports:
                    if let delegate = self.delegate{
                        delegate.categorySelected(.sports)
                    }
                case .technology:
                    if let delegate = self.delegate{
                        delegate.categorySelected(.technology)
                    }
                }
                
            }
        case .region:
            break
        }
        
    }
    
    
}
