//
//  FinanceTableViewHeader.swift
//  NewsPapier
//
//  Created by Abdurrahman Gazi Yavuz on 1/22/23.
//

import UIKit

protocol FinanceTableViewHeaderDelegate: AnyObject {
    func test()
}

class FinanceTableViewHeader: UITableViewHeaderFooterView {
    
    static let identifier = "FinanceTableViewHeader"
    
    weak var delegate: FinanceTableViewHeaderDelegate?
    
    @objc func tapp(){
        if let delegate = self.delegate{
            print("sdasda")
            delegate.test()
        }
    }
    
    private lazy var tap = UITapGestureRecognizer(target: self, action: #selector(tapp))
    
    
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
//        addSubview(sortButton)
        addGestureRecognizer(tap)
//        sortButton.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor)
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
