//
//  MockSearchRepository.swift
//  KeepUpUnitTests
//
//  Created by Prateek Kambadkone on 2019/04/29.
//  Copyright © 2019 Prateek Kambadkone. All rights reserved.
//

import Foundation
@testable import KeepUp

class MockSearchRepository: SearchRepositoryProtocol {
    var viewModelDelegate: SearchViewModelProtocol?
    var networkDelegate: SearchNetworkProtocol?
    
    func dataReady(result: Result<SearchResults>) {
        switch result {
        case .success(let data):
            notifyViewModel(result: Result.success(data))
        case .failure(let error):
            notifyViewModel(result: Result.failure(error))
        }
    }
    
    func getSearchResultsFromSource(searchString: String, searchFilter: String = "artist") {
        if searchString.isEmpty {
            dataReady(result: Result.failure(.InvalidInput))
        } else {
            var results: [SearchResult] = []
            for index in 0..<3 {
                results.append(SearchResult(artistID: index, artistName: "Artist\(index)", artistThumbnail: "Image\(index)"))
            }
            dataReady(result: Result.success(SearchResults(results: results)))
        }
    }
    
    func notifyViewModel(result: Result<SearchResults>) {
        viewModelDelegate?.setSearchResultsOnView(result: result)
    }
}
