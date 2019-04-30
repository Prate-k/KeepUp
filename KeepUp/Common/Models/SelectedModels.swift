//
//  SegueData.swift
//  KeepUp
//
//  Created by Prateek Kambadkone on 2019/04/28.
//  Copyright © 2019 Prateek Kambadkone. All rights reserved.
//

import Foundation


struct SelectedArtist {
    var artistID: Int!
    var artistName: String!
    var artistImage: String!
}

struct SelectedAlbum {
    var albumID: Int!
    var albumName: String!
    var albumImage: String!
    var artistName: String!
}

struct SelectedSong {
    var album: SelectedAlbum!
    var songName: String!
}
