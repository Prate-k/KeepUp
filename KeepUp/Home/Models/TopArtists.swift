//
//  topArtists.swift
//  KeepUp
//
//  Created by Prateek Kambadkone on 2019/04/27.
//  Copyright © 2019 Prateek Kambadkone. All rights reserved.
//

import Foundation

struct TopArtist: Codable {
    var artistID: Int?
    var artistName: String?
    var artistThumbnail: String?
    var chartPosition: Int?
    
    enum CodingKeys: String, CodingKey {
        case artistID = "id"
        case artistName = "name"
        case artistThumbnail = "picture_medium"
        case chartPosition = "position"
    }
}

struct TopArtists: Codable {
    var results: [TopArtist]
    
    enum CodingKeys: String, CodingKey {
        case results = "data"
    }
    
    func get(i: Int) -> TopArtist? {
        if i < results.count {
            return results[i]
        }
        return nil
    }
    
    func count() -> Int {
        return results.count
    }
    
    mutating func removeAll() {
        for i in 0..<results.count {
            if i < results.count {
                results.remove(at: i)
            }
        }
    }
}
