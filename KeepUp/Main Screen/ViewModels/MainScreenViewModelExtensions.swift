//
//  MainScreenViewModelExtensions.swift
//  KeepUp
//
//  Created by Prateek Kambadkone on 2019/03/18.
//  Copyright © 2019 Prateek Kambadkone. All rights reserved.
//

import Foundation

protocol MainScreenViewModelFunctionable: class {
    func getFavouriteList() -> [Artist]
    func getArtistIndex(name: String) -> Int
    func removeArtist(at index: Int)
    func addArtist(_ newArtist: Artist)
    func getTopTracks(artistName: String) -> [Song]
}

extension MainScreenViewModel: MainScreenViewModelFunctionable {
    func getArtistIndex(name: String) -> Int {
        let mainScreenRepository: MainScreenRepositoryFunctionable = MainScreenRepository()
        var artistIndex = -1
        mainScreenRepository.getSelectedArtistIndex(name: name, completing: {(index) in
            artistIndex = index
        })
        return artistIndex
    }
    func removeArtist(at index: Int) {
        let mainScreenRepository: MainScreenRepositoryFunctionable = MainScreenRepository()
        mainScreenRepository.removeSelectedArtist(at: index)
    }
    
    func addArtist(_ newArtist: Artist) {
        let mainScreenRepository: MainScreenRepositoryFunctionable = MainScreenRepository()
        mainScreenRepository.addArtist(newArtist)
    }
    
    func getFavouriteList() -> [Artist] {
        let mainScreenRepository: MainScreenRepositoryFunctionable = MainScreenRepository()
        var favArtists: [Artist] = []
        mainScreenRepository.favouriteArtistList(completing: {(artists) in
            favArtists = artists
        })
        return favArtists
    }
    
    func getTopTracks(artistName: String) -> [Song] {
        let mainScreenRepository: MainScreenRepositoryFunctionable = MainScreenRepository()
        var  topSongs: [Song] = []
        mainScreenRepository.topTracksList(artistName: artistName, completing: {(songs) in
            topSongs = songs
        })
        return topSongs
    }
    
}
