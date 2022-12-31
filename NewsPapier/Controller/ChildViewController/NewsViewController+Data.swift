//
//  NewsViewController+Data.swift
//  NewsPapier
//
//  Created by Abdurrahman Gazi Yavuz on 12/12/22.
//

import UIKit

extension NewsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return news.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell  = tableView.dequeueReusableCell(withIdentifier: TopNewsTableViewCell.identifier, for: indexPath) as? TopNewsTableViewCell else {return UITableViewCell()}
        let news = news[indexPath.row]
        cell.configure(with: news)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 118
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let news = news[indexPath.row]
        childViewController.configure(with: news)
        navigationController?.pushViewController(childViewController, animated: true)
        
    }
    
}
