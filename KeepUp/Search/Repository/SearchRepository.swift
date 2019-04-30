//
//  SearchRepository.swift
//  KeepUp
//
//  Created by Prateek Kambadkone on 2019/04/19.
//  Copyright © 2019 Prateek Kambadkone. All rights reserved.
//

import Foundation

class SearchRepository {
    
    var viewModelDelegate: SearchViewModelProtocol?
    var networkDelegate: SearchNetworkProtocol?
    init () {
        viewModelDelegate?.repositoryDelegate = self
    }
    
    func setViewModelDelegate(viewModel: SearchViewModelProtocol?) {
        if let viewModel = viewModel {
            viewModelDelegate = viewModel
        } else {
            viewModelDelegate = SearchViewModel()
        }
        viewModelDelegate?.repositoryDelegate = self
    }
    
    func setNetworkDelegate(network: SearchNetworkProtocol?) {
        if let network = network {
            networkDelegate = network
            networkDelegate?.repositoryDelegate = self
        } else {
            networkDelegate = nil
        }
    }
}
