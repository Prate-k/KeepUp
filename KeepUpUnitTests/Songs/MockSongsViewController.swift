//
//  MockSongsViewController.swift
//  KeepUpUnitTests
//
//  Created by Prateek Kambadkone on 2019/04/30.
//  Copyright © 2019 Prateek Kambadkone. All rights reserved.
//

import Foundation
@testable import KeepUp
import XCTest

class MockSongsViewController: SongsViewControllerProtocol {
    var viewModelDelegate: SongsViewModelProtocol?
    
    func songsLoadFailure(error: Errors) {
        XCTAssert(error == .InvalidInput)
    }
    
    func updateView(songs: Songs) {
        var bool = true
        var lengths = ["0:0.0", "2:0.0", "3:0.0"]
        for index in 0..<3 {
            let result = songs.get(i: index)
            if result?.songID != index || result?.songName != "Song\(index)" ||
                (result?.songLengthText.contains(lengths[index]))! {
                bool = false
                break
            }
        }
        XCTAssert(bool)
    }
    
    func loadLyricsScreen(lyricsViewController: LyricsViewController) {
        
    }
    
    func showSelectedAlbum(album: SelectedAlbum) {
      
    }
}
