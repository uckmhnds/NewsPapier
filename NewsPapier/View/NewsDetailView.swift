//
//  NewsDetailView.swift
//  NewsPapier
//
//  Created by Abdurrahman Gazi Yavuz on 1/7/23.
//

import UIKit
import SDWebImage

final class NewsDetailView: UIView{
    
    private let newsImage: UIImageView = UIImageView(contentMode: .scaleAspectFit,
                                                     autoLayout: false,
                                                     clipsToBounds: true)
    
    private let authorImage: UIImageView = UIImageView(image: UIImage(systemName: "person.circle"),
                                                       contentMode: .scaleAspectFill,
                                                       autoLayout: false,
                                                       clipsToBounds: true,
                                                       tintColor: Theme.primaryText)
    
    private let authorName: UILabel = UILabel(autoLayout: false,
                                              font: Theme.h0Title,
                                              color: Theme.primaryText)
    
    private let newsDate: UILabel = UILabel(autoLayout: false,
                                            font: Theme.body3,
                                            color: Theme.secondaryText)
    
    private let newsTitle: UILabel = UILabel(autoLayout: false,
                                             font: Theme.h3Title,
                                             color: Theme.primaryText,
                                             lineBreakMode: .byWordWrapping,
                                             numberOfLines: 0)
    
    private let newsDescription: UILabel = UILabel(autoLayout: false,
                                                   font: Theme.body2,
                                                   color: Theme.secondaryText,
                                                   lineBreakMode: .byWordWrapping,
                                                   numberOfLines: 0)
    
    private let newsContent: UILabel = UILabel(autoLayout: false,
                                               font: Theme.body3,
                                               color: Theme.tertiaryText,
                                               lineBreakMode: .byWordWrapping,
                                               numberOfLines: 0)
    
    private let sourceName: UILabel = UILabel(autoLayout: false,
                                               font: Theme.body3,
                                               color: Theme.tertiaryText)
    
    private func applyConstraints(){
        
        let newsImageConstraint = [
            newsImage.topAnchor.constraint(equalTo: topAnchor, constant: 90),
            newsImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            newsImage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            newsImage.heightAnchor.constraint(equalToConstant: 300)
        ]
        
        let authorImageConstraint   = [
            authorImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            authorImage.topAnchor.constraint(equalTo: newsImage.bottomAnchor, constant: 20)
        ]
        
        let authorNameConstraint    = [
            authorName.leadingAnchor.constraint(equalTo: authorImage.trailingAnchor, constant: 10),
            authorName.centerYAnchor.constraint(equalTo: authorImage.centerYAnchor)
        ]
        
        let newsDateConstraint  = [
            newsDate.topAnchor.constraint(equalTo: newsImage.bottomAnchor, constant: 20),
            newsDate.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10)
        ]
        
        let newsTitleConstraint = [
            newsTitle.topAnchor.constraint(equalTo: newsDate.bottomAnchor, constant: 20),
            newsTitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            newsTitle.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10)
        ]
        
        let newsDescriptionConstraint   = [
            newsDescription.topAnchor.constraint(equalTo: newsTitle.bottomAnchor, constant: 10),
            newsDescription.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            newsDescription.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10)
        ]
        
        let newsContentConstraint       = [
            newsContent.topAnchor.constraint(equalTo: newsDescription.bottomAnchor, constant: 10),
            newsContent.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            newsContent.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10)
        ]
        
        let sourceNameConstraint    = [
            sourceName.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            sourceName.topAnchor.constraint(equalTo: newsContent.bottomAnchor, constant: 20)
        ]
        
        NSLayoutConstraint.activate(newsImageConstraint)
        NSLayoutConstraint.activate(authorImageConstraint)
        NSLayoutConstraint.activate(authorNameConstraint)
        NSLayoutConstraint.activate(newsDateConstraint)
        NSLayoutConstraint.activate(newsTitleConstraint)
        NSLayoutConstraint.activate(newsDescriptionConstraint)
        NSLayoutConstraint.activate(newsContentConstraint)
        NSLayoutConstraint.activate(sourceNameConstraint)
        
    }
    
    func configure(with news: News){
        
        newsDate.text           = news.timeAgoView
        newsTitle.text          = news.title
        newsDescription.text    = news.description
        newsContent.text        = news.content
        authorName.text         = news.author ?? ""
        sourceName.text         = news.source.name
        
        guard let imageUrl      = URL(string: news.urlToImage ?? "") else {return}
        
        newsImage.sd_setImage(with: imageUrl)
    }
    
    override init(frame: CGRect){
        
        super.init(frame: frame)
        
        backgroundColor = Theme.primaryBackground
        
        addSubview(newsImage)
        addSubview(authorImage)
        addSubview(authorName)
        addSubview(sourceName)
        addSubview(newsDate)
        addSubview(newsTitle)
        addSubview(newsDescription)
        addSubview(newsContent)
        
        applyConstraints()
        
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
