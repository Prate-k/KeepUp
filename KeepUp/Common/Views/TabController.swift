//
//  TabController.swift
//  KeepUp
//
//  Created by Prateek Kambadkone on 2019/04/15.
//  Copyright © 2019 Prateek Kambadkone. All rights reserved.
//

import UIKit

class TabController: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarController?.delegate = self
        self.selectedIndex = 0
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        print("-------------------------------------------\n\n\n")
        let index = tabBarController.selectedIndex
        print("selected viewcontroller: \(viewController.title)")
        if let navController = tabBarController.viewControllers?[tabBarController.selectedIndex] as? UINavigationController {
            navController.popToRootViewController(animated: false)
        } else {
            viewController.navigationController?.popToRootViewController(animated: false)
        }
        self.selectedIndex = index
        print("-------------------------------------------\n\n\n")
    }
}
