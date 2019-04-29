//
//  SettingsViewControllerExtensions.swift
//  KeepUp
//
//  Created by Prateek Kambadkone on 2019/04/28.
//  Copyright © 2019 Prateek Kambadkone. All rights reserved.
//

import Foundation

protocol SettingsViewControllerProtocol: class {
    var viewModelDelegate: SettingsViewModelProtocol? { get set }
    func displayAbout(about: About)
    func networkFailure(error: Errors)
}

extension SettingsViewController: SettingsViewControllerProtocol {

    
    func networkFailure(error: Errors) {
        print("error")
    }
    
    func displayAbout(about: About) {
        self.aboutView.isHidden = false
        self.aboutTextView.text = about.about
    }
    
}
