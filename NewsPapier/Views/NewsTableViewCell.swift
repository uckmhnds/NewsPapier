//
//  NewsPosterTableViewCell.swift
//  NewsPapier
//
//  Created by Abdurrahman Gazi Yavuz on 30.09.2022.
//

import UIKit
import SDWebImage
class NewsTableViewCell: UITableViewCell {
    
    static let identifier   = "NewsPosterTableViewCell"
    
    // SUB VIEWS
    
    private let bookmarkButton: UIButton = {
        
        let button  = UIButton()
        let image   = UIImage(systemName: "bookmark", withConfiguration: UIImage.SymbolConfiguration(pointSize: 24))
        button.setImage(image, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .systemRed
        return button
        
    }()
    
    private let newsPosterImage: UIImageView = {
        let image           = UIImageView()
        
        image.contentMode   = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        image.clipsToBounds = true
        
        return image
    }()
    
    
    private let titleLabel: UILabel = {
        
        let label   = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.lineBreakMode                             = .byWordWrapping
        label.numberOfLines                             = 0
        label.textColor                                 = .white
    
        return label
    }()
    
    // CONSTRAINT VIEWS
    
    private func applyConstraints(){
        
        let titleLabelConstraints       = [
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            titleLabel.bottomAnchor.constraint(equalTo: newsPosterImage.topAnchor, constant: -10)
        ]
        
        let newsPosterImageConstraint   = [
            newsPosterImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            newsPosterImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            newsPosterImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ]
        
        let bookmarkButtonConstraint    = [
            bookmarkButton.trailingAnchor.constraint(equalTo: newsPosterImage.trailingAnchor, constant: -10),
            bookmarkButton.topAnchor.constraint(equalTo: newsPosterImage.topAnchor, constant: 10)
        ]
        
        NSLayoutConstraint.activate(titleLabelConstraints)
        NSLayoutConstraint.activate(newsPosterImageConstraint)
        NSLayoutConstraint.activate(bookmarkButtonConstraint)
        
    }
    
    // CONFIGURE CONTENT
    
    func configure(with model: News){
        
        guard let imageUrl      = URL(string: model.urlToImage ?? "") else {return}
        
        titleLabel.text         = model.title
        
        newsPosterImage.sd_setImage(with: imageUrl)
        
    }
    
    // MARK UP OVERRIDENS

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(newsPosterImage)
        contentView.addSubview(titleLabel)
        contentView.addSubview(bookmarkButton)
        
        applyConstraints()
    }
    
    required init(coder: NSCoder) {
        fatalError()
    }

}
