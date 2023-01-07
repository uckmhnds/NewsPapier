//
//  SearchController.swift
//  NewsPapier
//
//  Created by Abdurrahman Gazi Yavuz on 12/27/22.
//

import UIKit

class SearchController: UISearchController, UISearchControllerDelegate {
    
    /// SEARCH BAR CONFIG
    ///
    weak var searchResultsControllerDelegate: AnyObject?
    
    private lazy var customSearchBar: UISearchBar = {
        
        let bar = UISearchBar()
        
        bar.placeholder = "Search"
        bar.searchBarStyle = .minimal
        bar.sizeToFit()
        
        return bar
        
    }()
    
    override init(searchResultsController: UIViewController?) {
        super.init(searchResultsController: searchResultsController)

        self.searchBar.searchBarStyle = .minimal
        self.searchBar.tintColor    = Theme.primaryText
        self.searchBar.barTintColor = Theme.primaryBackground
        self.searchBar.searchTextField.textColor = Theme.primaryText
        
        #warning("searchTextField is a real text")
        let placeholderAttributes: [NSAttributedString.Key : Any]? = [
            NSAttributedString.Key.foregroundColor: Theme.primaryText,
            NSAttributedString.Key.font: Theme.body3
        ]

        self.searchBar.searchTextField.attributedText = NSAttributedString(string: "Search", attributes: placeholderAttributes)
        
        self.searchBar.sizeToFit()

        self.hidesNavigationBarDuringPresentation = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        view.backgroundColor = .red
    }

}
