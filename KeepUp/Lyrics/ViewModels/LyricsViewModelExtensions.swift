//
//  LyricsViewModelExtensions.swift
//  KeepUp
//
//  Created by Prateek Kambadkone on 2019/03/18.
//  Copyright © 2019 Prateek Kambadkone. All rights reserved.
//

import Foundation

protocol LyricsViewModelProtocol: class {
    var viewControllerDelegate: LyricsViewControllerProtocol? { get set }
    var repositoryDelegate: LyricsRepositoryProtocol? { get set }
    func getSongLyrics(of song: SelectedSong)
    func setLyricsOnView(result: Result<String>)
}

extension LyricsViewModel: LyricsViewModelProtocol {
    
    func getSongLyrics(of song: SelectedSong) {
        repositoryDelegate?.getSongLyricsFromDataSource(artistName: song.album.artistName, albumName: song.album.albumName, songTitle: song.songName)
    }
    
    func setLyricsOnView(result: Result<String>) {
        switch result {
        case .success(let data):
            self.viewControllerDelegate?.songLyricsShow(lyrics: data)
        case .failure(let error):
            self.viewControllerDelegate?.songLyricsFailure(error: error)
        }
    }
}
