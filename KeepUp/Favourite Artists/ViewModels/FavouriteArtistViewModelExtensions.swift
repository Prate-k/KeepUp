//
//  FavouriteArtistViewModelExtensions.swift
//  KeepUp
//
//  Created by Prateek Kambadkone on 2019/03/19.
//  Copyright © 2019 Prateek Kambadkone. All rights reserved.
//

import Foundation

protocol FavouriteArtistsViewModelFunctionable {
    func getFavouriteList() -> [SelectedArtist]
    func removeArtist(at index: Int)
}

extension FavouriteArtistsViewModel: FavouriteArtistsViewModelFunctionable {
    
    func getFavouriteList() -> [SelectedArtist] {
        let favouriteArtistsRepository: FavouriteArtistsRepositoryFunctionable = FavouriteArtistsRepository()
        var favArtists: [SelectedArtist] = []
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
