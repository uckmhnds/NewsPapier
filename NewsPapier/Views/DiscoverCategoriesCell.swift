//
//  DiscoverCategoryTableViewCell.swift
//  NewsPapier
//
//  Created by Abdurrahman Gazi Yavuz on 12/11/22.
//

import UIKit

class DiscoverCategoriesCell: UICollectionViewCell {
    
    static let identifier   = "DiscoverCategoryCollectionViewCell"
    
    private let newsImageViewCornerRadius: CGFloat = 8
    private let newsImageViewPadding: CGFloat = 10
    
    private let newsTitleLabelPadding: CGFloat = 10
    
    private lazy var newsImageView: UIImageView = {
        
        let imageView = UIImageView()
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .systemGray2
        imageView.layer.cornerRadius = newsImageViewCornerRadius
        imageView.contentMode = .scaleToFill
        return imageView
        
    }()
    
    private lazy var newsTitleLabel: UILabel = {
        
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.lineBreakMode                             = .byWordWrapping
        label.numberOfLines                             = 2
        label.text = "This is the title of news. This title should be wrapped by layout settings"
        
        return label
        
    }()
    
    func configure(with model: News){
        
        guard let imageUrl      = URL(string: model.urlToImage ?? "") else {return}
        
        newsTitleLabel.text         = model.title
        
        newsImageView.sd_setImage(with: imageUrl)
        
    }
    
    private func applyConstraints(){
        
        let newsImageViewConstraints = [
            newsImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: newsImageViewPadding),
            newsImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: newsImageViewPadding),
            newsImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -newsImageViewPadding)
        ]
        
        let newsTitleLabelConstraints = [
            newsTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: newsTitleLabelPadding),
            newsTitleLabel.topAnchor.constraint(equalTo: newsImageView.bottomAnchor, constant: newsTitleLabelPadding),
            newsTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -newsTitleLabelPadding),
            newsTitleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -newsTitleLabelPadding)
        ]
            
        NSLayoutConstraint.activate(newsImageViewConstraints)
        NSLayoutConstraint.activate(newsTitleLabelConstraints)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
//        contentView.backgroundColor     = .systemGray6
        
        contentView.addSubview(newsImageView)
        contentView.addSubview(newsTitleLabel)
        
        applyConstraints()
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
}
