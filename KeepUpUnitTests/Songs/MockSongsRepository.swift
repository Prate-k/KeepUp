//
//  MockSongsRepository.swift
//  KeepUpUnitTests
//
//  Created by Prateek Kambadkone on 2019/04/30.
//  Copyright © 2019 Prateek Kambadkone. All rights reserved.
//

import Foundation
@testable import KeepUp

class MockSongsRepository: SongsRepositoryProtocol {
    var viewModelDelegate: SongsViewModelProtocol?
    
    
    func dataReady(result: Result<Songs>) {
        switch result {
        case .success(let album):
            viewModelDelegate?.updateSelectedAlbum(result: Result.success(album))
        case .failure(let error):
            viewModelDelegate?.updateSelectedAlbum(result: Result.failure(error))
        }
    }
    
    func getSongs(from albumID: Int) {
        if albumID < 0 {
            dataReady(result: Result.failure(.InvalidInput))
        } else {
            var songs: [Song] = []
            for index in 0..<3 {
                songs.append(Song(songID: index, songName: "Song\(index)", songLength: (index)*60, songLengthText: ""))
            }
            dataReady(result: Result.success(Songs(results: songs)))
        }
    }
}
