//
//  LyricsRepositoryTests.swift
//  KeepUpUnitTests
//
//  Created by Prateek Kambadkone on 2019/03/24.
//  Copyright © 2019 Prateek Kambadkone. All rights reserved.
//

import XCTest
@testable import KeepUp

//class MockLyricsViewModel: LyricsViewModelProtocol {
//    let exampleWords = """
//                            lyrics... lyrics, Lyrics \t lyrics, \n lyrics
//                            \n\n Lyrics
//                            """
//    weak var viewControllerDelegate: LyricsViewControllerProtocol?
//
//    weak var repositoryDelegate: LyricsRepositoryProtocol?
//
//    init() {
//        repositoryDelegate?.viewModelDelegate = self
//        viewControllerDelegate?.viewModelDelegate = self
//    }
//
//    func getSongLyricsFromRepository(artistName: String, songTitle: String) {
//        repositoryDelegate?.getSongLyricsFromDataSource(artistName: artistName, songTitle: songTitle)
//    }
//
//    func setLyricsOnView(result: Result<Lyrics>) {
//        switch result {
//        case .success(let lyrics):
//            //assert success
//            XCTAssert(lyrics.words == exampleWords)
//        case .failure(let error):
//            //assert error
//            XCTAssert(error == Errors.InvalidInput)
//        }
//    }
//}

//class MockLyricsNetwork: LyricsNetworkProtocol {
//    var testFailure = false
//    weak var repositoryDelegate: LyricsRepositoryProtocol?
//    
//    func getDataFromNetwork() {
//        var result: Result<[String]>
//        if !testFailure {
//            let exampleWords = """
//                            lyrics... lyrics, Lyrics \t lyrics, \n lyrics
//                            \n\n Lyrics
//                            """
//            let exampleCopyright = "random guy"
//            let exampleSongTitle = "example stuff"
//            let exampleArtistName = "that person"
//            let exampleUrlLink = "none yet"
//            let contents = [exampleWords, exampleCopyright, exampleSongTitle, exampleArtistName, exampleUrlLink]
//            result = Result.success(contents)
//        } else {
//            result = Result.failure(Errors.NetworkError)
//        }
//        repositoryDelegate?.dataReady(result: result)
//    }
//}
class LyricsRepositoryTests: XCTestCase {
//    var mockViewModel = MockLyricsViewModel()
//    var testRepo: LyricsRepository?
//    let mockNetwork = MockLyricsNetwork()
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
//        testRepo = LyricsRepository()
//        testRepo?.setViewModelDelegate(viewModel: mockViewModel)
//        testRepo?.setNetworkDelegate(network: mockNetwork)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testThatTheCorrectDetailsAreShownWithValidData() {
//        mockNetwork.testFailure = false
//        mockViewModel.getSongLyricsFromRepository(artistName: "Artist 0", songTitle: "Song Title")
    }
    
    func testThatTheCorrectDetailsAreShownWhenInvalidData() {
//        mockNetwork.testFailure = true
//        mockViewModel.getSongLyricsFromRepository(artistName: "", songTitle: "")
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}
