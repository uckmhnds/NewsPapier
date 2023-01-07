//
//  SearchResultsViewController+Protocol.swift
//  NewsPapier
//
//  Created by Abdurrahman Gazi Yavuz on 1/7/23.
//

import Foundation

protocol SearchResultsViewControllerDelegate: AnyObject{
    
    func searchResultsViewControllerDidTapCell(_ news: News)
    
}
