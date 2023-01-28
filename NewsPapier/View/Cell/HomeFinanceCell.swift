//
//  DiscoverSourcesCell.swift
//  NewsPapier
//
//  Created by Abdurrahman Gazi Yavuz on 12/11/22.
//

import UIKit

class HomeFinanceCell: UICollectionViewCell {
    
    static let identifier   = "HomeFinanceCell"
    
    private let symbolName = UILabel(autoLayout: false,
                                     font: Theme.h3Title,
                                     color: Theme.secondaryText,
                                     text: "",
                                     textAlignment: .center)
    
    private let changeLabel = UILabel(autoLayout: false,
                                      font: Theme.body3,
                                      text: "",
                                      textAlignment: .center)
    
    private let priceLabel = UILabel(autoLayout: false,
                                     font: Theme.body3,
                                     text: "",
                                     textAlignment: .center)
    
    private lazy var subStackView = VStackView([self.changeLabel, self.priceLabel],
                                            autoLayout: false,
                                            alignment: .center,
                                            distribution: .equalCentering,
                                            spacing: Spacing.s1)
    
    private lazy var stackView = HStackView([self.symbolName, self.changeLabel],
                                            autoLayout: false,
                                            alignment: .center,
                                            distribution: .equalCentering,
                                            spacing: Spacing.s1)
    
    private func applyConstraints(){
        
        stackView.anchor(top: topAnchor,
                         leading: leadingAnchor,
                         bottom: bottomAnchor,
                         trailing: trailingAnchor,
                         padding: UIEdgeInsets(top: Padding.p1,
                                               left: Padding.p1,
                                               bottom: Padding.p1,
                                               right: Padding.p1))
        
    }
    
    func setFinance(_ finance: Finance){
        
        symbolName.text = finance.symbol
        priceLabel.text = finance.price
        changeLabel.text = finance.change
        changeLabel.textColor = finance.increased ? .systemGreen : .systemRed
        
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.backgroundColor     = Theme.tertiaryBackground
        contentView.layer.cornerRadius  = Preferences.discoverSourcesCornerRadius
        contentView.addSubview(stackView)
        
        applyConstraints()
        
    }

}
