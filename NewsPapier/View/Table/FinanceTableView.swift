//
//  FinanceTableView.swift
//  NewsPapier
//
//  Created by Abdurrahman Gazi Yavuz on 1/19/23.
//

import UIKit

final class FinanceTableView: UITableView{
    
    public init() {
        
        super.init(frame: .zero, style: .grouped)
        
        self.register(FinanceTableViewCell.self, forCellReuseIdentifier: FinanceTableViewCell.identifier)
        self.register(FinanceTableViewHeader.self, forHeaderFooterViewReuseIdentifier: FinanceTableViewHeader.identifier)
        
        backgroundColor = Theme.primaryBackground
        
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
