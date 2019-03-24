//
//  LyricsViewModelTests.swift
//  KeepUpUnitTests
//
//  Created by Prateek Kambadkone on 2019/03/20.
//  Copyright © 2019 Prateek Kambadkone. All rights reserved.
//

import XCTest
@testable import KeepUp

class MockLyricsRepository: LyricsRepositoryProtocol {

    var networkDelegate: LyricsNetworkProtocol?
    
    func dataReady(result: Result<[String]>) {
        //from network
    }
    func notifyViewModel(info: [String]) {
        //from dataReady
    }
    
    var viewModelDelegate: LyricsViewModelProtocol?
    
    var artistInfo: Lyrics?
    
    init () {
        viewModelDelegate?.repositoryDelegate = self
    }
    
    func getSongLyricsFromDataSource(artistName: String, songTitle: String) {
        var result: Result<Lyrics>
        if artistName.isEmpty || songTitle.isEmpty {
            result = Result.failure(Errors.InvalidInput)
        } else {
            let exampleWords = """
                            lyrics... lyrics, Lyrics \t lyrics, \n lyrics
                            \n\n Lyrics
                            """
            let exampleCopyright = "random guy"
            let exampleSongTitle = "example stuff"
            let exampleArtistName = "that person"
            let exampleUrlLink = "none yet"
            let lyrics = Lyrics(words: exampleWords, copyright: exampleCopyright, songTitle: exampleSongTitle, artistName: exampleArtistName, urlLink: exampleUrlLink)
            result = Result.success(lyrics)
        }
        viewModelDelegate?.setLyricsOnView(result: result)
    }
}

class MockLyricsViewController: LyricsViewControllerProtocol {
    
    var viewModelDelegate: LyricsViewModelProtocol?
    var isSolo: Bool = false
    
    let exampleWords = """
                        lyrics... lyrics, Lyrics \t lyrics, \n lyrics
                        \n\n Lyrics
                        """
    
    func songLyricsFailure(error: Errors) {
        XCTAssert(error == .InvalidInput)
        counter += 1
    }
    
    init() {
        viewModelDelegate = LyricsViewModel()
        viewModelDelegate?.viewControllerDelegate = self
        
    }
    
    func getSongLyrics(artistName: String, songTitle: String) {
        viewModelDelegate?.getSongLyricsFromRepository(artistName: artistName, songTitle: songTitle)
    }
    
    func songLyricsShow(lyrics: Lyrics) {
        //assert success
        XCTAssert(exampleWords == lyrics.words)
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

class LyricsViewModelTests: XCTestCase {
    var testViewModel: LyricsViewModel?
    var mockRepo = MockLyricsRepository()
    let mockViewController = MockLyricsViewController()
    
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

