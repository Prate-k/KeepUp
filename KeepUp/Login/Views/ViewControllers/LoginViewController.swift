//
//  LoginViewController.swift
//  KeepUp
//
//  Created by Prateek Kambadkone on 2019/03/15.
//  Copyright © 2019 Prateek Kambadkone. All rights reserved.
//

import UIKit
import FirebaseUI
import GoogleSignIn

class LoginViewController: UIViewController, GIDSignInUIDelegate {
    
    @IBOutlet weak var progressBar: UIActivityIndicatorView!
    @IBOutlet weak var myView: UIView!
    @IBOutlet weak var signInButton: GIDSignInButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        GIDSignIn.sharedInstance().uiDelegate = self
        
        progressBar.startAnimating()
        myView.isHidden = true
        GIDSignIn.sharedInstance().signIn()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        progressBar.stopAnimating()
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error?) {
        // ...
        if let error = error {
            // ...
            return
        }
        
        guard let authentication = user.authentication else { return }
        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
                                                       accessToken: authentication.accessToken)
        // ...
        
        Auth.auth().signInAndRetrieveData(with: credential) { (authResult, error) in
            if let error = error {
                // ...
                return
            }
        }
    }

    @IBAction func LoginAction(_ sender: Any) {
        //start progress bar on press and stop animation on viewWillDisappear
        GIDSignIn.sharedInstance().signIn()
    }
    
}
