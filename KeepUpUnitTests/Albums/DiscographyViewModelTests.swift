//
//  AlbumsViewModelTests.swift
//  KeepUpUnitTests
//
//  Created by Prateek Kambadkone on 2019/04/30.
//  Copyright © 2019 Prateek Kambadkone. All rights reserved.
//

import XCTest
@testable import KeepUp

class DiscographyViewModelTests: XCTestCase {
    
    var testViewModel: DiscographyViewModel?
    var mockVC = MockDiscographyViewController()
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        testViewModel = DiscographyViewModel()
        testViewModel?.setViewControllerDelegate(viewController: mockVC)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testThatCorrectAlbumsAreReturnedWithModifiedDates() {
        testViewModel?.setRepositoryDelegate(repository: MockDiscographyRepository())
        testViewModel?.getAlbums(of: 100)
    }
    
    func testThatCorrectErrorIsShownOnInvalidInput() {
        testViewModel?.setRepositoryDelegate(repository: MockDiscographyRepository())
        testViewModel?.getAlbums(of: -1)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
