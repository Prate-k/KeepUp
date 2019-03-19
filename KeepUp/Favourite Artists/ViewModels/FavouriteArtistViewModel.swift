//
//  FavouriteArtistViewModel.swift
//  KeepUp
//
//  Created by Prateek Kambadkone on 2019/03/19.
//  Copyright © 2019 Prateek Kambadkone. All rights reserved.
//

import Foundation

class FavouriteArtistsViewModel {
    weak var favouriteArtistsViewController: FavouriteArtistsViewController?
    
    init(view: FavouriteArtistsViewController) {
        self.favouriteArtistsViewController = view
    }
}
