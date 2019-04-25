//
//  SearchViewControllerExtensions.swift
//  KeepUp
//
//  Created by Prateek Kambadkone on 2019/04/19.
//  Copyright © 2019 Prateek Kambadkone. All rights reserved.
//

import Foundation
import UIKit


protocol SearchViewControllerProtocol: class {
    var viewModelDelegate: SearchViewModelProtocol? { get set }
    func updateSearchResults(searchResults: SearchResults)
    func searchResultsFailure(error: Errors)
}

extension SearchViewController: SearchViewControllerProtocol {
    
    func updateSearchResults(searchResults: SearchResults) {
        isWaitingResult = false
        self.searchResults = searchResults
        updateTableView()
    }
    
    func searchResultsFailure(error: Errors) {
        isWaitingResult = false
        self.searchResults?.removeAll()
        self.searchResults = nil
        updateTableView()
    }
    
    func updateTableView() {
        DispatchQueue.main.async {
            self.resultsTableView.reloadData()
        }
    }
    
}

extension SearchViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if !isWaitingResult {
            if searchText.count % 3 == 0 {
                let query = searchText.replacingOccurrences(of: " ", with: "+")
                isWaitingResult = true
                self.viewModelDelegate?.getSearchResultFromRepository(searchString: query)
            }
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchResults?.removeAll()
        if let searchText = searchBar.text {
            let query = searchText.replacingOccurrences(of: " ", with: "+")
            self.viewModelDelegate?.getSearchResultFromRepository(searchString: query)
        }
    }
}

extension SearchViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let results = searchResults {
            return results.count()
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchResultCell", for: indexPath) as? SearchResultCell
        if let searchResults = self.searchResults {
            if let result = searchResults.get(i: indexPath.row) {
                cell?.artistNameLabel.text = result.artistName
                cell?.artistThumbnailImageView.loadImageFromSource(source: result.artistThumbnail!)
            }
        }
        return cell!
    }
}
