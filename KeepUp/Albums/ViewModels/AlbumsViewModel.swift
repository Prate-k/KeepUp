//
//  AlbumsViewModel.swift
//  KeepUp
//
//  Created by Prateek Kambadkone on 2019/03/16.
//  Copyright © 2019 Prateek Kambadkone. All rights reserved.
//

import Foundation

class AlbumsViewModel {
    weak var albumsViewController: ArtistInfoFetching?

    init(view: ArtistInfoFetching) {
        self.albumsViewController = view
    }
}
