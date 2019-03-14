//
//  Functions.swift
//  KeepUp
//
//  Created by Prateek Kambadkone on 2019/03/14.
//  Copyright © 2019 Prateek Kambadkone. All rights reserved.
//

import Foundation
import UIKit

func showArtistInfoLoadFailedAlertDialog(viewController: UIViewController) {
    let alert = UIAlertController(title: "Load Failed!",
                                  message: "Could not load albums for artist",
                                  preferredStyle: .alert)
    let action = UIAlertAction(title: "Ok", style: .default, handler: { _ in
        viewController.navigationController?.popViewController(animated: true)
    })
    alert.addAction(action)
    viewController.present(alert, animated: true, completion: nil)
}

func showEmptySearchAlertDialog(viewController: UIViewController) {
    let alert = UIAlertController(title: "Empty Search",
                                  message: "Seach field is empty - Please enter an artist's name.",
                                  preferredStyle: .alert)
    let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
    alert.addAction(action)
    viewController.present(alert, animated: true, completion: nil)
}
