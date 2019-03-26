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
    func getSongLyricsFromRepository(artistName: String, songTitle: String)
    func setLyricsOnView(result: Result<Lyrics>)
}

extension LyricsViewModel: LyricsViewModelProtocol {
    
    func getSongLyricsFromRepository(artistName: String, songTitle: String) {
        repositoryDelegate?.getSongLyricsFromDataSource(artistName: artistName, songTitle: songTitle)
    }
    
    func setLyricsOnView(result: Result<Lyrics>) {
        switch result {
        case .success(let data):
            self.viewControllerDelegate?.songLyricsShow(lyrics: data)
        case .failure(let error):
            self.viewControllerDelegate?.songLyricsFailure(error: error)
        }
    }
}
