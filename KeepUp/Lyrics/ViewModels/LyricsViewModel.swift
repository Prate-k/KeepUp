//
//  SongLyricsViewModel.swift
//  KeepUp
//
//  Created by Prateek Kambadkone on 2019/03/15.
//  Copyright © 2019 Prateek Kambadkone. All rights reserved.
//

import Foundation

class LyricsViewModel {
    
    weak var lyricsViewController: SongLyricsFetching?
    
    init(view: SongLyricsFetching) {
        self.lyricsViewController = view
    }
}
