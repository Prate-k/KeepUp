//
//  SettingsViewModelTests.swift
//  KeepUpUnitTests
//
//  Created by Prateek Kambadkone on 2019/04/29.
//  Copyright © 2019 Prateek Kambadkone. All rights reserved.
//

import XCTest
@testable import KeepUp

class SettingsViewModelTests: XCTestCase {

    var testViewModel: SettingsViewModel?
    var mockVC = MockSettingsViewController()
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        testViewModel = SettingsViewModel()
        testViewModel?.setViewControllerDelegate(viewController: mockVC)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testThatChecksAboutReturnsValueAsExpectedFromRepository() {
        testViewModel?.setRepositoryDelegate(repository: MockSettingsRepositorySuccess())
        testViewModel?.getAbout()
    }
    
    func testThatChecksAboutReturnsFailureAsExpectedFromRepository() {
        testViewModel?.setRepositoryDelegate(repository: MockSettingsRepositoryFailure())
        testViewModel?.getAbout()
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
