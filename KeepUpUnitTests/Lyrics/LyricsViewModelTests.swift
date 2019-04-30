//
//  LyricsViewModelTests.swift
//  KeepUpUnitTests
//
//  Created by Prateek Kambadkone on 2019/03/20.
//  Copyright © 2019 Prateek Kambadkone. All rights reserved.
//

import XCTest
@testable import KeepUp

class LyricsViewModelTests: XCTestCase {
    var testViewModel: LyricsViewModel?
    var mockRepo = MockLyricsRepository()
    let mockViewController = MockLyricsViewController()
//
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        testViewModel = LyricsViewModel()
        testViewModel?.setRepositoryDelegate(repository: mockRepo)
        testViewModel?.setViewControllerDelegate(viewController: mockViewController)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        mockViewController.reset()
    }
    
    func testThatTheCorrectDetailsAreShownWithValidData() {
        mockViewController.getSongLyrics(artistName: "Artist 0", songTitle: "Song Title")
    }
    
    func testThatTheCorrectDetailsAreShownWhenInvalidData() {
        mockViewController.getSongLyrics(artistName: "", songTitle: "")
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
