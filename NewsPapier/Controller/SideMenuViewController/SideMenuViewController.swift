//
//  SideMenuViewController.swift
//  NewsPapier
//
//  Created by Abdurrahman Gazi Yavuz on 12/14/22.
//

import UIKit

protocol SideMenuViewControllerDelegate: AnyObject{
    func categorySelected(_ categoryCase: CategoryCase)
    func countrySelected(_ countryCase: CountryCase)
}

class SideMenuViewController: UIViewController {
    
    var sections: [any BaseSection] = [CategorySection(), CountrySection()]
    
    weak var delegate: SideMenuViewControllerDelegate?
    
    private lazy var tableView: UITableView = {
        
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.register(SideMenuCategoryCellA.self, forCellReuseIdentifier: SideMenuCategoryCellA.identifier)
        tableView.register(SideMenuRegionCellA.self, forCellReuseIdentifier: SideMenuRegionCellA.identifier)
        
        tableView.register(SideMenuCategoryCellAA.self, forCellReuseIdentifier: SideMenuCategoryCellAA.identifier)
        tableView.register(SideMenuRegionCellAA.self, forCellReuseIdentifier: SideMenuRegionCellAA.identifier)
        
        tableView.backgroundColor = Theme.primaryBackground
        tableView.delegate = self
        tableView.dataSource = self
        
        return tableView
    }()
    
    private func applyConstraints(){
        let tableViewConstraints = [
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 110),
//            tableView.widthAnchor.constraint(equalToConstant: sideMenuWidth),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ]
        
        NSLayoutConstraint.activate(tableViewConstraints)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = Theme.primaryBackground
        
        view.addSubview(tableView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        applyConstraints()
        
    }

}
