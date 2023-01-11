//
//  DiscoverCategorySectionsCell.swift
//  NewsPapier
//
//  Created by Abdurrahman Gazi Yavuz on 12/11/22.
//

import UIKit

class HomeFinanceCell: UICollectionViewCell {
    
    static let identifier   = "HomeFinanceCell"
    
    private lazy var categoryImageView: UIImageView = {
        
        let imageView = UIImageView()
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .systemGray6
        imageView.layer.cornerRadius = Preferences.discoverMainCornerRadius
        return imageView
        
    }()
    
    private lazy var categoryTitleLabel: UILabel = {
        
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text                                      = "Category"
        return label
        
    }()
    
    func setCategoryName(with title: String){
        categoryTitleLabel.text = title
    }
    
    private func applyConstraints(){
        
        let categoryImageViewConstraints = [
            categoryImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Preferences.discoverMainPadding),
            categoryImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Preferences.discoverMainPadding),
            categoryImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Preferences.discoverMainPadding)
        ]
        
        let categoryTitleLabelConstraints = [
            categoryTitleLabel.topAnchor.constraint(equalTo: categoryImageView.bottomAnchor, constant: Preferences.discoverMainPadding),
            categoryTitleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Preferences.discoverMainPadding),
            categoryTitleLabel.centerXAnchor.constraint(equalTo: categoryImageView.centerXAnchor)
        ]
            
        NSLayoutConstraint.activate(categoryImageViewConstraints)
        NSLayoutConstraint.activate(categoryTitleLabelConstraints)
        
    }
    
    private func setColors(){
        backgroundColor = Theme.secondaryBackground
        categoryTitleLabel.font = Theme.h0Title
        categoryTitleLabel.textColor = Theme.secondaryText
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
//        contentView.backgroundColor     = .systemGray6
        
        contentView.addSubview(categoryImageView)
        contentView.addSubview(categoryTitleLabel)
        
        applyConstraints()
        setColors()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
}
