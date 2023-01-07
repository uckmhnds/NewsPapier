//
//  SideMenuViewController.swift
//  NewsPapier
//
//  Created by Abdurrahman Gazi Yavuz on 12/14/22.
//

import UIKit

class SideMenuViewController: UIViewController {
    
    private lazy var sideMenuWidth: CGFloat = view.frame.width * 0.4
    
    var isCollapsedArray: [Bool] = []
    
    private lazy var tableView: UITableView = {
        #warning("Parametric frame set")
//        let frame = CGRect(x: 0, y: 120, width: sideMenuWidth, height: 500)
//        let frame = .zero
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(ExpColCell.self, forCellReuseIdentifier: ExpColCell.identifier)
//        tableView.register(SideMenuChildCell.self, forCellReuseIdentifier: SideMenuChildCell.identifier)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        return tableView
    }()
    
    private func applyConstraints(){
        let tableViewConstraints = [
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 200),
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
        view.backgroundColor = .black
        
        view.addSubview(tableView)
        
        
        // 16 "rows" start with every-other row collapsed
        for i in 0..<15 {
            isCollapsedArray.append(i % 2 == 0)
        }
        
        applyConstraints()
    }

}
