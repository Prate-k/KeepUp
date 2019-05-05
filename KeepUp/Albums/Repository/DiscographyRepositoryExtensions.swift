//
// Created by Prateek Kambadkone on 2019-03-17.
// Copyright (c) 2019 Prateek Kambadkone. All rights reserved.
//

import Foundation

protocol DiscographyRepositoryProtocol: class {
    var viewModelDelegate: DiscographyViewModelProtocol? {get set}
    func dataReady(result: Result<Albums>)
    func removeSelectedArtist(artistName: String)
    func addArtist(newArtist: SelectedArtist)
    func getAlbums(of artistID: Int)
    func checkIfInFavourites(_ artistName: String)
}

extension DiscographyRepository: DiscographyRepositoryProtocol {
    
    func dataReady(result: Result<Albums>) {
        switch result {
        case .success(let album):
            viewModelDelegate?.updateAlbumsForArtist(result: Result.success(album))
        case .failure(let error):
            viewModelDelegate?.updateAlbumsForArtist(result: Result.failure(error))
        }
    }

    func removeSelectedArtist(artistName: String) {
        let index = FavouriteArtists.isArtistInFavouriteList(name: artistName)
        if index >= 0 {
            FavouriteArtists.removeArtist(at: index)
            return
        }
    }
    
    func addArtist(newArtist: SelectedArtist) {
        FavouriteArtists.addArtist(artist: newArtist)
    }
    
    func getAlbums(of artistID: Int) {
//        if let artist = FavouriteArtists.getArtist(by: artistName) {
//            dataReady(result: Result.success(artist))
//        } else {
//            dataReady(result: Result.failure(Errors.InvalidInput))
//        }
        let filter = "\(artistID)/albums"
        let site = "https://api.deezer.com/artist/\(filter)/"
        let query = [""]
        
        self.networkDelegate = DiscographyNetwork(site: site, query: query, requestType: .GET)
        self.networkDelegate?.repositoryDelegate = self
        self.networkDelegate?.getDataFromNetwork()
    }
    
    func checkIfInFavourites(_ artistName: String) {
        let index = FavouriteArtists.isArtistInFavouriteList(name: artistName)
        if index < 0 {
            viewModelDelegate?.isArtistFound(false)
        } else {
            viewModelDelegate?.isArtistFound(true)
        }
    }
    
}
