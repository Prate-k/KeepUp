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
    func getPopularSongsFromSource()
    func dataReady(result: Result<Data>, type: HomeDataType)
}

extension HomeRepository: HomeRepositoryProtocol {
    
    func dataReady(result: Result<Data>, type: HomeDataType) {
        switch result {
        case .success(let data):
            do {
                switch type {
                case .TopArtists:
                    let content = try JSONDecoder().decode(TopArtists.self, from: data)
                    notifyViewModel(result: Result.success(content))
                case .PopularSongs:
                    let content = try JSONDecoder().decode(PopularSongs.self, from: data)
                    notifyViewModel(result: Result.success(content))
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
        self.networkDelegate?.getDataFromNetwork(type: HomeDataType.TopArtists)
    }
    
    func getPopularSongsFromSource() {

        let filter = "tracks/"
        let site = "https://api.deezer.com/chart/0/\(filter)"
        let query = [""]
        self.networkDelegate = HomeNetwork(site: site, query: query, requestType: .GET)
        self.networkDelegate?.repositoryDelegate = self
        self.networkDelegate?.getDataFromNetwork(type: HomeDataType.PopularSongs)
    }
    
    func notifyViewModel(result: Result<TopArtists>) {
        viewModelDelegate?.updateTopArtistsOnView(result: result)
    }
    
    func notifyViewModel(result: Result<PopularSongs>) {
        viewModelDelegate?.updatePopularSongsOnView(result: result)
    }
    
    func notifyErrorToViewModel(error: Errors) {
        
    }
}
