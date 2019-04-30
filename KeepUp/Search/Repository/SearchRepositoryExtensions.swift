//
//  SearchRepositoryExtensions.swift
//  KeepUp
//
//  Created by Prateek Kambadkone on 2019/04/19.
//  Copyright © 2019 Prateek Kambadkone. All rights reserved.
//

import Foundation

protocol SearchRepositoryProtocol: class {
    var viewModelDelegate: SearchViewModelProtocol? {get set}
    var networkDelegate: SearchNetworkProtocol? { get set }
    func getSearchResultsFromSource(searchString: String, searchFilter: String)
    func dataReady(result: Result<SearchResults>)
}

extension SearchRepository: SearchRepositoryProtocol {
    
    func dataReady(result: Result<SearchResults>) {
        switch result {
        case .success(let data):
            notifyViewModel(result: Result.success(data))
        case .failure(let error):
            notifyViewModel(result: Result.failure(error))
        }
    }
    
    func getSearchResultsFromSource(searchString: String, searchFilter: String = "artist") {
        let filter = "artist"
        let site = "https://api.deezer.com/search/\(filter)?"
        let query = ["q=\(searchString)", "order=POPULAR"]
        
        self.networkDelegate = SearchNetwork(site: site, query: query, requestType: .GET)
        self.networkDelegate?.repositoryDelegate = self
        self.networkDelegate?.getDataFromNetwork()
    }
    
    func notifyViewModel(result: Result<SearchResults>) {
        viewModelDelegate?.setSearchResultsOnView(result: result)
    }
}
