//
//  SettingsViewModel.swift
//  KeepUp
//
//  Created by Prateek Kambadkone on 2019/04/28.
//  Copyright © 2019 Prateek Kambadkone. All rights reserved.
//

import Foundation

class SettingsViewModel {
    
    lazy var viewControllerDelegate: SettingsViewControllerProtocol? = nil
    lazy var repositoryDelegate: SettingsRepositoryProtocol? = nil
    
    init() {
        repositoryDelegate = SettingsRepository()
        repositoryDelegate?.viewModelDelegate = self
    }
    
    func setRepositoryDelegate(repository: SettingsRepositoryProtocol?) {
        if let repository = repository {
            repositoryDelegate = repository
        } else {
            repositoryDelegate = SettingsRepository()
        }
        repositoryDelegate?.viewModelDelegate = self
    }
    
    func setViewControllerDelegate(viewController: SettingsViewControllerProtocol?) {
        if let viewController = viewController {
            viewControllerDelegate = viewController
        } else {
            viewControllerDelegate = SettingsViewController()
        }
        viewControllerDelegate?.viewModelDelegate = self
    }
}
