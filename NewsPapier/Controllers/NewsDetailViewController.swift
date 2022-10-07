//
//  NewsDetailViewController.swift
//  NewsPapier
//
//  Created by Abdurrahman Gazi Yavuz on 3.10.2022.
//

import UIKit
import SDWebImage

class NewsDetailViewController: UIViewController {
    
    private let newsImage: UIImageView  = {
        
        let image = UIImageView()
        
        image.contentMode   = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        image.clipsToBounds = true
        
        return image
    }()
    
    private let authorImage: UIImageView    = {
        
        let image       = UIImageView(image: UIImage(systemName: "person.circle"))
        
        image.contentMode   = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        image.clipsToBounds = true
        image.tintColor     = .white
        
        return image
    }()
    
    private let authorName: UILabel = {
        
        let author  = UILabel()
        
        author.translatesAutoresizingMaskIntoConstraints    = false
        author.textColor                                = .white
        author.font                                     = .systemFont(ofSize: 13, weight: .bold)
        
        return author
        
    }()
    
    private let newsDate: UILabel   = {
        
        let label   = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor                                 = .white
        label.font                                      = .systemFont(ofSize: 12, weight: .bold)
        
        return label
        
    }()
    
    private let newsTitle: UILabel      = {
        
        let label   = UILabel()
        
        label.lineBreakMode                             = .byWordWrapping
        label.numberOfLines                             = 0
        label.textColor                                 = .white
        label.font                                      = .systemFont(ofSize: 18, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
        
    }()
    
    private let newsDescription: UILabel = {
        
        let label   = UILabel()
        
        label.lineBreakMode                             = .byWordWrapping
        label.numberOfLines                             = 0
        label.textColor                                 = .white
        label.font                                      = .systemFont(ofSize: 14, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
        
    }()
    
    private let newsContent: UILabel = {
        
        let label   = UILabel()
        
        label.lineBreakMode                             = .byWordWrapping
        label.numberOfLines                             = 0
        label.textColor                                 = .white
        label.font                                      = .systemFont(ofSize: 12, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
        
    }()
    
    private let sourceName: UILabel = {
        
        let source  = UILabel()
        
        source.translatesAutoresizingMaskIntoConstraints    = false
        source.textColor                                = .systemRed
        source.font                                     = .systemFont(ofSize: 13, weight: .bold)
        
        return source
        
    }()
    
    private func applyConstraints(){
        
        let newsImageConstraint = [
            newsImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 90),
            newsImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            newsImage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            newsImage.heightAnchor.constraint(equalToConstant: 300)
        ]
        
        let authorImageConstraint   = [
            authorImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            authorImage.topAnchor.constraint(equalTo: newsImage.bottomAnchor, constant: 20)
        ]
        
        let authorNameConstraint    = [
            authorName.leadingAnchor.constraint(equalTo: authorImage.trailingAnchor, constant: 10),
            authorName.centerYAnchor.constraint(equalTo: authorImage.centerYAnchor)
        ]
        
        let newsDateConstraint  = [
            newsDate.topAnchor.constraint(equalTo: newsImage.bottomAnchor, constant: 20),
            newsDate.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10)
        ]
        
        let newsTitleConstraint = [
            newsTitle.topAnchor.constraint(equalTo: newsDate.bottomAnchor, constant: 20),
            newsTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            newsTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10)
        ]
        
        let newsDescriptionConstraint   = [
            newsDescription.topAnchor.constraint(equalTo: newsTitle.bottomAnchor, constant: 10),
            newsDescription.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            newsDescription.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10)
        ]
        
        let newsContentConstraint       = [
            newsContent.topAnchor.constraint(equalTo: newsDescription.bottomAnchor, constant: 10),
            newsContent.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            newsContent.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10)
        ]
        
        let sourceNameConstraint    = [
            sourceName.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
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
        
        let timeFormatter       = DateFormatter()
        timeFormatter.dateFormat = "yyyy/MM/dd'T'HH:mm:ss'Z'"
        let time                = timeFormatter.date(from: news.publishedAt ?? "some time")
        
        newsDate.text           = time?.formatted(date: .numeric, time: .omitted)
        newsTitle.text          = news.title
        newsDescription.text    = news.description
        newsContent.text        = news.content
        authorName.text         = news.author ?? ""
        sourceName.text         = news.source.name
        
        guard let imageUrl      = URL(string: news.urlToImage ?? "") else {return}
        
        newsImage.sd_setImage(with: imageUrl)
        
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor    = .systemBackground
        
        view.addSubview(newsImage)
        view.addSubview(authorImage)
        view.addSubview(authorName)
        view.addSubview(sourceName)
        view.addSubview(newsDate)
        view.addSubview(newsTitle)
        view.addSubview(newsDescription)
        view.addSubview(newsContent)
        
        applyConstraints()
        
        navigationController?.navigationBar.tintColor = .white
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


//extension NewsDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 1
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        <#code#>
//    }
//
//
//}
