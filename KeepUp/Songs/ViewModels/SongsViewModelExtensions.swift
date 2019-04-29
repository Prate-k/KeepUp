//
//  SongsViewModelExtensions.swift
//  KeepUp
//
//  Created by Prateek Kambadkone on 2019/03/17.
//  Copyright © 2019 Prateek Kambadkone. All rights reserved.
//

import Foundation

protocol SongsViewModelFunctionable: class {
    func getAlbum(of artistName: String, in albumName: String)
}

extension SongsViewModel: SongsViewModelObjCFunctionable {
    func getAlbum(_ artistName: String, _ albumName: String) {
        let songsRepository: SongsRepositoryFunctionable = SongsRepository()
        _ = songsRepository.getAlbumFromSource(artistName: artistName, albumName: albumName, completing: {(album) in
            self.songsViewController?.showSelectedAlbum(album: album)
//            self.songsViewController?.songsListShow(songs: album.albumTracks)
        })
    }
}
