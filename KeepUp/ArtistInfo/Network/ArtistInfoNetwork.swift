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
        var tempArtistName = String((query.last?.split(separator: "=").last)!)
        let q = query.reduce("", {
            var a = $1
            if $1.contains(tempArtistName) {
                a = $1.replacingOccurrences(of: " ", with: "_")
            }
            return "\($0)&\(a)"
        })
        super.init(site: site, query: q, requestType: requestType)
        artistName = tempArtistName
    }
    
    func getDataFromNetwork() {
        super.send(completion: { (data) in
            if let data = data {
            do {
                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                        if let query = json["query"] as? [String: Any] {
                            print(query)
                            let contents = searchStringsJSON(json: query, searchString: self.artistName!)
                            print(contents)
                            for string in contents {
                                let check = string.contains(self.artistName!) && string.contains("genre")
                                if check {
                                    self.notifyRepository(result: Result.success(HTMLParser.parseHTMLContent(content: string)))
                                    return
                                } else {
                                    self.notifyRepository(result: Result.failure(Errors.NetworkError))
                                    return
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
