//
//  DiscoverSourcesCell.swift
//  NewsPapier
//
//  Created by Abdurrahman Gazi Yavuz on 12/11/22.
//

import UIKit

class DiscoverSourcesCell: UICollectionViewCell {
    
    static let identifier   = "DiscoverSourcesCell"
    
    private let newsTitleLabelPadding: CGFloat = 10
    private let cornerRadius: CGFloat = 8
    #warning("Fix newsTitleLabel to environment var names. Specific names. i.e. sourceLabel")
    private lazy var newsTitleLabel: UILabel = {
        
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.lineBreakMode                             = .byWordWrapping
        label.numberOfLines                             = 2
        label.text                                      = "SourceNameHere"
        
        return label
        
    }()
    
    private func applyConstraints(){
        
        let newsTitleLabelConstraints = [
            newsTitleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            newsTitleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ]
            
        NSLayoutConstraint.activate(newsTitleLabelConstraints)
        
    }
    
    func setSourceName(_ source: Source){
        newsTitleLabel.text = source.name
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.backgroundColor     = .systemGray6
        contentView.layer.cornerRadius  = cornerRadius
        contentView.addSubview(newsTitleLabel)
        
        applyConstraints()
        
    }

}
