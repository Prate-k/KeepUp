//
//  MainScreenViewModelExtensions.swift
//  KeepUp
//
//  Created by Prateek Kambadkone on 2019/03/18.
//  Copyright © 2019 Prateek Kambadkone. All rights reserved.
//

import Foundation

protocol HomeViewModelProtocol: class {
    var viewControllerDelegate: HomeViewControllerProtocol? { get set }
    var repositoryDelegate: HomeRepositoryProtocol? { get set }
    func getTopArtistsFromRepository()
    func getPopularSongsFromRepository(artistID: Int, artistRank: Int)
    func updateTopArtistsOnView(result: Result<TopArtists>)
    func updatePopularSongsOnView(result: Result<PopularSong>, artistRank: Int)
}

extension HomeViewModel: HomeViewModelProtocol {
    
    func updatePopularSongsOnView(result: Result<PopularSong>, artistRank: Int) {
        switch result {
        case .success(let data):
            self.viewControllerDelegate?.updatePopularSong(result: data, rank: artistRank)
        case .failure(let error):
            self.viewControllerDelegate?.resultsFailure(error: error)
        }
    }
    
    func updateTopArtistsOnView(result: Result<TopArtists>) {
        switch result {
        case .success(let data):
            self.viewControllerDelegate?.updateTopArtists(results: data)
        case .failure(let error):
            self.viewControllerDelegate?.resultsFailure(error: error)
        }
    }
    
    func getTopArtistsFromRepository() {
        repositoryDelegate?.getTopArtistsFromSource()
    }
    
    func getPopularSongsFromRepository(artistID: Int, artistRank: Int) {
        repositoryDelegate?.getPopularSongsFromSource(artistID: artistID, artistRank: artistRank)
    }
}




//protocol MainScreenViewModelFunctionable: class {
//    func getFavouriteList() -> [Artist]
//    func getArtistIndex(name: String) -> Int
//    func removeArtist(at index: Int)
//    func addArtist(_ newArtist: Artist)
//    func getTopTracks(artistName: String) -> [Song]
//}
//
//extension MainScreenViewModel: MainScreenViewModelFunctionable {
//    func getArtistIndex(name: String) -> Int {
//        let mainScreenRepository: MainScreenRepositoryFunctionable = MainScreenRepository()
//        var artistIndex = -1
//        mainScreenRepository.getSelectedArtistIndex(name: name, completing: {(index) in
//            artistIndex = index
//        })
//        return artistIndex
//    }
//    func removeArtist(at index: Int) {
//        let mainScreenRepository: MainScreenRepositoryFunctionable = MainScreenRepository()
//        mainScreenRepository.removeSelectedArtist(at: index)
//    }
//
//    func addArtist(_ newArtist: Artist) {
//        let mainScreenRepository: MainScreenRepositoryFunctionable = MainScreenRepository()
//        mainScreenRepository.addArtist(newArtist)
//    }
//
//    func getFavouriteList() -> [Artist] {
//        let mainScreenRepository: MainScreenRepositoryFunctionable = MainScreenRepository()
//        var favArtists: [Artist] = []
//        mainScreenRepository.favouriteArtistList(completing: {(artists) in
//            favArtists = artists
//        })
//        return favArtists
//    }
//
//    func getTopTracks(artistName: String) -> [Song] {
//        let mainScreenRepository: MainScreenRepositoryFunctionable = MainScreenRepository()
//        var  topSongs: [Song] = []
//        mainScreenRepository.topTracksList(artistName: artistName, completing: {(songs) in
//            topSongs = songs
//        })
//        return topSongs
//    }
//
//}
