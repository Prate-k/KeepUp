//
//  LyricsModel.swift
//  KeepUp
//
//  Created by Prateek Kambadkone on 2019/03/24.
//  Copyright © 2019 Prateek Kambadkone. All rights reserved.
//

import Foundation

struct Lyrics: Codable {
    let message: Message?
}

struct Message: Codable {
    let header: Header?
    let body: Body?
}

struct Body: Codable {
    let lyrics: LyricsClass?
}

struct LyricsClass: Codable {
    let lyricsID, explicit: Int?
    let lyricsBody: String?
    let scriptTrackingURL, pixelTrackingURL: String?
    let lyricsCopyright: String?
    let updatedTime: Date?
    
    enum CodingKeys: String, CodingKey {
        case lyricsID = "lyrics_id"
        case explicit
        case lyricsBody = "lyrics_body"
        case scriptTrackingURL = "script_tracking_url"
        case pixelTrackingURL = "pixel_tracking_url"
        case lyricsCopyright = "lyrics_copyright"
        case updatedTime = "updated_time"
    }
}

struct Header: Codable {
    let statusCode: Int?
    let executeTime: Double?
    
    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case executeTime = "execute_time"
    }
}






