//
//  SideMenuViewController+Data.swift
//  NewsPapier
//
//  Created by Abdurrahman Gazi Yavuz on 12/28/22.
//

import UIKit

extension SideMenuViewController: UITableViewDelegate, UITableViewDataSource {
    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//
//        SideMenuCategories.categoryNames.count
//
//    }
    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        
//        guard let cell = tableView.dequeueReusableCell(
//                withIdentifier: "CustomTableViewCell") as? CustomTableViewCell
//        else { return UITableViewCell() }
//        cell.setUI(with: indexPath.row)
//        
//        return cell
//        
//    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        UIView.animate(withDuration: 0.3) {
//            tableView.performBatchUpdates(nil)
//        }
//    }
//
//    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
//        if let cell = tableView.cellForRow(at: indexPath) as? CustomTableViewCell {
//            cell.hideDetailView()
//        }
//    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isCollapsedArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let c = tableView.dequeueReusableCell(withIdentifier: ExpColCell.identifier, for: indexPath) as! ExpColCell

        c.setData("Top \(indexPath.row)", str2: "Bottom \(indexPath.row)\n2\n3\n4\n5", isCollapsed: isCollapsedArray[indexPath.row])

        c.didChangeHeight = { [weak self] isCollapsed in
            guard let self = self else { return }
            // update our data source
            self.isCollapsedArray[indexPath.row] = isCollapsed
            // tell the tableView to re-run its layout
            tableView.performBatchUpdates(nil, completion: nil)
        }

        return c
    }
    
}
