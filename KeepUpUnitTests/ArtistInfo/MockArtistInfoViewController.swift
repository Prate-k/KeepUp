//
//  MockArtistInfoViewController.swift
//  KeepUpUnitTests
//
//  Created by Prateek Kambadkone on 2019/04/30.
//  Copyright © 2019 Prateek Kambadkone. All rights reserved.
//

import Foundation
@testable import KeepUp
import XCTest

class MockArtistInfoViewController: ArtistInfoViewControllerProtocol {
    var origin: String = "Agoura Hills, California, U.S."
    var genre: String = """
                        Alternative rock\n
                        nu metal alternative\n
                        metal\n
                        rap rock\n
                        electronic rock
                        """
    var members: String = """
                            Rob Bourdon\n
                            Brad Delson\n
                            Mike Shinoda\n
                            Dave Farrell\n
                            Joe Hahn
                            """
    var isSolo: Bool = false
    
    func artistInfoFailure(error: Errors) {
        XCTAssert(error == .NetworkError)
        counter += 1
    }
    
    var viewModelDelegate: ArtistInfoViewModelProtocol?
    
    init() {
        viewModelDelegate = ArtistInfoViewModel()
        viewModelDelegate?.viewControllerDelegate = self
        
    }
    
    func getArtistInfo(artistName: String) {
        viewModelDelegate?.getArtistInfoFromRepository(artistName: artistName)
    }
    
    func artistInfoShow(artistInfo: ArtistInfo) {
        XCTAssert(origin == artistInfo.origin)
        XCTAssert(genre == artistInfo.genres)
        XCTAssert(members == artistInfo.members)
        XCTAssert(isSolo == artistInfo.isSolo)
        counter += 1
    }
    
    var counter = 0
    
    func reset() {
        counter = 0
    }
    
    func verify () {
        XCTAssert(counter == 1)
    }
}
