//
//  SearchViewModelExtensions.swift
//  KeepUp
//
//  Created by Prateek Kambadkone on 2019/04/19.
//  Copyright © 2019 Prateek Kambadkone. All rights reserved.
//

import Foundation

protocol SearchViewModelProtocol: class {
    var viewControllerDelegate: SearchViewControllerProtocol? { get set }
    var repositoryDelegate: SearchRepositoryProtocol? { get set }
    func getSearchResultFromRepository(searchString: String)
    func setSearchResultsOnView(result: Result<SearchResults>)
}

extension SearchViewModel: SearchViewModelProtocol {
    
    func setSearchResultsOnView(result: Result<SearchResults>) {
        switch result {
        case .success(let data):
            self.viewControllerDelegate?.updateSearchResults(searchResults: data)
        case .failure(let error):
            self.viewControllerDelegate?.searchResultsFailure(error: error)
        }
    }
    
    func getSearchResultFromRepository(searchString: String) {
        repositoryDelegate?.getSearchResultsFromSource(searchString: searchString, searchFilter: "")
    }
}
