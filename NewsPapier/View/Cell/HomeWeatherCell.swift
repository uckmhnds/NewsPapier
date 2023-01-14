//
//  DiscoverCategorySectionsCell.swift
//  NewsPapier
//
//  Created by Abdurrahman Gazi Yavuz on 12/11/22.
//

import UIKit

class HomeWeatherCell: UICollectionViewCell {
    
    static let identifier   = "HomeWeatherCell"
    
    private lazy var categoryImageView: UIImageView = {
        
        let imageView = UIImageView()
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .systemGray6
        imageView.layer.cornerRadius = Preferences.discoverMainCornerRadius
        return imageView
        
    }()
    
    private lazy var categoryTitleLabel: UILabel = {
        
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text                                      = "Category"
        return label
        
    }()
    
    func setCategoryName(with title: String){
        categoryTitleLabel.text = title
    }
    
    private func applyConstraints(){
        
        let categoryImageViewConstraints = [
            categoryImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Preferences.discoverMainPadding),
            categoryImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Preferences.discoverMainPadding),
            categoryImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Preferences.discoverMainPadding)
        ]
        
        let categoryTitleLabelConstraints = [
            categoryTitleLabel.topAnchor.constraint(equalTo: categoryImageView.bottomAnchor, constant: Preferences.discoverMainPadding),
            categoryTitleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Preferences.discoverMainPadding),
            categoryTitleLabel.centerXAnchor.constraint(equalTo: categoryImageView.centerXAnchor)
        ]
            
        NSLayoutConstraint.activate(categoryImageViewConstraints)
        NSLayoutConstraint.activate(categoryTitleLabelConstraints)
        
    }
    
    private func setColors(){
        backgroundColor = Theme.secondaryBackground
        categoryTitleLabel.font = Theme.h0Title
        categoryTitleLabel.textColor = Theme.secondaryText
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(categoryImageView)
        contentView.addSubview(categoryTitleLabel)
        
        applyConstraints()
        setColors()
        
        let test = BezierView(frame: categoryImageView.bounds)
        test.dataSource = self

        categoryImageView.addSubview(test)
        test.drawBezierCurve()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    func pts(_ x: Double) -> CGPoint {
        return CGPoint(x: x, y: -2.5 * x + 80)
    }
    
}

extension HomeWeatherCell: BezierViewDataSource{
    
    var bezierViewDataPoints: [CGPoint] {
        
        var _pts: [CGPoint] = [CGPoint]()
        
        for x in 1...20{
            
            _pts.append(self.pts(Double(x)))
            
        }
        
        return _pts
        
    }
    
}
