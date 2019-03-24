//
//  LyricsNetwork.swift
//  KeepUp
//
//  Created by Prateek Kambadkone on 2019/03/24.
//  Copyright © 2019 Prateek Kambadkone. All rights reserved.
//

import Foundation

protocol LyricsNetworkProtocol: class {
    var repositoryDelegate: LyricsRepositoryProtocol? { get set}
    func getDataFromNetwork()
}

class LyricsNetwork: Networker, LyricsNetworkProtocol {
    
    weak var repositoryDelegate: LyricsRepositoryProtocol?
    
    func notifyRepository(result: Result<[String]>) {
        switch result {
        case .success(let data):
            repositoryDelegate?.dataReady(result: Result.success(data))
        case .failure(let error):
            repositoryDelegate?.dataReady(result: Result.failure(error))
        }
    }
    
    required init(site: String, query: String, requestType: RequestType) {
        super.init(site: site, query: query, requestType: requestType)
        //make network call to musicxmatch api to get lyrics
    }
    
    func getDataFromNetwork() {
        let exampleWords = """
                            lyrics... lyrics, Lyrics \t lyrics, \n lyrics
                            \n\n Lyrics
                            """
        let exampleCopyright = "random guy"
        let exampleSongTitle = "example stuff"
        let exampleArtistName = "that person"
        let exampleUrlLink = "none yet"
        let contents = [exampleWords, exampleCopyright, exampleSongTitle, exampleArtistName, exampleUrlLink]
        self.notifyRepository(result: Result.success(contents))
        
//        super.send(completion: { (data) in
//            if let data = data {
//                do {
                    //data from network json object extracting data
//                } catch let error {
//                    print(error.localizedDescription)
//                }
//            } else {
//                self.notifyRepository(result: Result.failure(Errors.NetworkError) )
//            }
//        })
    }
}
