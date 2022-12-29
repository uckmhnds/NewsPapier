//
//  Background.swift
//  NewsPapier
//
//  Created by Abdurrahman Gazi Yavuz on 12/12/22.
//

import UIKit

class RoundedBackgroundView: UICollectionReusableView {
    
    static let reuseIdentifier = "RoundedBackgroundView"
    
    private var insetView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
//        view.backgroundColor = .secondarySystemFill
        view.layer.cornerRadius = 0
        view.clipsToBounds = true
        return view
    }()
    
    private func setColors(){
        insetView.backgroundColor = Theme.secondaryBackground
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        addSubview(insetView)

        NSLayoutConstraint.activate([
            insetView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            insetView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            insetView.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            insetView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5)
        ])
        
        setColors()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
}
