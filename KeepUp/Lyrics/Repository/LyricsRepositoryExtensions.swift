//
//  LyricsRepositoryExtensions.swift
//  KeepUp
//
//  Created by Prateek Kambadkone on 2019/03/18.
//  Copyright © 2019 Prateek Kambadkone. All rights reserved.
//

import Foundation

protocol LyricsRepositoryProtocol: class {
    var viewModelDelegate: LyricsViewModelProtocol? {get set}
    var networkDelegate: LyricsNetworkProtocol? { get set }
    func getSongLyricsFromDataSource(artistName: String, songTitle: String)
    func dataReady(result: Result<[String]>)
}

extension LyricsRepository: LyricsRepositoryProtocol {
    
    func dataReady(result: Result<[String]>) {
        switch result {
        case .success(let data):
            let lyrics = Lyrics(words: data[0], copyright: data[1], songTitle: data[2], artistName: data[3], urlLink: data[4])
            viewModelDelegate?.setLyricsOnView(result: Result.success(lyrics))
        case .failure(let error):
            viewModelDelegate?.setLyricsOnView(result: Result.failure(error))
        }
    }
    
    func getSongLyricsFromDataSource(artistName: String, songTitle: String) {
        if artistName.isEmpty || songTitle.isEmpty {
            dataReady(result: Result.failure(Errors.InvalidInput))
        } else {
            let site = "www.dummyurl.com/"
            let query = "useParametersBasedOnParameters"
            if networkDelegate == nil {
                networkDelegate = LyricsNetwork(site: site, query: query, requestType: .GET)
                networkDelegate?.repositoryDelegate = self
            }
            networkDelegate?.getDataFromNetwork()
        }
    }
}
