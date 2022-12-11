//
//  TopNewsViewController.swift
//  NewsPapier
//
//  Created by Abdurrahman Gazi Yavuz on 12/10/22.
//

import UIKit

//protocol TopNewsViewControllerDelegate: AnyObject {
//
//    func navigateToDetailViewController()
//
//}

class NewsViewController: UIViewController {
    
//    weak var delegate: TopNewsViewControllerDelegate?
    private let childViewController = NewsDetailViewController()
    
    private lazy var newsTable: UITableView  = {
        
        let table                       = UITableView()
        table.register(TopNewsTableViewCell.self, forCellReuseIdentifier: TopNewsTableViewCell.identifier)
        table.frame = view.bounds
        return table
        
    }()
    
    func navigateToDetailViewController(){
        
        navigationController?.pushViewController(childViewController, animated: true)
        
    }
    
    func setViewController(with category: Category){
        switch category {
            
        case .categories:
            break
        case .sources:
            break
        case .business:
            title = "Business"
            break
        case .entertainment:
            title = "Entertainment"
            break
        case .general:
            title = "General"
            break
        case .health:
            title = "Health"
            break
        case .science:
            title = "Science"
            break
        case .sports:
            title = "Sports"
            break
        case .technology:
            title = "Technology"
            break
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(newsTable)

        newsTable.delegate              = self
        newsTable.dataSource            = self
        
    }

}


extension NewsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 25
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell  = tableView.dequeueReusableCell(withIdentifier: TopNewsTableViewCell.identifier, for: indexPath) as? TopNewsTableViewCell else {return UITableViewCell()}
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 118
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        self.navigateToDetailViewController()
        
    }
    
}
