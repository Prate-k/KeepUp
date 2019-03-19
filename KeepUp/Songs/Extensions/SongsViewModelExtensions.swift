//
//  SongsViewModelExtensions.swift
//  KeepUp
//
//  Created by Prateek Kambadkone on 2019/03/17.
//  Copyright © 2019 Prateek Kambadkone. All rights reserved.
//

import Foundation

protocol SongsViewModelFunctionable: class {
    func getAlbum(of artistAt: Int, in albumAt: Int)
    func getArtist(at: Int)
}

extension SongsViewModel: SongsViewModelFunctionable {
    func getAlbum(of artistAt: Int, in albumAt: Int) {
        let songsRepository: SongsRepositoryFunctionable = SongsRepository()
        _ = songsRepository.getAlbumFromSource(artistAt: artistAt, albumAt: albumAt, completing: {(album) in
            self.songsViewController?.showSelectedAlbum(album: album)
            self.songsViewController?.songsListShow(songs: album.albumTracks)
        })
    }
    
    func getArtist(at: Int) {
        let songsRepository: SongsRepositoryFunctionable = SongsRepository()
        _ = songsRepository.getArtistFromSource(artistAt: at, completing: {(artist) in
            self.songsViewController?.setSelectedArtist(artist: artist)
        })
    }
}
