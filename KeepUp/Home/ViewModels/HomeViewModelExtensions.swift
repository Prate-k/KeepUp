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
