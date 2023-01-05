//
//  MainViewController+Search.swift
//  NewsPapier
//
//  Created by Abdurrahman Gazi Yavuz on 12/12/22.
//

import UIKit


extension MainViewController: UISearchBarDelegate, UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        
        let searchBar   = searchController.searchBar
            
        #warning("white space bug")
        guard let query = searchBar.text,
              !query.trimmingCharacters(in: .whitespaces).isEmpty,
              query.trimmingCharacters(in: .whitespaces).count >= 3
        else { return }
        
        guard let resultsController = searchController.searchResultsController as? NewsViewController
        else {return}
        
        // To access SearchResultsViewControllerDelegate via the protocol
        resultsController.delegate  = self

        ExternalAPIClient.shared.fetch(QueryRequest(query: query)) { result in

            DispatchQueue.main.async {

                switch result {

                case .success(let result):
                    
                    guard let articles = result.articles else{return}
                    resultsController.setNews(articles)
                    resultsController.reloadNewsTable()

                case .failure(let error):

                    print(error.localizedDescription)

                }

            }

        }

    }
    
}

