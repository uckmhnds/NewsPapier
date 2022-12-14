//
//  DiscoverCategorySectionsCell.swift
//  NewsPapier
//
//  Created by Abdurrahman Gazi Yavuz on 12/11/22.
//

import UIKit

class DiscoverMainCategoryCell: UICollectionViewCell {
    
    static let identifier   = "DiscoverMainCategoryCell"
    
    private let newsImageViewCornerRadius: CGFloat = 5
    private let newsImageViewPadding: CGFloat = 5
    
    private let newsTitleLabelPadding: CGFloat = 5
    
    private lazy var categoryImageView: UIImageView = {
        
        let imageView = UIImageView()
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .systemGray6
        imageView.layer.cornerRadius = newsImageViewCornerRadius
        return imageView
        
    }()
    
    private lazy var categoryTitleLabel: UILabel = {
        
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text                                      = "Category"
        #warning("fontSize")
        return label
        
    }()
    
    func setCategoryName(with title: String){
        categoryTitleLabel.text = title
    }
    
    private func applyConstraints(){
        
        let categoryImageViewConstraints = [
            categoryImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: newsImageViewPadding),
            categoryImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: newsImageViewPadding),
            categoryImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -newsImageViewPadding)
        ]
        
        let categoryTitleLabelConstraints = [
            categoryTitleLabel.topAnchor.constraint(equalTo: categoryImageView.bottomAnchor, constant: newsTitleLabelPadding),
            categoryTitleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -newsTitleLabelPadding),
            categoryTitleLabel.centerXAnchor.constraint(equalTo: categoryImageView.centerXAnchor)
        ]
            
        NSLayoutConstraint.activate(categoryImageViewConstraints)
        NSLayoutConstraint.activate(categoryTitleLabelConstraints)
        
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
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
}
