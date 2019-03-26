//
//  LyricsRepository.swift
//  KeepUp
//
//  Created by Prateek Kambadkone on 2019/03/18.
//  Copyright © 2019 Prateek Kambadkone. All rights reserved.
//

import Foundation

class LyricsRepository {
    var viewModelDelegate: LyricsViewModelProtocol?
    var networkDelegate: LyricsNetworkProtocol?
    init () {
        viewModelDelegate?.repositoryDelegate = self
    }
    
    func setViewModelDelegate(viewModel: LyricsViewModelProtocol?) {
        if let viewModel = viewModel {
            viewModelDelegate = viewModel
        } else {
            viewModelDelegate = LyricsViewModel()
        }
        viewModelDelegate?.repositoryDelegate = self
    }
    
    func setNetworkDelegate(network: LyricsNetworkProtocol?) {
        if let network = network {
            networkDelegate = network
            networkDelegate?.repositoryDelegate = self
        } else {
            networkDelegate = nil
        }
    }
}
