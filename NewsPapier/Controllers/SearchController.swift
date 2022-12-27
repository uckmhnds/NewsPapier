//
//  SearchController.swift
//  NewsPapier
//
//  Created by Abdurrahman Gazi Yavuz on 12/27/22.
//

import UIKit

class SearchController: UISearchController {
    
    /// SEARCH BAR CONFIG
    
    private lazy var customSearchBar: UISearchBar = {
        
        let bar = UISearchBar()
        
        bar.placeholder = "Search"
        bar.searchBarStyle = .minimal
        bar.sizeToFit()
        
        return bar
        
    }()
    
    override init(searchResultsController: UIViewController?) {
        super.init(searchResultsController: searchResultsController)
        
        self.searchBar.placeholder    = "Search"
        self.searchBar.searchBarStyle = .minimal
        self.searchBar.sizeToFit()
        
        self.hidesNavigationBarDuringPresentation = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .red
    }

}
