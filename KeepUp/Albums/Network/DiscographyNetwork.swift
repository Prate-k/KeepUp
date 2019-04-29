//
//  DiscographyNetwork.swift
//  KeepUp
//
//  Created by Prateek Kambadkone on 2019/04/28.
//  Copyright © 2019 Prateek Kambadkone. All rights reserved.
//

import Foundation

protocol DiscographyNetworkProtocol: class {
    var repositoryDelegate: DiscographyRepositoryProtocol? { get set}
    func getDataFromNetwork()
}

class DiscographyNetwork: Networker, DiscographyNetworkProtocol {
    
    var repositoryDelegate: DiscographyRepositoryProtocol?
    
    func notifyRepository(result: Result<Albums>) {
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
        DispatchQueue.global().async {
            super.send(completion: { (data) in
                if let data = data {
                    do {
                        let content = try JSONDecoder().decode(Albums.self, from: data)
                        self.notifyRepository(result: Result.success(content))
                    } catch let error {
                        print(error.localizedDescription)
                        self.notifyRepository(result: Result.failure(Errors.NetworkError))
                    }
                } else {
                    self.notifyRepository(result: Result.failure(Errors.NetworkError))
                }
            })
        }
    }
}
