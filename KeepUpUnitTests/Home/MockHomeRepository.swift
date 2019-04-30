//
//  MockHomeRepository.swift
//  KeepUpUnitTests
//
//  Created by Prateek Kambadkone on 2019/04/30.
//  Copyright © 2019 Prateek Kambadkone. All rights reserved.
//

import Foundation
@testable import KeepUp

class MockHomeRepository: HomeRepositoryProtocol {
    var viewModelDelegate: HomeViewModelProtocol?
    
    var networkDelegate: HomeNetworkProtocol?

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
            } catch let error {
                let err: Errors = .NetworkError
                notifyErrorToViewModel(error: err)
            }
        case .failure(let error):
            notifyErrorToViewModel(error: error)
        }
    }
    
    func getTopArtistsFromSource() {
//        var songs: [Song] = []
//        for index in 0..<3 {
//            songs.append(Song(songID: index, songName: "Song\(index)", songLength: (index)*60, songLengthText: ""))
//        }
//        dataReady(result: Result.success(Songs(results: songs)))
    }
    
    func getPopularSongsFromSource(artistID: Int, artistRank: Int) {
//        let filter = "artist/\(artistID)/top"
//        let site = "https://api.deezer.com/\(filter)?"
//        let query = ["limit=1"]
//        self.networkDelegate = HomeNetwork(site: site, query: query, requestType: .GET)
//        self.networkDelegate?.repositoryDelegate = self
//        self.networkDelegate?.getDataFromNetwork(type: HomeDataType.PopularSongs, rank: artistRank)
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
