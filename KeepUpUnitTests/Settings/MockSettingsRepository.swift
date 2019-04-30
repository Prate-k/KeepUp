//
//  MockSettingsRepository.swift
//  KeepUpUnitTests
//
//  Created by Prateek Kambadkone on 2019/04/29.
//  Copyright © 2019 Prateek Kambadkone. All rights reserved.
//

import Foundation
import XCTest
@testable import KeepUp

class MockSettingsRepositorySuccess: SettingsRepositoryProtocol {
    var networkDelegate: SettingsNetworkProtocol?
    
    var viewModelDelegate: SettingsViewModelProtocol?
    
    func dataReady(result: Result<About>) {
        switch result {
        case .success(let data):
            notifyViewModel(about: Result.success(data))
        case .failure(let error):
            notifyViewModel(about: Result.failure(error))
        }
    }
    
    func getAbout() {
        var mockAbout = About(about: "This is a mock about to test settings view model")
        dataReady(result: Result.success(mockAbout))
    }
    
    func notifyViewModel(about: Result<About>) {
        viewModelDelegate?.displayAbout(about: about)
    }
}

class MockSettingsRepositoryFailure: SettingsRepositoryProtocol {
    var networkDelegate: SettingsNetworkProtocol?
    
    var viewModelDelegate: SettingsViewModelProtocol?
    
    func dataReady(result: Result<About>) {
        switch result {
        case .success(let data):
            notifyViewModel(about: Result.success(data))
        case .failure(let error):
            notifyViewModel(about: Result.failure(error))
        }
    }
    
    func getAbout() {
        dataReady(result: Result.failure(Errors.NetworkError))
    }
    
    func notifyViewModel(about: Result<About>) {
        viewModelDelegate?.displayAbout(about: about)
    }
}
