//
//  SearchViewModel.swift
//  KeepUp
//
//  Created by Prateek Kambadkone on 2019/04/19.
//  Copyright © 2019 Prateek Kambadkone. All rights reserved.
//

import Foundation

class SearchViewModel {
    
    lazy var viewControllerDelegate: SearchViewControllerProtocol? = nil
    lazy var repositoryDelegate: SearchRepositoryProtocol? = nil
    
    init() {
        repositoryDelegate = SearchRepository()
        repositoryDelegate?.viewModelDelegate = self
    }
    
    func setRepositoryDelegate(repository: SearchRepositoryProtocol?) {
        if let repository = repository {
            repositoryDelegate = repository
        } else {
            repositoryDelegate = SearchRepository()
        }
        repositoryDelegate?.viewModelDelegate = self
    }
    
    func setViewControllerDelegate(viewController: SearchViewControllerProtocol?) {
        if let viewController = viewController {
            viewControllerDelegate = viewController
        } else {
            viewControllerDelegate = SearchViewController()
        }
        viewControllerDelegate?.viewModelDelegate = self
    }
}
