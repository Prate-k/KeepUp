//
//  MainScreenViewModel.swift
//  KeepUp
//
//  Created by Prateek Kambadkone on 2019/03/18.
//  Copyright © 2019 Prateek Kambadkone. All rights reserved.
//

import Foundation

class HomeViewModel {
    
    lazy var viewControllerDelegate: HomeViewControllerProtocol? = nil
    lazy var repositoryDelegate: HomeRepositoryProtocol? = nil
    
    init() {
        repositoryDelegate = HomeRepository()
        repositoryDelegate?.viewModelDelegate = self
    }
    
    func setRepositoryDelegate(repository: HomeRepositoryProtocol?) {
        if let repository = repository {
            repositoryDelegate = repository
        } else {
            repositoryDelegate = HomeRepository()
        }
        repositoryDelegate?.viewModelDelegate = self
    }
    
    func setViewControllerDelegate(viewController: HomeViewControllerProtocol?) {
        if let viewController = viewController {
            viewControllerDelegate = viewController
        } else {
            viewControllerDelegate = HomeViewController()
        }
        viewControllerDelegate?.viewModelDelegate = self
    }
}

