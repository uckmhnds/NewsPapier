//
//  FinanceTableViewCell.swift
//  NewsPapier
//
//  Created by Abdurrahman Gazi Yavuz on 1/19/23.
//

import UIKit

class FinanceTableViewCell: UITableViewCell{
    
    static let identifier = "FinanceTableViewCell"
    
    private let indexLabel = UILabel(autoLayout: false,
                                     font: Theme.h3Title,
                                     color: Theme.secondaryText,
                                     text: "",
                                     textAlignment: .center)
    
    private let symbolName = UILabel(autoLayout: false,
                                     font: Theme.h3Title,
                                     color: Theme.secondaryText,
                                     text: "",
                                     textAlignment: .left)
    
    private let priceLabel = UILabel(autoLayout: false,
                                     font: Theme.body3,
                                     color: Theme.secondaryText,
                                     text: "",
                                     textAlignment: .center)
    
    private let changeLabel = UILabel(autoLayout: false,
                                      font: Theme.body3,
                                      text: "",
                                      textAlignment: .right)
    
    private lazy var stackView = HStackView([self.indexLabel, self.symbolName, self.priceLabel, self.changeLabel],
                                            autoLayout: false,
                                            alignment: .center,
                                            distribution: .equalCentering,
                                            spacing: Spacing.zero)
    
    private func applyConstraints(){
        
        stackView.anchor(top: topAnchor,
                         leading: leadingAnchor,
                         bottom: bottomAnchor,
                         trailing: trailingAnchor,
                         padding: UIEdgeInsets(top: Padding.p1,
                                               left: Padding.p1,
                                               bottom: Padding.p1,
                                               right: Padding.p1))
        
        indexLabel.anchor(width: bounds.width * Preferences.financeTableCellFraction1)
        symbolName.anchor(width: bounds.width * Preferences.financeTableCellFraction2)
        changeLabel.anchor(width: bounds.width * Preferences.financeTableCellFraction3)
        priceLabel.anchor(width: bounds.width * Preferences.financeTableCellFraction4)
        
    }
    
    func setFinance(_ finance: Finance){
        
        symbolName.text = finance.symbol
        priceLabel.text = finance.price
        changeLabel.text = finance.change
        changeLabel.textColor = finance.increased ? .systemGreen : .systemRed
        indexLabel.text = finance.rank ?? ""
        
    }
    
    func setIndex(_ index: Int){
        indexLabel.text = String(index)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(stackView)
        
        applyConstraints()
        
        backgroundColor = Theme.secondaryBackground
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
