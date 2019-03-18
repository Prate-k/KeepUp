//
//  LyricsViewModelExtensions.swift
//  KeepUp
//
//  Created by Prateek Kambadkone on 2019/03/18.
//  Copyright © 2019 Prateek Kambadkone. All rights reserved.
//

import Foundation

protocol LyricsViewModelFunctionable: class {
    func getSongLyrics(artistName: String, songTitle: String)
}

extension LyricsViewModel: LyricsViewModelFunctionable {
    func getSongLyrics(artistName: String, songTitle: String) {
        let lyricsRepository: LyricsRepositoryFunctionable = LyricsRepository()
        _ = lyricsRepository.getSongLyrics(artistName: artistName, songTitle: songTitle, completing: { (song) in
            self.lyricsViewController?.displayLyrics(for: song)
        })
    }
}
