//
// Created by Prateek Kambadkone on 2019-03-17.
// Copyright (c) 2019 Prateek Kambadkone. All rights reserved.
//

import Foundation

protocol DiscographyRepositoryFunctionable {
    func getAlbumsListFromSource(artistName: String, completing: @escaping ([Album]) -> Void)
    func getSelectedArtist(at index: Int, completing: @escaping (Artist) -> Void)
    func getSelectedArtistIndex(name: String, completing: @escaping (Int) -> Void)
    func removeSelectedArtist(at index: Int)
    func addArtist(_ newArtist: Artist)
}

extension DiscographyRepository: DiscographyRepositoryFunctionable {
    
    func getSelectedArtistIndex(name: String, completing: @escaping (Int) -> Void) {
        if !name.isEmpty {
            completing(FavouriteArtists.isArtistInFavouriteList(name: name))
        }
    }
    
    func getAlbumsListFromSource(artistName: String, completing: @escaping ([Album]) -> Void) {
        //instead of network call accesses local data array
        if let artist = FavouriteArtists.getArtist(by: artistName) {
            completing(artist.artistAlbums)
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
