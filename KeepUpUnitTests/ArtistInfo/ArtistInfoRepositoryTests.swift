//
//  ArtistInfoRepositoryTests.swift
//  KeepUpUnitTests
//
//  Created by Prateek Kambadkone on 2019/03/22.
//  Copyright © 2019 Prateek Kambadkone. All rights reserved.
//

import XCTest
@testable import KeepUp




class ArtistInfoRepositoryTests: XCTestCase {

    var mockViewModel = MockArtistInfoViewModel()
    var testRepo: ArtistInfoRepository?
    let mockNetwork = MockArtistInfoNetwork()
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        testRepo = ArtistInfoRepository()
        testRepo?.setViewModelDelegate(viewModel: mockViewModel)
        testRepo?.setNetworkDelegate(network: mockNetwork)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testThatTheCorrectDetailsAreShownWithValidData() {
        mockNetwork.testFailure = false
       mockViewModel.getArtistInfoFromRepository(artistName: "Linkin Park")
    }
    
    func testThatTheCorrectDetailsAreShownWhenInvalidData() {
        mockNetwork.testFailure = true
        mockViewModel.getArtistInfoFromRepository(artistName: "")
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
