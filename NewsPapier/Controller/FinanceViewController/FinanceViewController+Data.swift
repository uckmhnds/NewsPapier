//
//  FinanceViewController+Data.swift
//  NewsPapier
//
//  Created by Abdurrahman Gazi Yavuz on 1/22/23.
//

import UIKit

extension FinanceViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.financeResponseDict.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FinanceTableViewCell.identifier, for: indexPath) as? FinanceTableViewCell else { return UITableViewCell()}
        
        let index = indexPath.row
        
        let dict = self.financeResponseDict[index]
        
        cell.setFinance(dict.value)
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        
        let viewController = FinanceDetailViewController()
        
        #warning("Navigation a lil bit freezez animation")
        #warning("Later: figured out due to empty background color")
        if let navController = self.navigationController{
            navController.pushViewController(viewController, animated: true)
        }
    }
    
}

