//
// Created by Prateek Kambadkone on 2019-03-17.
// Copyright (c) 2019 Prateek Kambadkone. All rights reserved.
//

import Foundation

class DiscographyRepository {
    
    var viewModelDelegate: DiscographyViewModelProtocol?
    var networkDelegate: DiscographyNetworkProtocol?
    init () {
        viewModelDelegate?.repositoryDelegate = self
    }
    
    func setViewModelDelegate(viewModel: DiscographyViewModelProtocol?) {
        if let viewModel = viewModel {
            viewModelDelegate = viewModel
        } else {
            viewModelDelegate = DiscographyViewModel()
        }
        viewModelDelegate?.repositoryDelegate = self
    }
    
    func setNetworkDelegate(network: DiscographyNetworkProtocol?) {
        if let network = network {
            networkDelegate = network
            networkDelegate?.repositoryDelegate = self
        } else {
            networkDelegate = nil
        }
    }
}
