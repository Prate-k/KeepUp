//
//  SettingsViewModelExtensions.swift
//  KeepUp
//
//  Created by Prateek Kambadkone on 2019/04/28.
//  Copyright © 2019 Prateek Kambadkone. All rights reserved.
//

import Foundation

protocol SettingsViewModelProtocol: class {
    var viewControllerDelegate: SettingsViewControllerProtocol? { get set }
    var repositoryDelegate: SettingsRepositoryProtocol? { get set }
    func getAbout()
    func displayAbout(about: Result<About>)
}

extension SettingsViewModel: SettingsViewModelProtocol {
    
    func getAbout() {
        repositoryDelegate?.getAbout()
    }
    
    func displayAbout(about: Result<About>) {
        switch about {
        case .success(let about):
            self.viewControllerDelegate?.displayAbout(about: about)
        case .failure(let error):
            self.viewControllerDelegate?.networkFailure(error: error)
        }
    }
}
