//
//  NewsViewController+Delegate.swift
//  NewsPapier
//
//  Created by Abdurrahman Gazi Yavuz on 1/3/23.
//

import UIKit


extension NewsViewController: NewsTableViewCellDelegate{
    
    func didTapNewsCell(_ sender: UITapGestureRecognizer) {
        print("didTapNewsCell")
    }
    
    func didTapThreeDots(_ sender: UITapGestureRecognizer) {
        print("didTapThreeDots")
    }
    
}
