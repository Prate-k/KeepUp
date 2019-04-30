//
//  LyricsViewControllerExtensions.swift
//  KeepUp
//
//  Created by Prateek Kambadkone on 2019/03/18.
//  Copyright © 2019 Prateek Kambadkone. All rights reserved.
//

import Foundation

protocol LyricsViewControllerProtocol: class {
    var viewModelDelegate: LyricsViewModelProtocol? { get set }
    func songLyricsShow(lyrics: String)
    func songLyricsFailure(error: Errors)
}

extension LyricsViewController: LyricsViewControllerProtocol {
    
    func setSongTitle(songTitle: String) {
        DispatchQueue.main.async {
            self.songTitleLabel.text = songTitle
        }
    }
    
    func setArtist(artistName: String) {
        DispatchQueue.main.async {
            self.artistNameLabel.text = artistName
        }
    }
    
    func songLyricsShow(lyrics: String) {
        DispatchQueue.main.async {
            self.progressBar.stopAnimating()
            self.lyricsTextView.text = lyrics
            self.lyricsTextView.isHidden = false
        }
    }
    
    func songLyricsFailure(error: Errors) {
        switch error {
        case .NetworkError:
            showLyricsLoadFailedAlertDialog(viewController: self)
        case .EmptySearch:
            showEmptySearchAlertDialog(viewController: self)
        case .InvalidInput:
            print("Invalid input")
        case .Unknown:
            print("unknown error")
        }
    }
}
