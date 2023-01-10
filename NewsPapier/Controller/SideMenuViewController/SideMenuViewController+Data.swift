//
//  SideMenuViewController+Data.swift
//  NewsPapier
//
//  Created by Abdurrahman Gazi Yavuz on 12/28/22.
//

import UIKit

extension SideMenuViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return getSectionSize(forSection: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch getSectionType(forSection: indexPath.section) {
            
        case .sectionA:
            if indexPath.row == 0{
                guard let cell = tableView.dequeueReusableCell(withIdentifier: CellA.identifier, for: indexPath) as? CellA else {return UITableViewCell()}
                cell.selectionStyle = .none
                return cell
            }else{
                guard let cell = tableView.dequeueReusableCell(withIdentifier: CellAA.identifier, for: indexPath) as? CellAA else {return UITableViewCell()}
                cell.setContent(sections[indexPath.section].elements[indexPath.row - 1])
                return cell
            }
            
        case .sectionB:
            if indexPath.row == 0{
                guard let cell = tableView.dequeueReusableCell(withIdentifier: CellB.identifier, for: indexPath) as? CellB else {return UITableViewCell()}
                return cell
            }else{
                guard let cell = tableView.dequeueReusableCell(withIdentifier: CellBB.identifier, for: indexPath) as? CellBB else {return UITableViewCell()}
                return cell
            }
            
        case .sectionC:
            if indexPath.row == 0{
                guard let cell = tableView.dequeueReusableCell(withIdentifier: CellC.identifier, for: indexPath) as? CellC else {return UITableViewCell()}
                return cell
            }else{
                guard let cell = tableView.dequeueReusableCell(withIdentifier: CellCC.identifier, for: indexPath) as? CellCC else {return UITableViewCell()}
                return cell
            }
            
        }
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.row == 0 {
            
            sections[indexPath.section].isOpened.toggle()
            
            tableView.reloadSections([indexPath.section], with: .none)

//            guard let cell = tableView.dequeueReusableCell(withIdentifier: CellA.identifier, for: indexPath) as? CellA else {return}
            
//            cell.setSelected(true, animated: false)
            
        }else{
            
            let element = sections[indexPath.section].elements[indexPath.row - 1]
            
            if let delegate = self.delegate{
                delegate.categorySelected(element)
            }
            
        }
        
    }
    
    
}
