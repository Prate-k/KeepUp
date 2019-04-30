//
//  LoginViewController.swift
//  KeepUp
//
//  Created by Prateek Kambadkone on 2019/03/15.
//  Copyright © 2019 Prateek Kambadkone. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn

class LoginViewController: UIViewController, GIDSignInDelegate, GIDSignInUIDelegate {
    
    var isAutoSignin: Bool?
    
    @IBOutlet weak var welcomeBackLabel: UILabel!
    @IBOutlet weak var googleButton: UIButton!
    @IBOutlet weak var myView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        FirebaseApp.configure()
        
        GIDSignIn.sharedInstance()?.clientID = FirebaseApp.app()?.options.clientID
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance()?.uiDelegate = self
    
        isAutoSignin = true
        myView.isHidden = true
        welcomeBackLabel.isHidden = true
        GIDSignIn.sharedInstance()?.signInSilently()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error?) {
        // ...
        if let error = error {
            // ...
            print("cannot sign in due to: \(error), loading LoginScreen")
            if myView.isHidden {
                myView.isHidden = false
            }
            if let isAutoSignin = isAutoSignin {
                if !isAutoSignin {
                    DispatchQueue.main.async {
                        let alert = UIAlertController(title: "Error",
                                                      message: "Login was cancelled or failed, Please try again to continue",
                                                      preferredStyle: .alert)
                        let action = UIAlertAction(title: "Ok", style: .default, handler: { _ in
                        })
                        alert.addAction(action)
                        self.present(alert, animated: true, completion: nil)
                    }
                    
                }
                self.isAutoSignin = false
            }
            return
        }
        
        if let isAutoSignin = isAutoSignin {
            if isAutoSignin {
                welcomeBackLabel.isHidden = false
                myView.isHidden = true
            }
        }
        guard let authentication = user.authentication else { return }
        _ = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
                                                       accessToken: authentication.accessToken)
        welcomeBackLabel.isHidden = false
        myView.isHidden = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let initialViewController = mainStoryboard.instantiateViewController(withIdentifier: "TabController")
            initialViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
            self.present(initialViewController, animated: true, completion: nil)
        }
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
    }

    @IBAction func LoginAction(_ sender: Any) {
        GIDSignIn.sharedInstance().signIn()
    }
    
}
