//
//  SearchResult.swift
//  KeepUp
//
//  Created by Prateek Kambadkone on 2019/04/20.
//  Copyright © 2019 Prateek Kambadkone. All rights reserved.
//

import Foundation

struct SearchResult: Codable {
    var artistID: Int?
    var artistName: String?
    var artistThumbnail: String?
    
    enum CodingKeys: String, CodingKey {
        case artistID = "id"
        case artistName = "name"
        case artistThumbnail = "picture_medium"
    }
}

struct SearchResults: Codable {
    var results: [SearchResult]
    
    enum CodingKeys: String, CodingKey {
        case results = "data"
    }
    
    func get(i: Int) -> SearchResult? {
        if i < results.count {
            return results[i]
        }
        return nil
    }
    
    func count() -> Int {
        return results.count
    }
    mutating func removeAll() {
        for i in 0..<results.count where i < results.count {
            results.remove(at: i)
        }
    }
}
