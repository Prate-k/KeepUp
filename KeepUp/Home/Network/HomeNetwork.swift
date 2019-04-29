//
//  HomeNetwork.swift
//  KeepUp
//
//  Created by Prateek Kambadkone on 2019/04/27.
//  Copyright © 2019 Prateek Kambadkone. All rights reserved.
//

import Foundation

protocol HomeNetworkProtocol: class {
    var repositoryDelegate: HomeRepositoryProtocol? { get set}
    func getDataFromNetwork(type: HomeDataType, rank: Int)
}

class HomeNetwork: Networker, HomeNetworkProtocol {
    
    var repositoryDelegate: HomeRepositoryProtocol?
    
    func notifyRepository(result: Result<Data>, type: HomeDataType, rank: Int) {
        switch result {
        case .success(let data):
            repositoryDelegate?.dataReady(result: Result.success(data), type: type, artistRank: rank)
        case .failure(let error):
            repositoryDelegate?.dataReady(result: Result.failure(error), type: type, artistRank: -1)
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
    
    func getDataFromNetwork(type: HomeDataType, rank: Int) {
        DispatchQueue.global().async {
            super.send(completion: { (data) in
                if let data = data {
                    do {
//                        let content = try JSONDecoder().decode(SearchResults.self, from: data)
                        self.notifyRepository(result: Result.success(data), type: type, rank: rank)
                    } catch let error {
                        print(error.localizedDescription)
                        self.notifyRepository(result: Result.failure(Errors.NetworkError), type: type, rank: -1)
                    }
                } else {
                    self.notifyRepository(result: Result.failure(Errors.NetworkError), type: type, rank: -1)
                }
            })
        }
    }
}

