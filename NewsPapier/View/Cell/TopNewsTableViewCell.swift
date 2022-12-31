//
//  TopNewsTableViewCell.swift
//  NewsPapier
//
//  Created by Abdurrahman Gazi Yavuz on 12/10/22.
//

import UIKit

class TopNewsTableViewCell: UITableViewCell {
    
    static let identifier = "TopNewsTableViewCell"
    
    private lazy var newsPosterImage: UIImageView = {
        
        let image           = UIImageView()
        
        image.contentMode   = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        image.clipsToBounds = true
//        image.backgroundColor = .red
        image.layer.cornerRadius = Preferences.topNewsCellPadding
        
        return image
        
    }()
    
    private lazy var titleLabel: UILabel = {
        
        let label   = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.lineBreakMode                             = .byWordWrapping
        label.numberOfLines                             = 0
        label.textColor                                 = .white
        label.text = "You should know how to make web requests in your chosen programming language."
    
        return label
    }()
    
    
    private lazy var timeLabel: UILabel = {
        #warning("fix fontsize")
        let label   = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor                                 = .systemGray
        label.text                                      = "3 hours"
        return label
    }()
    
    @objc private func didTapThreeDots(_ sender: UITapGestureRecognizer){
        print("didTap")
    }
    
    private lazy var threeDots: UIImageView = {
        
        let image = UIImage(systemName: "ellipsis")
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.tintColor = .white
        let gesture = UITapGestureRecognizer(target: self, action: #selector(didTapThreeDots(_:)))
        return imageView
        
    }()
    
    // CONSTRAINT VIEWS
    
    private func applyConstraints(){
        
        let newsPosterImageConstraint   = [
            newsPosterImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Preferences.topNewsCellPadding),
            newsPosterImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Preferences.topNewsCellPadding),
            newsPosterImage.widthAnchor.constraint(equalToConstant: Preferences.topNewsImageSize),
            newsPosterImage.heightAnchor.constraint(equalToConstant: Preferences.topNewsImageSize)
        ]
        
        let titleLabelConstraints       = [
            titleLabel.leadingAnchor.constraint(equalTo: newsPosterImage.trailingAnchor, constant: Preferences.topNewsCellPadding),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Preferences.topNewsCellPadding),
            titleLabel.centerYAnchor.constraint(equalTo: newsPosterImage.centerYAnchor)
        ]
        
        let timeLabelConstraints        = [
            timeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Preferences.topNewsCellPadding),
            timeLabel.topAnchor.constraint(equalTo: newsPosterImage.bottomAnchor, constant: Preferences.topNewsCellPadding),
            timeLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Preferences.topNewsCellPadding)
        ]
        
        let threeDotsConstraints        = [
            threeDots.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Preferences.topNewsCellPadding),
            threeDots.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Preferences.topNewsCellPadding)
        ]
        
        NSLayoutConstraint.activate(newsPosterImageConstraint)
        NSLayoutConstraint.activate(titleLabelConstraints)
        NSLayoutConstraint.activate(timeLabelConstraints)
        NSLayoutConstraint.activate(threeDotsConstraints)
        
    }
    
    // CONFIGURE CONTENT
    
    func configure(with model: News){
        
        guard let imageUrl      = URL(string: model.urlToImage ?? "") else {return}
        
        titleLabel.text         = model.title
        
        newsPosterImage.sd_setImage(with: imageUrl)
        
    }
    
    private func setColors(){
        backgroundColor = .clear
    }
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(newsPosterImage)
        contentView.addSubview(titleLabel)
        contentView.addSubview(timeLabel)
        contentView.addSubview(threeDots)
        
        applyConstraints()
        setColors()
        
    }
    
    required init(coder: NSCoder) {
        fatalError()
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
