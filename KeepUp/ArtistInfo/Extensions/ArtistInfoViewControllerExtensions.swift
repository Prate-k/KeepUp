//
//  ArtistInfoViewControllerExtensions.swift
//  KeepUp
//
//  Created by Prateek Kambadkone on 2019/03/05.
//  Copyright © 2019 Prateek Kambadkone. All rights reserved.
//

import Foundation

protocol ArtistInfoFetching: class {
    func artistInfoShow(info: ArtistInfo) -> Void
}

extension ArtistInfoViewController: ArtistInfoFetching {
    func artistInfoShow(info: ArtistInfo) {
        DispatchQueue.main.async {
            self.scrollView.isHidden = false
            if info.isSolo {
                self.membersStackView.isHidden = true
                self.originHeaderLabel.text = "Birth place"
                self.membersHeaderLabel.text = ""
            }
            self.waitForDataIndicator.stopAnimating()
            self.artistNameLabel.text = self.artistName
            self.genreLabel.text = info.genres
            self.originLabel.text = info.origin
            self.membersLabel.text = info.members
        }
    }
}
