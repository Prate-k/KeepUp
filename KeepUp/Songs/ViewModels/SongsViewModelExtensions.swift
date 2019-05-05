//
//  SongsViewModelExtensions.swift
//  KeepUp
//
//  Created by Prateek Kambadkone on 2019/03/17.
//  Copyright © 2019 Prateek Kambadkone. All rights reserved.
//

import Foundation

protocol SongsViewModelFunctionable: class {
    func getSongs(of albumID: Int)
}

protocol SongsViewModelProtocol: SongsViewModelFunctionable {
    var viewControllerDelegate: SongsViewControllerProtocol? { get set }
    var repositoryDelegate: SongsRepositoryProtocol? { get set }
    func updateSelectedAlbum(result: Result<Songs>)
}

extension SongsViewModel {
    func secondsToMinutes(seconds: Int) -> String {
        let (min, sec) = seconds.quotientAndRemainder(dividingBy: 60)
        return "\(min):\(sec)"
    }
}

extension SongsViewModel: SongsViewModelProtocol {
    
    func updateSelectedAlbum(result: Result<Songs>) {
        switch result {
        case .success(let songs):
            var modified = songs
            modified.removeAll()
            var song: Song!
            for s in songs.results {
                song = s
                song.setLengthInMinutes(seconds: secondsToMinutes(seconds: s.songLength!))
                modified.append(song: song)
            }
            viewControllerDelegate?.updateView(songs: modified)
        case .failure(let error):
            viewControllerDelegate?.songsLoadFailure(error: error)
        }
    }
    
    func getSongs(of albumID: Int) {
        repositoryDelegate?.getSongs(from: albumID)
    }
}
