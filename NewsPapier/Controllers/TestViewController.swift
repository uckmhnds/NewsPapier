//
//  TestViewController.swift
//  NewsPapier
//
//  Created by Abdurrahman Gazi Yavuz on 2.10.2022.
//

import UIKit
import SwiftUI

class TestViewController: UIViewController {
    
    private let swiftUIController   = UIHostingController(rootView: HomeTabHeaderNews())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addChild(swiftUIController)
        swiftUIController.view.frame = view.frame
        
        view.addSubview(swiftUIController.view)
        swiftUIController.didMove(toParent: self)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
    }
    

}
