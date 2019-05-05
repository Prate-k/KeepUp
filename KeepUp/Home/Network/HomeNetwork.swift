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
    func getDataFromNetwork(type: HomeDataType)
}

class HomeNetwork: Networker, HomeNetworkProtocol {
    
    var repositoryDelegate: HomeRepositoryProtocol?
    
    func notifyRepository(result: Result<Data>, type: HomeDataType) {
        switch result {
        case .success(let data):
            repositoryDelegate?.dataReady(result: Result.success(data), type: type)
        case .failure(let error):
            repositoryDelegate?.dataReady(result: Result.failure(error), type: type)
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
    
    func getDataFromNetwork(type: HomeDataType) {
//        DispatchQueue.global().async {
            super.send(completion: { (data) in
                if let data = data {
                    do {
                        self.notifyRepository(result: Result.success(data), type: type)
                    } catch let error {
                        print(error.localizedDescription)
                        self.notifyRepository(result: Result.failure(Errors.NetworkError), type: type)
                    }
                } else {
                    self.notifyRepository(result: Result.failure(Errors.NetworkError), type: type)
                }
            })
//        }
    }
}
