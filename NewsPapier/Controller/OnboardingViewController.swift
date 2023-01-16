//
//  OnboardingViewController.swift
//  NewsPapier
//
//  Created by Abdurrahman Gazi Yavuz on 1/16/23.
//

import UIKit

class OnboardingViewController: UIViewController {
    
    lazy var button: UIButton = {
        
        let action = UIAction { _ in
            
            UserPreferences.defaults.set(true, forKey: "Test")
            
        }
        
        let button = UIButton(primaryAction: action)
//        let button = UIButton(primaryAction: action)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .red
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemGray
        
        view.addSubview(button)
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        button.anchor(height: 80, width: 200, centerX: view.centerXAnchor, centerY: view.centerYAnchor)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
