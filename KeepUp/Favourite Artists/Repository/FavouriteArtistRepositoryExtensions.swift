//
//  FavouriteArtistRepositoryExtensions.swift
//  KeepUp
//
//  Created by Prateek Kambadkone on 2019/03/19.
//  Copyright © 2019 Prateek Kambadkone. All rights reserved.
//

import Foundation

protocol FavouriteArtistsRepositoryFunctionable {
    func favouriteArtistList(completing: @escaping ([SelectedArtist]) -> Void)
    func removeSelectedArtist(at index: Int)
}

extension FavouriteArtistsRepository: FavouriteArtistsRepositoryFunctionable {
    func favouriteArtistList(completing: @escaping ([SelectedArtist]) -> Void) {
        if !FavouriteArtists.isEmpty() {
            completing(FavouriteArtists.getList())
        }
    }
    
    func removeSelectedArtist(at index: Int) {
        FavouriteArtists.removeArtist(at: index)
    }
}
