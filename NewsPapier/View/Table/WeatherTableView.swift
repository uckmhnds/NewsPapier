//
//  WeatherTableView.swift
//  NewsPapier
//
//  Created by Abdurrahman Gazi Yavuz on 1/19/23.
//

import UIKit

final class WeatherTableView: UITableView{
    
    public init() {
        
        super.init(frame: .zero, style: .plain)
        
        self.register(WeatherTableViewCell.self, forCellReuseIdentifier: WeatherTableViewCell.identifier)
        
        backgroundColor = Theme.primaryBackground
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
