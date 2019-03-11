//
//  Album.swift
//  KeepUp
//
//  Created by Prateek Kambadkone on 2019/03/05.
//  Copyright © 2019 Prateek Kambadkone. All rights reserved.
//

import Foundation

struct Album {
    var albumName: String
    var albumReleaseDate: ReleasedDate
    var albumArtUrl: String
    var albumTracks: [Song]
}
