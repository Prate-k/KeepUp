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
                case .PopularSongs:
                    let content = try JSONDecoder().decode(PopularSongs.self, from: data)
                    if let popularSong = content.get(i: 0) {
                         notifyViewModel(result: Result.success(popularSong), artistRank: artistRank)
                    }
                }
            } catch _ {
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
