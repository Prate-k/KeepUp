//
// Created by Prateek Kambadkone on 2019-03-17.
// Copyright (c) 2019 Prateek Kambadkone. All rights reserved.
//

import Foundation

class DiscographyRepository {
    
    var viewModelDelegate: DiscographyViewModelProtocol?
    
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
}
