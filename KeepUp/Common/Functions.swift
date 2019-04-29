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
                                  message: "Could not load information for artist",
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

func showCouldNotLoadSongError(viewController: UIViewController) {
    let alert = UIAlertController(title: "Empty song details",
                                  message: "Could not load Song details - Please retry",
                                  preferredStyle: .alert)
    let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
    alert.addAction(action)
    viewController.present(alert, animated: true, completion: nil)
}

func showCouldNotLoadAlbumError(viewController: UIViewController) {
    let alert = UIAlertController(title: "No albums found",
                                  message: "Could not load albums - Please retry",
                                  preferredStyle: .alert)
    let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
    alert.addAction(action)
    viewController.present(alert, animated: true, completion: nil)
}

func showCouldNotLoadSongsError(viewController: UIViewController) {
    let alert = UIAlertController(title: "No songs found",
                                  message: "Could not load album tracks - Please retry",
                                  preferredStyle: .alert)
    let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
    alert.addAction(action)
    viewController.present(alert, animated: true, completion: nil)
}

func showCouldNotLoadLyricsError(viewController: UIViewController) {
    let alert = UIAlertController(title: "Empty song title or artist name",
                                  message: "Could not load lyrics - Please retry",
                                  preferredStyle: .alert)
    let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
    alert.addAction(action)
    viewController.present(alert, animated: true, completion: nil)
}

func showLyricsLoadFailedAlertDialog(viewController: UIViewController) {
    let alert = UIAlertController(title: "Load Failed!",
                                  message: "Could not load lyrics for the song",
                                  preferredStyle: .alert)
    let action = UIAlertAction(title: "Ok", style: .default, handler: { _ in
        viewController.navigationController?.popViewController(animated: true)
    })
    alert.addAction(action)
    viewController.present(alert, animated: true, completion: nil)
}

func showLoginCancelledAlertDialog(viewController: UIViewController) {
    let alert = UIAlertController(title: "Login Cancelled or Failed!",
                                  message: "Login was cancelled or failed, Please try again to continue",
                                  preferredStyle: .alert)
    let action = UIAlertAction(title: "Ok", style: .default, handler: { _ in
//        viewController.navigationController?.popViewController(animated: true)
    })
    alert.addAction(action)
    viewController.present(alert, animated: true, completion: nil)
}


func extractValue(query: String) -> String {
    if let value = (query.split(separator: "=")).last {
        return String(value)
    }
    return ""
}
