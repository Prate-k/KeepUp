//
//  SettingsRepositoryExtensions.swift
//  KeepUp
//
//  Created by Prateek Kambadkone on 2019/04/28.
//  Copyright © 2019 Prateek Kambadkone. All rights reserved.
//

import Foundation

protocol SettingsRepositoryProtocol: class {
    var viewModelDelegate: SettingsViewModelProtocol? {get set}
    var networkDelegate: SettingsNetworkProtocol? { get set }
    func getAbout()
    func dataReady(result: Result<About>)
}

extension SettingsRepository: SettingsRepositoryProtocol {
    
    func dataReady(result: Result<About>) {
        switch result {
        case .success(let data):
            notifyViewModel(about: Result.success(data))
        case .failure(let error):
            notifyViewModel(about: Result.failure(error))
        }
    }
    
    func getAbout() {
        let filter = "about"
        let site = "https://keep-up-services.vapor.cloud/about"
        let query = [""]
        
        self.networkDelegate = SettingsNetwork(site: site, query: query, requestType: .GET)
        self.networkDelegate?.repositoryDelegate = self
        self.networkDelegate?.getDataFromNetwork()
    }
    
    func notifyViewModel(about: Result<About>) {
        viewModelDelegate?.displayAbout(about: about)
    }
}
