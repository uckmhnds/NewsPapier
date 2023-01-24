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
    case change
    case size
}

final class FinanceNavTitleView: UIView{
    
    let sortBarImage          = UIImage(systemName: "gearshape")
    
    private var sortByChangeHighToLow: Bool = true
    private var sortBySizeHighToLow: Bool = true
    
    var delegate: TestDel?
    
    private lazy var sortBySizeButton: UIButton = {
        
        let action = UIAction { _ in
            
            if let delegate = self.delegate{
                
                if self.sortByChangeHighToLow
                {
                    delegate.sortBySizeHighToLow()
                }else
                {
                    delegate.sortBySizeLowToHigh()
                }
                
            }
            
            self.sortByChangeHighToLow.toggle()
            
            print("blue pill")
        }
        
        let button = UIButton(primaryAction: action)
        
//        button.configurationUpdateHandler = {
//
//            [unowned self] button in
//
////            var config              = testType == Test.type1 ? UIButton.Configuration.filled() : UIButton.Configuration.gray()
//            var config              = UIButton.Configuration.filled()
//            config.title            = "subbutton1"
//            button.configuration    = config
//        }
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .purple
        
        return button
    }()
    
    private lazy var sortByChangeButton: UIButton = {
        
        let action = UIAction { _ in
            
            if let delegate = self.delegate{
                
                if self.sortByChangeHighToLow
                {
                    delegate.sortByChangeHighToLow()
                }else
                {
                    delegate.sortByChangeLowToHigh()
                }
                
            }
            
            self.sortByChangeHighToLow.toggle()
            
            print("red pill")
        }
        
        let button = UIButton(primaryAction: action)
        
//        button.configurationUpdateHandler = {
//
//            [unowned self] button in
//
////            var config              = testType == Test.type1 ? UIButton.Configuration.filled() : UIButton.Configuration.gray()
//            var config              = UIButton.Configuration.filled()
//            config.title            = "subbutton1"
//            button.configuration    = config
//        }
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .red
        
        return button
    }()
    
    private lazy var sortByPriceButton: UIButton = {
        
        let action = UIAction { _ in
            
            if let delegate = self.delegate{
                
                if self.sortByChangeHighToLow
                {
                    delegate.sortByPriceHighToLow()
                }else
                {
                    delegate.sortByPriceLowToHigh()
                }
                
            }
            
            self.sortByChangeHighToLow.toggle()
            
            print("blue pill")
        }
        
        let button = UIButton(primaryAction: action)
        
//        button.configurationUpdateHandler = {
//
//            [unowned self] button in
//
////            var config              = testType == Test.type1 ? UIButton.Configuration.filled() : UIButton.Configuration.gray()
//            var config              = UIButton.Configuration.filled()
//            config.title            = "subbutton1"
//            button.configuration    = config
//        }
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .blue
        
        return button
    }()
    
    lazy var stack = HStackView([sortBySizeButton, sortByPriceButton, sortByChangeButton], autoLayout: false, alignment: .center, distribution: .fillEqually)

    func frameChildren(){
        stack.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor)
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
