//
//  Album.swift
//  KeepUp
//
//  Created by Prateek Kambadkone on 2019/03/05.
//  Copyright © 2019 Prateek Kambadkone. All rights reserved.
//

import Foundation

struct Album: Codable {
    var albumID: Int?
    var albumName: String?
    var albumCover: String?
    var genreID: Int?
    var releaseDate: String?
    
    enum CodingKeys: String, CodingKey {
        case albumID = "id"
        case albumName = "title"
        case albumCover = "cover_medium"
        case genreID = "genre_id"
        case releaseDate = "release_date"
    }
    
    mutating func setDate(date: String) {
        releaseDate = date
    }
}

struct Albums: Codable {
    var results: [Album]
    
    enum CodingKeys: String, CodingKey {
        case results = "data"
    }
    
    func get(i: Int) -> Album? {
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
