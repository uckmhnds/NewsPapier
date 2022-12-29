//
//  Header.swift
//  NewsPapier
//
//  Created by Abdurrahman Gazi Yavuz on 12/12/22.
//

import UIKit

protocol HeaderDelegate: AnyObject{
    func headerDidTap(_ category: Category)
}

class Header: UICollectionReusableView {

    static let identifier       = "Header"
    var category: Category?
    weak var delegate: HeaderDelegate?
    
    private let titleLeadingPadding: CGFloat = 13
    private let imageViewTrailingPadding: CGFloat = 13

    private lazy var label: UILabel  = {

        let label   = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false

        return label

    }()
    
    private lazy var imageView: UIImageView = {
        
        let image = UIImage(systemName: "chevron.right")
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.tintColor = .white
        return imageView
        
    }()
    
    func setHeaderLabel(with sectionName: String){
        self.label.text = sectionName
    }
    
    private func applyConstraints(){
        
        let labelConstraints = [
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: titleLeadingPadding),
            label.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 5)
        ]
        
        let imageViewConstraints = [
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -imageViewTrailingPadding),
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ]
        
        NSLayoutConstraint.activate(labelConstraints)
        NSLayoutConstraint.activate(imageViewConstraints)
    }
    
    @objc private func headerDidTap(_ sender: UITapGestureRecognizer){
        delegate?.headerDidTap(category!)
    }
    
    private lazy var tapGesture: UITapGestureRecognizer = {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(headerDidTap(_:)))
        
        return gesture
    }()
    
    private func setColors(){
        backgroundColor = .clear
        
        label.textColor = Theme.primaryText
        label.font = Theme.h1Title
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(label)
        addSubview(imageView)
        
        addGestureRecognizer(tapGesture)
        
        setColors()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
        applyConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
