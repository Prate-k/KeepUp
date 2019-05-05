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
    func getPopularSongsFromRepository()
    func updateTopArtistsOnView(result: Result<TopArtists>)
    func updatePopularSongsOnView(result: Result<PopularSongs>)
}

extension HomeViewModel: HomeViewModelProtocol {
    
    func updatePopularSongsOnView(result: Result<PopularSongs>) {
        switch result {
        case .success(let data):
            self.viewControllerDelegate?.updatePopularSongs(results: data)
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
    
    func getPopularSongsFromRepository() {
        repositoryDelegate?.getPopularSongsFromSource()
    }
}
