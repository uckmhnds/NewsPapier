//
//  NewsTableView.swift
//  NewsPapier
//
//  Created by Abdurrahman Gazi Yavuz on 12/25/22.
//

import UIKit

final class NewsTableView: UITableView{
    
    public init() {
        
        super.init(frame: .zero, style: .plain)
        
        self.register(NewsTableViewCell.self, forCellReuseIdentifier: NewsTableViewCell.identifier)
        
        backgroundColor = Theme.primaryBackground
        
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
