//
//  SideMenuRegionCell.swift
//  NewsPapier
//
//  Created by Abdurrahman Gazi Yavuz on 1/11/23.
//

import UIKit

class SideMenuRegionCellA: UITableViewCell {
    
    static let identifier: String = "SideMenuRegionCellA"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .yellow
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
}

class SideMenuRegionCellAA: UITableViewCell {
    
    static let identifier: String = "SideMenuRegionCellAA"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .systemYellow
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
}
