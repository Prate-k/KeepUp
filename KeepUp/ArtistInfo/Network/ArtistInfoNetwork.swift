//
//  ArtistInfoNetwork.swift
//  KeepUp
//
//  Created by Prateek Kambadkone on 2019/03/22.
//  Copyright © 2019 Prateek Kambadkone. All rights reserved.
//

import Foundation

protocol ArtistInfoNetworkProtocol: class {
    var repositoryDelegate: ArtistInfoRepositoryProtocol? { get set}
    func getDataFromNetwork()
}

class ArtistInfoNetwork: Networker, ArtistInfoNetworkProtocol {
    
    var repositoryDelegate: ArtistInfoRepositoryProtocol?
    
    func notifyRepository(result: Result<[String]>) {
        switch result {
        case .success(let data):
            repositoryDelegate?.dataReady(result: Result.success(data))
        case .failure(let error):
            repositoryDelegate?.dataReady(result: Result.failure(error))
        }
    }

    var artistName: String? = ""
    init(site: String, query: [String], requestType: RequestType) {
        if let last = query.last {
            let tempArtistName = extractValue(query: last)
            var q = query.reduce("", {
                var a = $1
                if $1.contains(tempArtistName) {
                    a = $1.replacingOccurrences(of: " ", with: "_")
                }
                return "\($0)&\(a)"
            })
            if q.hasPrefix("&") {
                q.remove(at: q.startIndex)
            }
            super.init(site: site, query: q, requestType: requestType)
            artistName = tempArtistName
        } else {
            super.init(site: site, query: "", requestType: requestType)
        }
    }
    
    func getDataFromNetwork() {
        super.send(completion: { (data) in
            if let data = data {
            do {
                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                        if let query = json["query"] as? [String: Any] {
                            if let pages = query["pages"] as? [String: Any] {
                                if let artistName = self.artistName {
                                    let contents = searchStringsJSON(json: pages, searchString: artistName)
                                    for string in contents {
                                        if string.contains(artistName) && string.contains("genre") {
                                            let content = HTMLParser.parseHTMLContent(content: string)
                                            self.notifyRepository(result: Result.success(content))
                                            return
                                        }
                                    }
                                    self.notifyRepository(result: Result.failure(Errors.NetworkError) )
                                }
                            }
                        }
                    }
                } catch let error {
                    print(error.localizedDescription)
                }
            } else {
                self.notifyRepository(result: Result.failure(Errors.NetworkError))
            }
        })
    }
}
