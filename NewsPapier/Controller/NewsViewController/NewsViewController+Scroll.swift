//
//  MainViewController+Scroll.swift
//  NewsPapier
//
//  Created by Abdurrahman Gazi Yavuz on 12/29/22.
//

import UIKit

extension NewsViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        var pagination      = false
        let scrollOffset    = scrollView.contentOffset.y
        let tableOffset     = newsTable.contentSize.height
        
        if tableOffset != 0 && scrollOffset > tableOffset - scrollView.frame.size.height - 50
        {
            pagination       = true
        }else
        {
            pagination       = false
        }
        
        if pagination
        {
            
            print("Pagination")
            
        }
        
    }
    
}
