//
//  WeatherDetailViewController.swift
//  NewsPapier
//
//  Created by Abdurrahman Gazi Yavuz on 1/19/23.
//

import UIKit

class WeatherDetailViewController: UIViewController {
    
    private lazy var locationTitle = UILabel(autoLayout: false,
                                          font: Theme.h1Title,
                                          color: Theme.primaryText,
                                          text: "Dallas",
                                          textAlignment: .center)
    
    private lazy var temperatureTitle = UILabel(autoLayout: false,
                                          font: Theme.h0Title,
                                          color: Theme.primaryText,
                                          text: "31\u{00B0}C",
                                          textAlignment: .center)
    
    private lazy var stack = VStackView([locationTitle, temperatureTitle], autoLayout: false, alignment: .center, distribution: .fillProportionally, spacing: Spacing.s1)
    
    private func applyConstraints(){
        
        stack.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                     leading: view.leadingAnchor,
                     bottom: view.bottomAnchor,
                     trailing: view.trailingAnchor,
                     padding: UIEdgeInsets(top: Inset.zero,
                                           left: Inset.zero,
                                           bottom: Inset.i8,
                                           right: Inset.zero))
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        view.addSubview(stack)
        
        applyConstraints()
    }
    
}
