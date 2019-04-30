//
//  MockSettingsViewController.swift
//  KeepUpUnitTests
//
//  Created by Prateek Kambadkone on 2019/04/29.
//  Copyright © 2019 Prateek Kambadkone. All rights reserved.
//

import Foundation
import XCTest
@testable import KeepUp

class MockSettingsViewController: SettingsViewControllerProtocol {
    var viewModelDelegate: SettingsViewModelProtocol?
    
    func networkFailure(error: Errors) {
        XCTAssert(error == Errors.NetworkError)
    }
    
    func displayAbout(about: About) {
        XCTAssert(about.about == "This is a mock about to test settings view model")
    }
    
}
