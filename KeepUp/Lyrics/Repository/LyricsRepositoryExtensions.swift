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
    func getSongLyricsFromDataSource(artistName: String, albumName: String, songTitle: String)
    func dataReady(result: Result<String>)
}

extension LyricsRepository: LyricsRepositoryProtocol {
    
    func dataReady(result: Result<String>) {
        switch result {
        case .success(let data):
            viewModelDelegate?.setLyricsOnView(result: Result.success(data))
        case .failure(let error):
            viewModelDelegate?.setLyricsOnView(result: Result.failure(error))
        }
    }
    
    func getSongLyricsFromDataSource(artistName: String, albumName: String, songTitle: String) {
        if artistName.isEmpty || songTitle.isEmpty {
            dataReady(result: Result.failure(Errors.InvalidInput))
        } else {
            let site = "https://api.musixmatch.com/ws/1.1/matcher.lyrics.get?"
            let query = ["q_track=\(songTitle.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed)!)", "q_artist=\(artistName.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed)!)", "apikey=\(getAPIKey())"]
    
            if networkDelegate == nil {
                networkDelegate = LyricsNetwork(site: site, query: query, requestType: .GET)
                networkDelegate?.repositoryDelegate = self
            }
            networkDelegate?.getDataFromNetwork()
        }
    }
    
    func getAPIKey() -> String {
        if  let path = Bundle.main.path(forResource: "APIKeys", ofType: "plist"),
            let xml = FileManager.default.contents(atPath: path),
            let key = try? PropertyListDecoder().decode(API.self, from: xml)
        {
            return key.MusixMatchAPIKey
        }
        return ""
    }
}
