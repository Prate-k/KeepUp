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
    
    var repositoryDelegate: LyricsRepositoryProtocol?
    
    func notifyRepository(result: Result<String>) {
        switch result {
        case .success(let data):
            repositoryDelegate?.dataReady(result: Result.success(data))
        case .failure(let error):
            repositoryDelegate?.dataReady(result: Result.failure(error))
        }
    }
    
    init(site: String, query: [String], requestType: RequestType) {
        var q = query.reduce("", {
            return "\($0)&\($1)"
        })
        if q.hasPrefix("&") {
            q.removeFirst()
        }
        super.init(site: site, query: q, requestType: requestType)
    }
    
    func getDataFromNetwork() {
//        let exampleWords = """
//                            lyrics... lyrics, Lyrics \t lyrics, \n lyrics
//                            \n\n Lyrics
//                            """
//        let exampleCopyright = "random guy"
//        let exampleSongTitle = "example stuff"
//        let exampleArtistName = "that person"
//        let exampleUrlLink = "none yet"
//        let contents = [exampleWords, exampleCopyright, exampleSongTitle, exampleArtistName, exampleUrlLink]
//        self.notifyRepository(result: Result.success(contents))
//        For network api: use ->
        super.send(completion: { (data) in
            if let data = data {
                do {
//                    let content = try JSONDecoder().decode(Lyrics.self, from: data)
//                    self.notifyRepository(result: Result.success(content))
                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                        if let query = json["message"] as? [String:Any] {
                            if let pages = query["body"] as? [String:Any] {
                                if let page = pages["lyrics"] as? [String:Any] {
                                    if let revisions = page["lyrics_body"] as? String {
                                        self.notifyRepository(result: Result.success(revisions))
                                    }
                                }
                            }
                        }
                    }
                } catch let error {
                    print(error.localizedDescription)
                }
            } else {
                self.notifyRepository(result: Result.failure(Errors.NetworkError) )
            }
        })
    }
    
}
