//
//  MainScreenRepositoryExtensions.swift
//  KeepUp
//
//  Created by Prateek Kambadkone on 2019/03/18.
//  Copyright © 2019 Prateek Kambadkone. All rights reserved.
//

import Foundation

protocol MainScreenRepositoryFunctionable {
    func favouriteArtistList(completing: @escaping ([Artist]) -> Void)
    func getSelectedArtist(at index: Int, completing: @escaping (Artist) -> Void)
    func getSelectedArtistIndex(name: String, completing: @escaping (Int) -> Void)
    func removeSelectedArtist(at index: Int)
    func addArtist(_ newArtist: Artist)
}

extension MainScreenRepository: MainScreenRepositoryFunctionable {
    func favouriteArtistList(completing: @escaping ([Artist]) -> Void) {
        if !FavouriteArtists.isEmpty() {
            completing(FavouriteArtists.getList())
        }
    }
    
    func getSelectedArtistIndex(name: String, completing: @escaping (Int) -> Void) {
        if !name.isEmpty {
            completing(FavouriteArtists.isArtistInFavouriteList(name: name))
        }
    }
    
    func getSelectedArtist(at index: Int, completing: @escaping (Artist) -> Void) {
        if index >= 0 {
            if let artist = FavouriteArtists.getArtist(at: index) {
                completing(artist)
            }
        }
    }
    func removeSelectedArtist(at index: Int) {
        FavouriteArtists.removeArtist(at: index)
    }
    func addArtist(_ newArtist: Artist) {
        FavouriteArtists.addArtist(artist: newArtist)
    }
}
