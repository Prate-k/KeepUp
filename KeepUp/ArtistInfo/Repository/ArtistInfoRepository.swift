//
//  ArtistInfoRepository.swift
//  KeepUp
//
//  Created by Prateek Kambadkone on 2019/03/05.
//  Copyright © 2019 Prateek Kambadkone. All rights reserved.
//

import Foundation

class ArtistInfoRepository {
    func refineArtistInfo(values: [String]) -> ArtistInfo {
        var details = ArtistInfo (origin: "",genres: "",members: "", isSolo: false)
        let type = values[0]
        let origin = values[1]
        let birthPlace = values[2]
        let genre = values[3]
        let members = values[4]
        
        if type.contains("group_or_band") {
            details.isSolo = false
            if members.contains("*") {
                var values = members.split(separator: "*")
                for counter in 1..<values.count {
                    details.members.append(HTMLParser.removeHTMLTags(content: String(values[counter])))
                }
            }
            if !origin.isEmpty {
                var values = origin.split(separator: "=")
                details.origin.append(HTMLParser.removeHTMLTags(content: String(values[1])))
            } else {
                details.origin = "N/A"
            }
        } else {
            details.members = ""
            
            details.isSolo = true
            if !birthPlace.isEmpty {
                var values = birthPlace.split(separator: "=")
                details.origin.append(HTMLParser.removeHTMLTags(content: String(values[1])))
            } else {
                details.origin = "N/A"
            }
        }
        if genre.contains("*") {
            var values = genre.split(separator: "*")
            for counter in 1..<values.count {
                let value = HTMLParser.removeHTMLTags(content: String(values[counter]))
                if !value.isEmpty {
                    details.genres.append(value)
                }
            }
        } else {
            if !genre.isEmpty {
                var values = genre.split(separator: "=")
                details.genres.append(HTMLParser.removeHTMLTags(content: String(values[1])))
            } else {
                details.genres = "N/A"
            }
        }
        return details
    }
}


