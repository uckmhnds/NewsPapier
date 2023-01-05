//
//  TopNewsTableViewCell.swift
//  NewsPapier
//
//  Created by Abdurrahman Gazi Yavuz on 12/10/22.
//

import UIKit

protocol NewsTableViewCellDelegate: AnyObject{
    
    func didTapThreeDots(_ sender: UITapGestureRecognizer)
    
    func didTapNewsCell(_ sender: UITapGestureRecognizer)
}

class NewsTableViewCell: UITableViewCell {
    #warning("a main view and subview to have 2 different tapgestures, which not conflicts")
    static let identifier = "TopNewsTableViewCell"
    
    weak var delegate: NewsTableViewCellDelegate?
    
    private lazy var newsPosterImage: UIImageView = UIImageView(contentMode: .scaleAspectFill,
                                                     autoLayout: false,
                                                     clipsToBounds: true,
                                                     cornerRadius: Preferences.topNewsCellPadding)
    
    private lazy var titleLabel: UILabel = UILabel(autoLayout: false,
                                                   font: Theme.h3Accent,
                                                   color: Theme.primaryText,
                                                   text: "",
                                                   lineBreakMode: .byWordWrapping,
                                                   numberOfLines: 0)
    
    private lazy var timeLabel: UILabel = UILabel(autoLayout: false,
                                                   font: Theme.h3Accent,
                                                   color: Theme.tertiaryText)
    
    private lazy var threeDots: UIImageView = UIImageView(image: UIImage(systemName: "ellipsis"),
                                                          autoLayout: false,
                                                          tintColor: Theme.primaryText,
                                                          backgroundColor: .red,
                                                          gesture: tapThreeDot)
    
    private lazy var tapMainView = UITapGestureRecognizer(target: self,
                                                          action: #selector(didTapNewsCell(_:)),
                                                          delegate: self,
                                                          name: "tapMainView")
    
    private lazy var tapThreeDot = UITapGestureRecognizer(target: self,
                                                          action: #selector(didTapThreeDots(_:)),
                                                          delegate: self,
                                                          name: "tapThreeDot")
    
    @objc private func didTapThreeDots(_ sender: UITapGestureRecognizer){
        print("didTap")
        self.delegate?.didTapThreeDots(sender)
    }
    
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
            threeDots.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Preferences.topNewsCellPadding),
            threeDots.heightAnchor.constraint(equalToConstant: 30)
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
        timeLabel.text          = model.timeView
        newsPosterImage.sd_setImage(with: imageUrl)
        
    }
    
    private func setColors(){
        backgroundColor = .clear
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        print("didInit")
        
        contentView.addSubview(newsPosterImage)
        contentView.addSubview(titleLabel)
        contentView.addSubview(timeLabel)
        contentView.addSubview(threeDots)
        
        addGestureRecognizer(tapMainView)
        
        applyConstraints()
        setColors()
    }
    
    @objc func didTapNewsCell(_ sender: UITapGestureRecognizer){
        print("test activated")
        self.delegate?.didTapNewsCell(sender)
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
    
    override func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if !self.threeDots.bounds.contains(touch.location(in: self.threeDots)){
            
            print("sdasdas")
            
        }
        return true
    }
    
    override func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer,
             shouldRequireFailureOf otherGestureRecognizer: UIGestureRecognizer) -> Bool {
       if gestureRecognizer == self.tapThreeDot &&
              otherGestureRecognizer == self.tapMainView {
          return true
       }
       return false
    }
    

}
