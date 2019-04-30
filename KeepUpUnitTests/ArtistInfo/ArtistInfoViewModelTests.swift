//
//  ArtistInfoViewModelTests.swift
//  KeepUpUnitTests
//
//  Created by Prateek Kambadkone on 2019/03/22.
//  Copyright © 2019 Prateek Kambadkone. All rights reserved.
//

import XCTest
@testable import KeepUp

class ArtistInfoViewModelTests: XCTestCase {
        var testViewModel: ArtistInfoViewModel?
        var mockRepo = MockArtistInfoRepository()
        let mockViewController = MockArtistInfoViewController()
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        testViewModel = ArtistInfoViewModel()
        testViewModel?.setRepositoryDelegate(repository: mockRepo)
        testViewModel?.setViewControllerDelegate(viewController: mockViewController)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        mockViewController.reset()
    }
    
    func testThatTheCorrectDetailsAreShownWithValidData() {
        mockViewController.getArtistInfo(artistName: "Linkin Park")
    }

    func testThatTheCorrectDetailsAreShownWhenInvalidData() {
        mockViewController.getArtistInfo(artistName: "")
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
