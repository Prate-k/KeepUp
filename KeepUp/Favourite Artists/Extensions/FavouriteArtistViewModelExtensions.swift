//
//  FavouriteArtistViewModelExtensions.swift
//  KeepUp
//
//  Created by Prateek Kambadkone on 2019/03/19.
//  Copyright © 2019 Prateek Kambadkone. All rights reserved.
//

import Foundation

protocol FavouriteArtistsViewModelFunctionable {
    func getFavouriteList() -> [Artist]
    func removeArtist(at index: Int)
}

extension FavouriteArtistsViewModel: FavouriteArtistsViewModelFunctionable {
    func getFavouriteList() -> [Artist] {
        let favouriteArtistsRepository: FavouriteArtistsRepositoryFunctionable = FavouriteArtistsRepository()
        var favArtists: [Artist] = []
        favouriteArtistsRepository.favouriteArtistList(completing: {(artists) in
            favArtists = artists
        })
        return favArtists
    }
    
    func removeArtist(at index: Int) {
        let favouriteArtistsRepository: FavouriteArtistsRepositoryFunctionable = FavouriteArtistsRepository()
        favouriteArtistsRepository.removeSelectedArtist(at: index)
    }
}
