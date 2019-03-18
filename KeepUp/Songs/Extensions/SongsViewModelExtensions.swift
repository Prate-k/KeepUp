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
}

extension SongsViewModel: SongsViewModelFunctionable {
    func getAlbum(of artistAt: Int, in albumAt: Int) {
        let songsRepository: SongsRepositoryFunctionable = SongsRepository()
        _ = songsRepository.getAlbumFromSource(artistAt: artistAt, albumAt: albumAt, completing: {(album) in
            self.songsViewController?.showSelectedAlbum(album: album)
            self.songsViewController?.songsListShow(songs: album.albumTracks)
        })
    }
}
