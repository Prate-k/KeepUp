//
//  SongsRepositoryExtensions.swift
//  KeepUp
//
//  Created by Prateek Kambadkone on 2019/03/17.
//  Copyright © 2019 Prateek Kambadkone. All rights reserved.
//

import Foundation

protocol SongsRepositoryFunctionable {
    func getAlbumFromSource(artistName: String, albumName: String, completing: @escaping (Album) -> Void)
    func getArtistFromSource(artistAt: Int, completing: @escaping (Artist) -> Void)
}

extension SongsRepository: SongsRepositoryFunctionable {
    func getAlbumFromSource(artistName: String, albumName: String, completing: @escaping (Album) -> Void) {
        if let artist = FavouriteArtists.getArtist(by: artistName) {
            if !artist.artistAlbums.isEmpty && !albumName.isEmpty {
                var index = -1
                for album in artist.artistAlbums {
                    index += 1
                    if album.albumName.elementsEqual(albumName) {
                        break
                    }
                }
                completing(artist.artistAlbums[index])
            }
        }
    }
    
    func getArtistFromSource(artistAt: Int, completing: @escaping (Artist) -> Void) {
        if let artist = FavouriteArtists.getArtist(at: artistAt) {
            completing(artist)
        }
    }
}
