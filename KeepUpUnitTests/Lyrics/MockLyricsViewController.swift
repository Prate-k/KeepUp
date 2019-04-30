//
//  MockLyricsViewController.swift
//  KeepUpUnitTests
//
//  Created by Prateek Kambadkone on 2019/04/30.
//  Copyright © 2019 Prateek Kambadkone. All rights reserved.
//

import Foundation
@testable import KeepUp
import XCTest

class MockLyricsViewController: LyricsViewControllerProtocol {

    lazy var viewModelDelegate: LyricsViewModelProtocol? = nil
    var isSolo: Bool = false

    let exampleWords = """
                        lyrics... lyrics, Lyrics \t lyrics, \n lyrics
                        \n\n Lyrics
                        """

    func songLyricsFailure(error: Errors) {
        XCTAssert(error == .InvalidInput)
        counter += 1
    }

    init() {
        viewModelDelegate = LyricsViewModel()
        viewModelDelegate?.viewControllerDelegate = self

    }

    func getSongLyrics(artistName: String, songTitle: String) {
        var selectedSong = SelectedSong(album: SelectedAlbum(albumID: 1, albumName: "", albumImage: "", artistName: artistName), songName: songTitle)
        viewModelDelegate?.getSongLyrics(of: selectedSong)
    }

    func songLyricsShow(lyrics: String) {
        //assert success
        XCTAssert(exampleWords == lyrics)
        counter += 1
    }

    var counter = 0

    func reset() {
        counter = 0
    }

    func verify () {
        XCTAssert(counter == 1)
    }
}
