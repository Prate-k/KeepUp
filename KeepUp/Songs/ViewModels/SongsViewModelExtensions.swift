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
        let deciMinutes: Float = Float(seconds)/60.0
        let length = String(deciMinutes)
        
        var time = length.split(separator: ".")
        let minutes = time[0]
        var seconds = String(time[1])
        if seconds.count > 2 {
           seconds = String(seconds.substring(to: String.Index(encodedOffset: 2)))
        }
        let clockSeconds = Float((Int(seconds)!/100)*60)
        print("\(minutes):\(clockSeconds)")
        return "\(minutes):\(clockSeconds)"
    }
}

extension SongsViewModel: SongsViewModelProtocol {
    
    func updateSelectedAlbum(result: Result<Songs>) {
        switch result {
        case .success(let songs):
            var song: Song!
            for s in songs.results {
                song = s
                song.setLengthInMinutes(seconds: secondsToMinutes(seconds: s.songLength!))
            }
            viewControllerDelegate?.updateView(songs: songs)
        case .failure(let error):
            viewControllerDelegate?.songsLoadFailure(error: error)
        }
    }
    
    func getSongs(of albumID: Int) {
        repositoryDelegate?.getSongs(from: albumID)
    }
}
