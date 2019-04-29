//
//  Song.swift
//  KeepUp
//
//  Created by Prateek Kambadkone on 2019/03/05.
//  Copyright © 2019 Prateek Kambadkone. All rights reserved.
//

import Foundation

//struct Song {
//    var songTitle: String
//    var songLyrics: String
//    var songLength: String
//    var isHidden: Bool = false
//}


struct Song: Codable {
    var songID: Int?
    var songName: String?
    var songLength: Int?
    var songLengthText: String = ""
    
    enum CodingKeys: String, CodingKey {
        case songID = "id"
        case songName = "title_short"
        case songLength = "duration"
    }
    
    mutating func setLengthInMinutes(seconds: String) {
        songLengthText = seconds
    }
}

struct Songs: Codable {
    var results: [Song]
    
    enum CodingKeys: String, CodingKey {
        case results = "data"
    }
    
    func get(i: Int) -> Song? {
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
