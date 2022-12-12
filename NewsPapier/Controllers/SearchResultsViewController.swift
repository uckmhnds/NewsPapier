//
//  SearchResultsViewController.swift
//  NewsPapier
//
//  Created by Abdurrahman Gazi Yavuz on 6.10.2022.
//

import UIKit

//protocol SearchResultsViewControllerDelegate: AnyObject{
//    
//    func searchResultsViewControllerDidTapCell(_ news: News)
//    
//}

class SearchResultsViewController: UIViewController {
    
    public var news: [News] = [News]()
    
    public weak var delegate: SearchResultsViewControllerDelegate?
    
    public let newsTable: UITableView  = {
        
        let table                       = UITableView()
        table.register(NewsTableViewCell.self, forCellReuseIdentifier: NewsTableViewCell.identifier)
        return table
        
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(newsTable)
        
        newsTable.dataSource    = self
        newsTable.delegate      = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        newsTable.frame     = view.bounds
    }

}


extension SearchResultsViewController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return news.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell  = tableView.dequeueReusableCell(withIdentifier: NewsTableViewCell.identifier, for: indexPath) as? NewsTableViewCell else {return UITableViewCell()}
        
        cell.configure(with: news[indexPath.row])
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 260
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        let selectedNews            = news[indexPath.row]
        
        DispatchQueue.main.async { [weak self] in
            
            self?.delegate?.searchResultsViewControllerDidTapCell(selectedNews)

        }
    }
    
    
}
