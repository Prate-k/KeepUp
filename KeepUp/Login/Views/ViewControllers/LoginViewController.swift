//
//  LoginViewController.swift
//  KeepUp
//
//  Created by Prateek Kambadkone on 2019/03/15.
//  Copyright © 2019 Prateek Kambadkone. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var loginButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func LoginAction(_ sender: Any) {
        //start progress bar on press and stop animation on viewWillDisappear
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let initialViewController = mainStoryboard.instantiateViewController(withIdentifier: "FirstScreen")
        initialViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.present(initialViewController, animated: true, completion: nil)
    }
}
