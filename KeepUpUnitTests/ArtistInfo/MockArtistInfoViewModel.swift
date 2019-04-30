//
//  MockArtistInfoViewModel.swift
//  KeepUpUnitTests
//
//  Created by Prateek Kambadkone on 2019/04/30.
//  Copyright © 2019 Prateek Kambadkone. All rights reserved.
//

import Foundation
@testable import KeepUp
import XCTest

class MockArtistInfoViewModel: ArtistInfoViewModelProtocol {
    
    var origin: String = " Agoura Hills, California, U.S.\n"
    var genre: String = " Alternative rock\n nu metal\nalternative metal\n rap rock\nelectronic rock\n\n"
    var members: String = " Rob Bourdon\n Brad Delson\n Mike Shinoda\n Dave Farrell\n Joe Hahn\n"
    var isSolo: Bool = false
    
    weak var viewControllerDelegate: ArtistInfoViewControllerProtocol?
    
    weak var repositoryDelegate: ArtistInfoRepositoryProtocol?
    
    init() {
        repositoryDelegate?.viewModelDelegate = self
        viewControllerDelegate?.viewModelDelegate = self
    }
    
    func getArtistInfoFromRepository(artistName: String) {
        repositoryDelegate?.getArtistDataFromSource(artistName: artistName)
    }
    
    func setArtistInfoOnView(result: Result<ArtistInfo>) {
        switch result {
        case .success(let artistInfo):
            XCTAssert(artistInfo.origin.contains(origin))
            XCTAssert(artistInfo.genres.contains(genre))
            XCTAssert(artistInfo.members.contains(members))
            XCTAssert(isSolo == artistInfo.isSolo)
        case .failure(let error):
            XCTAssert(error == .NetworkError)
        }
    }
}
