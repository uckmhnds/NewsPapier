//
//  SideMenuViewController.swift
//  NewsPapier
//
//  Created by Abdurrahman Gazi Yavuz on 12/14/22.
//

import UIKit

class SideMenuViewController: UIViewController {
    
    private lazy var sideMenuWidth: CGFloat = view.frame.width * 0.4

    
    private lazy var tableView: UITableView = {
        #warning("Parametric frame set")
        let frame = CGRect(x: 0, y: 120, width: sideMenuWidth, height: 500)
        let tableView = UITableView(frame: frame, style: .plain)
        
        tableView.register(SideMenuMainCell.self, forCellReuseIdentifier: SideMenuMainCell.identifier)
        tableView.register(SideMenuChildCell.self, forCellReuseIdentifier: SideMenuChildCell.identifier)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        return tableView
    }()
    
    private func applyConstraints(){
        let tableViewConstraints = [
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
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
        
        
//        applyConstraints()
    }

}


extension SideMenuViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        SideMenuCategories.categoryNames.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(
                withIdentifier: "CustomTableViewCell") as? CustomTableViewCell
        else { return UITableViewCell() }
        cell.setUI(with: indexPath.row)
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        UIView.animate(withDuration: 0.3) {
            self.tableView.performBatchUpdates(nil)
        }
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if let cell = self.tableView.cellForRow(at: indexPath) as? CustomTableViewCell {
            cell.hideDetailView()
        }
    }
    
}
