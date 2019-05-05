//
//  MainScreenRepository.swift
//  KeepUp
//
//  Created by Prateek Kambadkone on 2019/03/18.
//  Copyright © 2019 Prateek Kambadkone. All rights reserved.
//

import Foundation

class HomeRepository {
    
    var viewModelDelegate: HomeViewModelProtocol?
    var networkDelegate: HomeNetworkProtocol?
    
    
    init () {
        viewModelDelegate?.repositoryDelegate = self
    }
    
    func setViewModelDelegate(viewModel: HomeViewModelProtocol?) {
        if let viewModel = viewModel {
            viewModelDelegate = viewModel
        } else {
            viewModelDelegate = HomeViewModel()
        }
        viewModelDelegate?.repositoryDelegate = self
    }
    
    func setNetworkDelegate(network: HomeNetworkProtocol?) {
        if let network = network {
            networkDelegate = network
            networkDelegate?.repositoryDelegate = self
        } else {
            networkDelegate = nil
        }
    }
}
