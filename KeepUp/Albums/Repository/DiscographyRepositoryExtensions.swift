//
// Created by Prateek Kambadkone on 2019-03-17.
// Copyright (c) 2019 Prateek Kambadkone. All rights reserved.
//

import Foundation

protocol DiscographyRepositoryProtocol: class {
    var viewModelDelegate: DiscographyViewModelProtocol? {get set}
    func dataReady(result: Result<Artist>)
    func removeSelectedArtist(artistName: String)
    func addArtist(newArtist: Artist)
    func getSelectedArtist(artistName: String)
}

extension DiscographyRepository: DiscographyRepositoryProtocol {

    func dataReady(result: Result<Artist>) {
        switch result {
        case .success(let artist):
            viewModelDelegate?.updateSelectedArtist(result: Result.success(artist))
        case .failure(let error):
            viewModelDelegate?.updateSelectedArtist(result: Result.failure(error))
        }
    }

    func removeSelectedArtist(artistName: String) {
        let index = FavouriteArtists.isArtistInFavouriteList(name: artistName)
        if index < 0 {
            dataReady(result: Result.failure(Errors.InvalidInput))
            return
        } else {
            FavouriteArtists.removeArtist(at: index)
        }
    }
    
    func addArtist(newArtist: Artist) {
        FavouriteArtists.addArtist(artist: newArtist)
    }
    
    func getSelectedArtist(artistName: String) {
        if let artist = FavouriteArtists.getArtist(by: artistName) {
            dataReady(result: Result.success(artist))
        } else {
            dataReady(result: Result.failure(Errors.InvalidInput))
        }
    }
}
