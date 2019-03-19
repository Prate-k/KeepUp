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
    func setSelectedArtist(artist: Artist)
}

extension SongsViewController: SongsListFetching {
    
    func loadLyricsScreen(lyricsViewController: LyricsViewController) {
        if let selectedArtist = selectedArtist {
            lyricsViewController.artistName = selectedArtist.artistName
        }
        lyricsViewController.songTitle = selectedSongTitle
    }
    
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
    
    func setSelectedArtist(artist: Artist) {
        selectedArtist = artist
    }
}
