//
//  SettingsViewController.swift
//  KeepUp
//
//  Created by Prateek Kambadkone on 2019/04/28.
//  Copyright © 2019 Prateek Kambadkone. All rights reserved.
//

import Foundation
import UIKit

class SettingsViewController: UIViewController {
    
    var viewModelDelegate: SettingsViewModelProtocol?
    @IBOutlet weak var aboutView: UIView!
    @IBOutlet weak var aboutTextView: UITextView!
    @IBOutlet weak var aboutCloseButton: UIButton!
    @IBOutlet weak var aboutShowButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        aboutView.isHidden = true
        viewModelDelegate = SettingsViewModel()
        viewModelDelegate?.viewControllerDelegate = self
    }
    @IBAction func showAbout(_ sender: Any) {
        viewModelDelegate?.getAbout()
    }
    @IBAction func closeAbout(_ sender: Any) {
        aboutView.isHidden = true
    }
    
}
