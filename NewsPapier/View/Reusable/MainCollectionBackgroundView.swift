//
//  Background.swift
//  NewsPapier
//
//  Created by Abdurrahman Gazi Yavuz on 12/12/22.
//

import UIKit

class MainCollectionBackgroundView: UICollectionReusableView {
    
    static let reuseIdentifier = "RoundedBackgroundView"
    
    private var insetView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
//        view.backgroundColor = .secondarySystemFill
        view.layer.cornerRadius = Preferences.backgroundCornerRadius
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
            insetView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Preferences.backgroundHorizontalPadding),
            insetView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Preferences.backgroundHorizontalPadding),
            insetView.topAnchor.constraint(equalTo: topAnchor, constant: Preferences.backgroundVerticalPadding),
            insetView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Preferences.backgroundVerticalPadding)
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
