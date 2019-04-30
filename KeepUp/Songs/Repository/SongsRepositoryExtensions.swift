//
//  SongsRepositoryExtensions.swift
//  KeepUp
//
//  Created by Prateek Kambadkone on 2019/03/17.
//  Copyright © 2019 Prateek Kambadkone. All rights reserved.
//

import Foundation

protocol SongsRepositoryProtocol: class {
    var viewModelDelegate: SongsViewModelProtocol? {get set}
    func dataReady(result: Result<Songs>)
    func getSongs(from albumID: Int)
}

extension SongsRepository: SongsRepositoryProtocol {
    
    func dataReady(result: Result<Songs>) {
        switch result {
        case .success(let album):
            viewModelDelegate?.updateSelectedAlbum(result: Result.success(album))
        case .failure(let error):
            viewModelDelegate?.updateSelectedAlbum(result: Result.failure(error))
        }
    }
    
    func getSongs(from albumID: Int) {
        let filter = "\(albumID)/tracks"
        let site = "https://api.deezer.com/album/\(filter)"
        let query = [""]
        
        self.networkDelegate = SongsNetwork(site: site, query: query, requestType: .GET)
        self.networkDelegate?.repositoryDelegate = self
        self.networkDelegate?.getDataFromNetwork()
    }
}
