//
//  Artist.swift
//  KeepUp
//
//  Created by Prateek Kambadkone on 2019/02/13.
//  Copyright © 2019 Prateek Kambadkone. All rights reserved.
//

import Foundation
import UIKit

struct Date {
    var month: String
    var year: Int
}

struct Album {
    var albumName: String
    var released: Date
    var albumArt: UIImage
    var songs: [Song]
}

struct Song {
    var songTitle: String
    var lyrics: String
    var length: String
}

class Artist {
    
    var name: String!
    var genre: String!
    var image: UIImage!
    
    
    
    var albums: [Album] = []
    
    
    required init!(name: String!, genre: String!, image: UIImage!)
    {
        guard name != nil || genre != nil || image != nil else {
            return nil
        }
        self.name = name
        self.genre = genre
        self.image = image
    }
    
    convenience init(name: String!, genre: String!, image: UIImage!, albums: [Album]) {
        self.init(name: name, genre: genre, image: image)
        self.albums = albums
    }
}
