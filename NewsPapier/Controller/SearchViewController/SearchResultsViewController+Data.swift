//
//  SearchResultsViewController+Data.swift
//  NewsPapier
//
//  Created by Abdurrahman Gazi Yavuz on 1/7/23.
//

import UIKit

extension SearchResultsViewController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return news.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell  = tableView.dequeueReusableCell(withIdentifier: NewsTableViewCell.identifier, for: indexPath) as? NewsTableViewCell else {return UITableViewCell()}
        let news = news[indexPath.row]
        cell.configure(with: news)
//        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        #warning("Parametrize")
        return 118
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let news = news[indexPath.row]
        print("didSelectRowAt")
//        childViewController.configure(with: news)
//        navigationController?.pushViewController(childViewController, animated: true)
        navigateToDetailViewController(news)
        
    }
    
}
