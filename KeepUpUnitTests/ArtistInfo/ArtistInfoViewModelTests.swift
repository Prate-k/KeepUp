//
//  ArtistInfoViewModelTests.swift
//  KeepUpUnitTests
//
//  Created by Prateek Kambadkone on 2019/03/22.
//  Copyright © 2019 Prateek Kambadkone. All rights reserved.
//

import XCTest
@testable import KeepUp

class MockArtistInfoRepository: ArtistInfoRepositoryProtocol {
    lazy var networkDelegate: ArtistInfoNetworkProtocol? = nil
    
    func dataReady(result: Result<[String]>) {
        //from network
    }
    func notifyViewModel(info: [String]) {
        //from dataReady
    }
    
    weak var viewModelDelegate: ArtistInfoViewModelProtocol?
    
    var artistInfo: ArtistInfo?
    
    init () {
        viewModelDelegate?.repositoryDelegate = self
    }
    
    func getArtistDataFromSource(artistName: String) {
        var result: Result<ArtistInfo>
        if artistName.isEmpty {
            let artistInfo = ArtistInfo(origin: "Agoura Hills, California, U.S.",
                                        genres: """
                                                    Alternative rock\n
                                                    nu metal alternative\n
                                                    metal\n
                                                    rap rock\n
                                                    electronic rock
                                                    """,
                                        members: """
                                                    Rob Bourdon\n
                                                    Brad Delson\n
                                                    Mike Shinoda\n
                                                    Dave Farrell\n
                                                    Joe Hahn
                                                    """,
                                        isSolo: false)
            result = Result.success(artistInfo)
        } else {
            result = Result.failure(Errors.NetworkError)
        }
        viewModelDelegate?.setArtistInfoOnView(result: result)
    }
}

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
