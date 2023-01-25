//
//  FinanceNavTitleView.swift
//  NewsPapier
//
//  Created by Abdurrahman Gazi Yavuz on 1/24/23.
//

import UIKit

protocol TestDel: AnyObject{
    
    func sortBySizeHighToLow()
    func sortBySizeLowToHigh()
    
    func sortByPriceHighToLow()
    func sortByPriceLowToHigh()
    
    func sortByChangeHighToLow()
    func sortByChangeLowToHigh()
    
}

enum SortByWhat{
    case size
    case price
    case change
}

public struct ButtonTitle{
    
    static let size: String = "Market Cap  "
    static let price: String = "Price $  "
    static let change: String = "24h %  "
    
}

public struct ButtonImage{
    
    static let high: UIImage = UIImage(systemName: "chevron.down")!
    static let low: UIImage = UIImage(systemName: "chevron.up")!
    
}

final class FinanceNavTitleView: UIView{
    
    var delegate: TestDel?
    
    private var sortBySizeHighToLow: Bool = true
    private var sortByPriceHighToLow: Bool = true
    private var sortByChangeHighToLow: Bool = true
    
    private var currentSortState: SortByWhat = .size
    private var sortByWhat: SortByWhat = .size {
        didSet{
            changeButtonUI(sortByWhat)
        }
    }
    
    private func changeButtonUI(_ sortByWhat: SortByWhat){
        
            switch sortByWhat{
            case .size:
                
                sortBySizeButton.tintColor = .systemOrange
                sortByPriceButton.tintColor = Theme.secondaryText
                sortByChangeButton.tintColor = Theme.secondaryText
                
            case .price:
                
                sortBySizeButton.tintColor = Theme.secondaryText
                sortByPriceButton.tintColor = .systemOrange
                sortByChangeButton.tintColor = Theme.secondaryText
                
            case .change:
                
                sortBySizeButton.tintColor = Theme.secondaryText
                sortByPriceButton.tintColor = Theme.secondaryText
                sortByChangeButton.tintColor = .systemOrange
                
            }
    }
    
    private lazy var sortBySizeButton: UIButton = {
        
        let action = UIAction { _ in
            
            self.sortByWhat = .size
            
            if self.currentSortState == .size{
                
                self.sortBySizeHighToLow.toggle()

            }
            
            if let delegate = self.delegate{
                
                if self.sortBySizeHighToLow
                {
                    self.sortBySizeButton.setImage(ButtonImage.high, for: .normal)
                    delegate.sortBySizeHighToLow()
                }else
                {
                    self.sortBySizeButton.setImage(ButtonImage.low, for: .normal)
                    delegate.sortBySizeLowToHigh()
                }
                
            }
            
            self.currentSortState = self.sortByWhat
        }
        
        let button = UIButton(type: .custom, primaryAction: action)
        
        button.setTitle(ButtonTitle.size, for: .normal)
        button.setImage(ButtonImage.high, for: .normal)
        button.tintColor = .systemOrange
        button.semanticContentAttribute = .forceRightToLeft
        button.adjustsImageWhenHighlighted = false
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    private lazy var sortByPriceButton: UIButton = {
        
        let action = UIAction { _ in
            
            self.sortByWhat = .price
            
            if self.currentSortState == .price{
                
                self.sortByPriceHighToLow.toggle()

            }
            
            if let delegate = self.delegate{
                
                if self.sortByPriceHighToLow
                {
                    self.sortByPriceButton.setImage(ButtonImage.high, for: .normal)
                    delegate.sortByPriceHighToLow()
                }else
                {
                    self.sortByPriceButton.setImage(ButtonImage.low, for: .normal)
                    delegate.sortByPriceLowToHigh()
                }
                
            }
            
            self.currentSortState = self.sortByWhat
        }
        
        let button = UIButton(type: .custom, primaryAction: action)
        
        button.setTitle(ButtonTitle.price, for: .normal)
        button.setImage(ButtonImage.high, for: .normal)
        button.tintColor = Theme.secondaryText
        button.semanticContentAttribute = .forceRightToLeft
        button.adjustsImageWhenHighlighted = false
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    private lazy var sortByChangeButton: UIButton = {
        
        let action = UIAction { _ in
            
            self.sortByWhat = .change
            
            if self.currentSortState == .change{
                
                self.sortByChangeHighToLow.toggle()

            }
            
            if let delegate = self.delegate{
                
                if self.sortByChangeHighToLow
                {
                    self.sortByChangeButton.setImage(ButtonImage.high, for: .normal)
                    delegate.sortByChangeHighToLow()
                }else
                {
                    self.sortByChangeButton.setImage(ButtonImage.low, for: .normal)
                    delegate.sortByChangeLowToHigh()
                }
                
            }
            
            self.currentSortState = self.sortByWhat
        }
        
        let button = UIButton(type: .custom, primaryAction: action)
        
        button.setTitle(ButtonTitle.change, for: .normal)
        button.setImage(ButtonImage.high, for: .normal)
        button.tintColor = Theme.secondaryText
        button.semanticContentAttribute = .forceRightToLeft
        button.adjustsImageWhenHighlighted = false
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
        
    }()
    
    private lazy var stack = HStackView([sortBySizeButton, sortByPriceButton, sortByChangeButton],
                                        autoLayout: false,
                                        alignment: .center,
                                        distribution: .fillEqually)

    func frameChildren(){
        
        stack.anchor(top: topAnchor,
                     leading: leadingAnchor,
                     bottom: bottomAnchor,
                     trailing: trailingAnchor)
        
    }
    
    override init(frame: CGRect){
        
        super.init(frame: frame)
        
        addSubview(stack)
        
        self.backgroundColor = Theme.primaryBackground
        
        self.translatesAutoresizingMaskIntoConstraints = false
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
