//
//  SongsRepositoryExtensions.swift
//  KeepUp
//
//  Created by Prateek Kambadkone on 2019/03/17.
//  Copyright © 2019 Prateek Kambadkone. All rights reserved.
//

import Foundation

protocol SongsRepositoryFunctionable {
    func getAlbumFromSource(artistAt: Int, albumAt: Int, completing: @escaping (Album) -> Void)
    func getArtistFromSource(artistAt: Int, completing: @escaping (Artist) -> Void)
}

extension SongsRepository: SongsRepositoryFunctionable {
    func getAlbumFromSource(artistAt: Int, albumAt: Int, completing: @escaping (Album) -> Void) {
        if let artist = FavouriteArtists.getArtist(at: artistAt) {
            if !artist.artistAlbums.isEmpty && albumAt < artist.artistAlbums.count {
                completing(artist.artistAlbums[albumAt])
            }
        }
    }
    
    func getArtistFromSource(artistAt: Int, completing: @escaping (Artist) -> Void) {
        if let artist = FavouriteArtists.getArtist(at: artistAt) {
            completing(artist)
        }
    }
}
