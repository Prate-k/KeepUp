//
//  LyricsViewControllerExtensions.swift
//  KeepUp
//
//  Created by Prateek Kambadkone on 2019/03/18.
//  Copyright © 2019 Prateek Kambadkone. All rights reserved.
//

import Foundation

protocol SongLyricsFetching: class {
    func displayLyrics(for song: Song)
    func setSongTitle(songTitle: String)
    func setArtist(artistName: String)
}

extension LyricsViewController: SongLyricsFetching {
    
    func setSongTitle(songTitle: String) {
        DispatchQueue.main.async {
            self.songTitleLabel.text = songTitle
        }
    }
    
    func setArtist(artistName: String) {
        DispatchQueue.main.async {
            self.artistNameLabel.text = artistName
        }
    }
    
    func displayLyrics(for song: Song) {
        DispatchQueue.main.async {
            self.lyricsTextView.text = song.songLyrics
        }
    }
    
}
