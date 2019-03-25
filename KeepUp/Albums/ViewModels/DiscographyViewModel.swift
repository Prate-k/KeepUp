//
//  DiscographyViewModel.swift
//  KeepUp
//
//  Created by Prateek Kambadkone on 2019/03/16.
//  Copyright © 2019 Prateek Kambadkone. All rights reserved.
//

import Foundation

class DiscographyViewModel {
    
    var viewControllerDelegate: DiscographyViewControllerProtocol?
    var repositoryDelegate: DiscographyRepositoryProtocol?
    
    init() {
        repositoryDelegate = DiscographyRepository()
        repositoryDelegate?.viewModelDelegate = self
    }
    
    func setRepositoryDelegate(repository: DiscographyRepositoryProtocol?) {
        if let repository = repository {
            repositoryDelegate = repository
        } else {
            repositoryDelegate = DiscographyRepository()
        }
        repositoryDelegate?.viewModelDelegate = self
    }
    
    func setViewControllerDelegate(viewController: DiscographyViewControllerProtocol?) {
        if let viewController = viewController {
            viewControllerDelegate = viewController
        } else {
            viewControllerDelegate = DiscographyViewController()
        }
        viewControllerDelegate?.viewModelDelegate = self
    }
}
