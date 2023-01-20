//
//  FinanceTableViewCell.swift
//  NewsPapier
//
//  Created by Abdurrahman Gazi Yavuz on 1/19/23.
//

import UIKit

class FinanceTableViewCell: UITableViewCell{
    
    static let identifier = "FinanceTableViewCell"
    
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
    
    private let lowLabel = UILabel(autoLayout: false,
                                     font: Theme.body4,
                                     text: "",
                                     textAlignment: .center)
    
    private let highLabel = UILabel(autoLayout: false,
                                     font: Theme.body4,
                                     text: "",
                                     textAlignment: .center)
    
    private lazy var subStackView = VStackView([self.lowLabel, self.highLabel],
                                            autoLayout: false,
                                            alignment: .center,
                                            distribution: .equalCentering,
                                            spacing: Spacing.s1)
    
    private lazy var stackView = HStackView([self.symbolName, self.subStackView, self.priceLabel, changeLabel],
                                            autoLayout: false,
                                            alignment: .center,
                                            distribution: .fillEqually,
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
        
    }
    
    func setFinance(_ finance: Finance){
        
        symbolName.text = finance.symbol
        priceLabel.text = finance.price
        lowLabel.text = finance.low
        highLabel.text = finance.high
        changeLabel.text = finance.change
        changeLabel.textColor = finance.increased ? .systemGreen : .systemRed
        
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(stackView)
        
        applyConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
