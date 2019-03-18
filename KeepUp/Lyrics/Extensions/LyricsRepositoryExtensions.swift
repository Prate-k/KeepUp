//
//  LyricsRepositoryExtensions.swift
//  KeepUp
//
//  Created by Prateek Kambadkone on 2019/03/18.
//  Copyright © 2019 Prateek Kambadkone. All rights reserved.
//

import Foundation

protocol LyricsRepositoryFunctionable {
    func getSongLyrics(artistName: String, songTitle: String, completing: @escaping (Song) -> Void)
}

extension LyricsRepository: LyricsRepositoryFunctionable {
    func getSongLyrics(artistName: String, songTitle: String, completing: @escaping (Song) -> Void) {
        //make network call to musicxmatch api to get lyrics
        //in closure of networker.send -> completing(song.lyrics)
        let exampleLyrics = """
                            lyrics... lyrics, Lyrics \t lyrics, \n lyrics
                            \n\n Lyrics
                            """
        let exampleSong = Song(songTitle: songTitle, songLyrics: exampleLyrics, songLength: "3.45", isHidden: false)
        completing(exampleSong)
    }
}
