//
//  ArtistInfoRepositoryExtensions.swift
//  KeepUp
//
//  Created by Prateek Kambadkone on 2019/03/06.
//  Copyright © 2019 Prateek Kambadkone. All rights reserved.
//

import Foundation

protocol ArtistInfoRepositoryProtocol: class {
    var viewModelDelegate: ArtistInfoViewModelProtocol? {get set}
    var networkDelegate: ArtistInfoNetworkProtocol? { get set }
    func getArtistDataFromSource(artistName: String)
    func dataReady(result: Result<[String]>)
}

extension ArtistInfoRepository: ArtistInfoRepositoryProtocol {
    
    func dataReady(result: Result<[String]>) {
        switch result {
        case .success(let data):
            let artistInfo = refineArtistInfo(values: data)
            notifyViewModel(result: Result.success(artistInfo))
        case .failure(let error):
            notifyViewModel(result: Result.failure(error))
        }
    }
    
    func getArtistDataFromSource(artistName: String) {
//        let searchArtistName = artistName.replacingOccurrences(of: " ", with: "_")
        let site = "https://en.wikipedia.org/w/api.php?"
        let query = ["action=query","prop=revisions", "rvprop=content", "format=json", "rvsection=0", "titles=\(artistName)"]
        if networkDelegate == nil {
            networkDelegate = ArtistInfoNetwork(site: site, query: query, requestType: .GET)
            networkDelegate?.repositoryDelegate = self
        }
        networkDelegate?.getDataFromNetwork()
    }
    
    func notifyViewModel(result: Result<ArtistInfo>) {
        viewModelDelegate?.setArtistInfoOnView(result: result)
    }
}
