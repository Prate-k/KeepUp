//
//  SongsViewControllerExtensions.swift
//  KeepUp
//
//  Created by Prateek Kambadkone on 2019/03/17.
//  Copyright © 2019 Prateek Kambadkone. All rights reserved.
//

import Foundation
import UIKit

protocol SongsListFetching: class {
    func songsListShow(songs: [Song])
    func showSelectedAlbum(album: Album)
}

extension SongsViewController: SongsListFetching {
    
    func showSelectedAlbum(album: Album) {
        selectedAlbum = album
        DispatchQueue.main.async {
            self.albumName.text = album.albumName
            self.releaseDate.text = """
                    \(album.albumReleaseDate.releasedMonth)
                    \(album.albumReleaseDate.releasedYear)
                    """
            self.albumImageView.image = UIImage(named: "dummyAlbum")
        }
    }
    
    func songsListShow(songs: [Song]) {
        songsList = songs
        DispatchQueue.main.async {
            self.songsListTableView.reloadData()
        }
    }
}
