//
//  SongsViewModel.swift
//  KeepUp
//
//  Created by Prateek Kambadkone on 2019/03/17.
//  Copyright © 2019 Prateek Kambadkone. All rights reserved.
//

import Foundation

class SongsViewModel {
    
    var viewControllerDelegate: SongsViewControllerProtocol?
    var repositoryDelegate: SongsRepositoryProtocol?
    
    init() {
        repositoryDelegate = SongsRepository()
        repositoryDelegate?.viewModelDelegate = self
    }
    
    func setRepositoryDelegate(repository: SongsRepositoryProtocol?) {
        if let repository = repository {
            repositoryDelegate = repository
        } else {
            repositoryDelegate = SongsRepository()
        }
        repositoryDelegate?.viewModelDelegate = self
    }
    
    func setViewControllerDelegate(viewController: SongsViewControllerProtocol?) {
        if let viewController = viewController {
            viewControllerDelegate = viewController
        } else {
            viewControllerDelegate = SongsViewController()
        }
        viewControllerDelegate?.viewModelDelegate = self
    }
}
