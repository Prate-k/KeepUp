//
//  MainScreenRepositoryExtensions.swift
//  KeepUp
//
//  Created by Prateek Kambadkone on 2019/03/18.
//  Copyright © 2019 Prateek Kambadkone. All rights reserved.
//

import Foundation

protocol HomeRepositoryProtocol: class {
    var viewModelDelegate: HomeViewModelProtocol? {get set}
    var networkDelegate: HomeNetworkProtocol? { get set }
    func getTopArtistsFromSource()
    func getPopularSongsFromSource(artistID: Int, artistRank: Int)
    func dataReady(result: Result<Data>, type: HomeDataType, artistRank: Int)
}

extension HomeRepository: HomeRepositoryProtocol {
    
    
    func dataReady(result: Result<Data>, type: HomeDataType, artistRank: Int) {
        switch result {
        case .success(let data):
            do {
                switch type {
                case .TopArtists:
                    let content = try JSONDecoder().decode(TopArtists.self, from: data)
                    notifyViewModel(result: Result.success(content))
//                case .SimilarArtists:
//                    let content = try JSONDecoder().decode(SimilarArtists.self, from: data)
//                    notifyViewModel(result: Result.success(content))
                case .PopularSongs:
                    let content = try JSONDecoder().decode(PopularSongs.self, from: data)
                    if let popularSong = content.get(i: 0) {
                         notifyViewModel(result: Result.success(popularSong), artistRank: artistRank)
                    }
                }
            } catch let error {
                let err: Errors = .NetworkError
                notifyErrorToViewModel(error: err)
            }
        case .failure(let error):
            notifyErrorToViewModel(error: error)
        }
    }
    
    func getTopArtistsFromSource() {
        let filter = "artists"
        let site = "https://api.deezer.com/chart/0/\(filter)"
        let query = [""]
        self.networkDelegate = HomeNetwork(site: site, query: query, requestType: .GET)
        self.networkDelegate?.repositoryDelegate = self
        self.networkDelegate?.getDataFromNetwork(type: HomeDataType.TopArtists, rank: -1)
    }
    
    func getPopularSongsFromSource(artistID: Int, artistRank: Int) {
        let filter = "artist/\(artistID)/top"
        let site = "https://api.deezer.com/\(filter)?"
        let query = ["limit=1"]
        self.networkDelegate = HomeNetwork(site: site, query: query, requestType: .GET)
        self.networkDelegate?.repositoryDelegate = self
        self.networkDelegate?.getDataFromNetwork(type: HomeDataType.PopularSongs, rank: artistRank)
    }
    
    func notifyViewModel(result: Result<TopArtists>) {
        viewModelDelegate?.updateTopArtistsOnView(result: result)
    }
    
    func notifyViewModel(result: Result<PopularSong>, artistRank: Int) {
        viewModelDelegate?.updatePopularSongsOnView(result: result, artistRank: artistRank)
    }
    
    func notifyErrorToViewModel(error: Errors) {
        
    }
}









//protocol HomeRepositoryFunctionable {
//    func favouriteArtistList(completing: @escaping ([Artist]) -> Void)
//    func getSelectedArtist(at index: Int, completing: @escaping (Artist) -> Void)
//    func getSelectedArtistIndex(name: String, completing: @escaping (Int) -> Void)
//    func removeSelectedArtist(at index: Int)
//    func addArtist(_ newArtist: Artist)
//    func topTracksList(artistName: String, completing: @escaping ([Song]) -> Void)
//}
//
//extension HomeRepository: HomeRepositoryFunctionable {
//    func favouriteArtistList(completing: @escaping ([Artist]) -> Void) {
//        if !FavouriteArtists.isEmpty() {
//            completing(FavouriteArtists.getList())
//        }
//    }
//
//    func topTracksList(artistName: String, completing: @escaping ([Song]) -> Void) {
//        if !FavouriteArtists.isEmpty() {
//            if let artist = FavouriteArtists.getArtist(by: artistName) {
//                let index = Int.random(in: 0..<artist.artistAlbums.count)
//                completing(artist.artistAlbums[index].albumTracks)
//            }
//        }
//    }
//
//    func getSelectedArtistIndex(name: String, completing: @escaping (Int) -> Void) {
//        if !name.isEmpty {
//            completing(FavouriteArtists.isArtistInFavouriteList(name: name))
//        }
//    }
//
//    func getSelectedArtist(at index: Int, completing: @escaping (Artist) -> Void) {
//        if index >= 0 {
//            if let artist = FavouriteArtists.getArtist(at: index) {
//                completing(artist)
//            }
//        }
//    }
//    func removeSelectedArtist(at index: Int) {
//        FavouriteArtists.removeArtist(at: index)
//    }
//    func addArtist(_ newArtist: Artist) {
//        FavouriteArtists.addArtist(artist: newArtist)
//    }
//}
