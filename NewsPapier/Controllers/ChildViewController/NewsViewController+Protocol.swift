//
//  NewsViewController+Protocol.swift
//  NewsPapier
//
//  Created by Abdurrahman Gazi Yavuz on 12/12/22.
//

import UIKit

protocol SearchResultsViewControllerDelegate: AnyObject{
    
    func searchResultsViewControllerDidTapCell(_ news: News)
    
}
