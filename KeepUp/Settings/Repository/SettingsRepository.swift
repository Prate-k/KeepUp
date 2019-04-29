//
//  SettingsRepository.swift
//  KeepUp
//
//  Created by Prateek Kambadkone on 2019/04/28.
//  Copyright © 2019 Prateek Kambadkone. All rights reserved.
//

import Foundation

class SettingsRepository {
    
    var viewModelDelegate: SettingsViewModelProtocol?
    var networkDelegate: SettingsNetworkProtocol?
    init () {
        viewModelDelegate?.repositoryDelegate = self
    }
    
    func setViewModelDelegate(viewModel: SettingsViewModelProtocol?) {
        if let viewModel = viewModel {
            viewModelDelegate = viewModel
        } else {
            viewModelDelegate = SettingsViewModel()
        }
        viewModelDelegate?.repositoryDelegate = self
    }
    
    func setNetworkDelegate(network: SettingsNetworkProtocol?) {
        if let network = network {
            networkDelegate = network
            networkDelegate?.repositoryDelegate = self
        } else {
            networkDelegate = nil
        }
    }
}
