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

    required init(site: String, query: String, requestType: RequestType) {
        super.init(site: site, query: query, requestType: requestType)
    }
    
    func getDataFromNetwork() {
        super.send(completion: { (data) in
            if let data = data {
            do {
                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                        if let query = json["query"] as? [String: Any] {
                            if let pages = query["pages"] as? [String: Any] {
                                if let a = pages.first {
                                    if let page = pages[a.key] as? [String: Any] {
                                        if let revisions = page["revisions"] as? [[String: Any]] {
                                            for counter in 0..<revisions.count {
                                                if let artistData = revisions[counter]["*"] as? String {
                                                    let contents = HTMLParser.parseHTMLContent(content: artistData)
                                                    self.notifyRepository(result: Result.success(contents))
                                                }
                                            }
                                        }
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
