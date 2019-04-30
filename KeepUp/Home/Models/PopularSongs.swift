//
//  PopularSongs.swift
//  KeepUp
//
//  Created by Prateek Kambadkone on 2019/04/27.
//  Copyright © 2019 Prateek Kambadkone. All rights reserved.
//

import Foundation

struct PopularSong: Codable {
    var songID: Int?
    var songTitle: String?
    var album: Album?
    var artist: Artist?
    
    enum CodingKeys: String, CodingKey {
        case songID = "id"
        case songTitle = "title_short"
        case album = "album"
        case artist = "artist"
    }
    
    struct Album: Codable {
        var albumCover: String?
        var albumID: Int?
        var albumName: String?
        
        enum CodingKeys: String, CodingKey {
            case albumCover = "cover_medium"
            case albumID = "id"
            case albumName = "title"
        }
    }
    
    struct Artist: Codable {
        var artistName: String?
        
        enum CodingKeys: String, CodingKey {
            case artistName = "name"
        }
    }
}

struct PopularSongs: Codable {
    var results: [PopularSong] = []
    
    enum CodingKeys: String, CodingKey {
        case results = "data"
    }
    
    func get(i: Int) -> PopularSong? {
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
    
    mutating func set(_ song: PopularSong, at: Int) {
        results[at] = song
    }
}
