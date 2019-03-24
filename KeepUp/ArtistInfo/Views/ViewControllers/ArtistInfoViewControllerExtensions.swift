//
//  ArtistInfoViewControllerExtensions.swift
//  KeepUp
//
//  Created by Prateek Kambadkone on 2019/03/05.
//  Copyright © 2019 Prateek Kambadkone. All rights reserved.
//

import Foundation

protocol ArtistInfoViewControllerProtocol: class {
    var viewModelDelegate: ArtistInfoViewModelProtocol? { get set }
    func artistInfoShow(artistInfo: ArtistInfo)
    func artistInfoFailure(error: Errors)
}

extension ArtistInfoViewController: ArtistInfoViewControllerProtocol {
    func artistInfoShow(artistInfo: ArtistInfo) {
        DispatchQueue.main.async {
            self.scrollView.isHidden = false
            if artistInfo.isSolo {
                self.membersStackView.isHidden = true
                self.originHeaderLabel.text = "Birth place"
                self.membersHeaderLabel.text = ""
            }
            self.waitForDataIndicator.stopAnimating()
            self.artistNameLabel.text = self.artistName
            self.genreLabel.text = artistInfo.genres
            self.originLabel.text = artistInfo.origin
            self.membersLabel.text = artistInfo.members
        }
    }
    
    func artistInfoFailure(error: Errors) {
        switch error {
        case .NetworkError:
            showArtistInfoLoadFailedAlertDialog(viewController: self)
        case .EmptySearch:
            showEmptySearchAlertDialog(viewController: self)
        case .InvalidInput:
            print("Invalid input")
        case .Unknown:
            print("unknown error")
        }
    }
}
