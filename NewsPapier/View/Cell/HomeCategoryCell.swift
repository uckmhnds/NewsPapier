//
//  DiscoverCategoryTableViewCell.swift
//  NewsPapier
//
//  Created by Abdurrahman Gazi Yavuz on 12/11/22.
//

import UIKit

class HomeCategoryCell: UICollectionViewCell {
    
    static let identifier   = "HomeCategoryCell"
    
    private lazy var newsImageView: UIImageView = UIImageView(contentMode: .scaleToFill,
                                                              autoLayout: false,
                                                              backgroundColor: .systemGray2,
                                                              cornerRadius: Preferences.discoverCategoryCornerRadius)
    
    private lazy var newsTitleLabel: UILabel = UILabel(autoLayout: false,
                                                       text: Preferences.midText,
                                                       lineBreakMode: .byWordWrapping,
                                                       numberOfLines: 2)
    
    func configure(with model: News){
        
        guard let imageUrl      = URL(string: model.urlToImage ?? "") else {return}
        
        newsTitleLabel.text         = model.title
        
        newsImageView.sd_setImage(with: imageUrl)
        
    }
    
    private func applyConstraints(){
        
        let newsImageViewConstraints = [
            newsImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Preferences.discoverCategoryPadding),
            newsImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Preferences.discoverCategoryPadding),
            newsImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Preferences.discoverCategoryPadding)
        ]
        
        let newsTitleLabelConstraints = [
            newsTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Preferences.discoverCategoryPadding),
            newsTitleLabel.topAnchor.constraint(equalTo: newsImageView.bottomAnchor, constant: Preferences.discoverCategoryPadding),
            newsTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Preferences.discoverCategoryPadding),
            newsTitleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Preferences.discoverCategoryPadding)
        ]
            
        NSLayoutConstraint.activate(newsImageViewConstraints)
        NSLayoutConstraint.activate(newsTitleLabelConstraints)
        
    }
    
    private func setColors(){
        backgroundColor = .clear
        
        newsTitleLabel.textColor = Theme.secondaryText
        newsTitleLabel.font = Theme.h0Title
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(newsImageView)
        contentView.addSubview(newsTitleLabel)
        
        applyConstraints()
        
        setColors()
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
}
