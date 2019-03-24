//
//  ArtistInfoRepositoryTests.swift
//  KeepUpUnitTests
//
//  Created by Prateek Kambadkone on 2019/03/22.
//  Copyright © 2019 Prateek Kambadkone. All rights reserved.
//

import XCTest
@testable import KeepUp

class MockArtistInfoViewModel: ArtistInfoViewModelProtocol {
    
    var origin: String = " Agoura Hills, California, U.S.\n"
    var genre: String = " Alternative rock\n nu metal\nalternative metal\n rap rock\nelectronic rock\n\n"
    var members: String = " Rob Bourdon\n Brad Delson\n Mike Shinoda\n Dave Farrell\n Joe Hahn\n"
    var isSolo: Bool = false
    
    var viewControllerDelegate: ArtistInfoViewControllerProtocol?
    
    var repositoryDelegate: ArtistInfoRepositoryProtocol?
    
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

class MockArtistInfoNetwork: ArtistInfoNetworkProtocol {
    var testFailure = false
    var repositoryDelegate: ArtistInfoRepositoryProtocol?
    
    func getDataFromNetwork() {
        var result: Result<[String]>
        if !testFailure {
            let info = ["| background      = group_or_band\n", "| origin          = [[Agoura Hills, California]], U.S.\n", "", "| genre           = {{flatlist|\n* [[Alternative rock]]\n* [[nu metal]]\n* {{nowrap|[[alternative metal]]}}\n* [[rap rock]]\n* {{nowrap|[[electronic rock]]}}\n}}\n", "| current_members = <!-- Do not change the order of the members per Template:Infobox musical artist. -->\n* [[Rob Bourdon]]\n* [[Brad Delson]]\n* [[Mike Shinoda]]\n* [[Dave Farrell]]\n* [[Joe Hahn]]\n"]
            result = Result.success(info)
        } else {
            result = Result.failure(Errors.NetworkError)
        }
        repositoryDelegate?.dataReady(result: result)
    }
}

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
