//
//  DiscoverNavigationController.swift
//  NewsPapier
//
//  Created by Abdurrahman Gazi Yavuz on 12/11/22.
//

import UIKit

class RootNavigationController: UINavigationController {

    private let rootViewController = MainViewController()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        pushViewController(rootViewController, animated: true)
    }

}
