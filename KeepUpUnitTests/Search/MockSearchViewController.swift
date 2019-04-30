//
//  MockSearchViewController.swift
//  KeepUpUnitTests
//
//  Created by Prateek Kambadkone on 2019/04/29.
//  Copyright © 2019 Prateek Kambadkone. All rights reserved.
//

import Foundation
@testable import KeepUp
import XCTest

class MockSearchViewController: SearchViewControllerProtocol {
    var viewModelDelegate: SearchViewModelProtocol?
    
    func updateSearchResults(searchResults: SearchResults) {
        var bool = true
        for index in 0..<3 {
            let result = searchResults.get(i: index)
            if result?.artistName != "Artist\(index)" || result?.artistID != index || result?.artistThumbnail != "Image\(index)" {
                bool = false
                break
            }
        }
        XCTAssert(bool)
    }
    
    func searchResultsFailure(error: Errors) {
        XCTAssert(error == .InvalidInput)
    }
    
}
