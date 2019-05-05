//
//  SongsViewControllerExtensions.swift
//  KeepUp
//
//  Created by Prateek Kambadkone on 2019/03/17.
//  Copyright © 2019 Prateek Kambadkone. All rights reserved.
//

import Foundation
import UIKit

protocol SongsViewControllerProtocol: class {
    var viewModelDelegate: SongsViewModelProtocol? { get set }
    func songsLoadFailure(error: Errors)
    func updateView(songs: Songs)
    func setSelectedSong(_ songName: String)
}

extension SongsViewController: SongsViewControllerProtocol {
    
    func setSelectedSong(_ songName: String) {
        selectedSongTitle = songName
        print("lyrics of \(selectedSongTitle)")
        self.performSegue(withIdentifier: "TracksToLyricsSegue", sender: nil)
    }
    
    func songsLoadFailure(error: Errors) {
        DispatchQueue.main.async {
            self.progressBar.stopAnimating()
            switch error {
            case .NetworkError:
                showCouldNotLoadSongsError(viewController: self)
            case .InvalidInput:
                showEmptySearchAlertDialog(viewController: self)
            case .EmptySearch:
                print("Empty search")
            case .Unknown:
                print("Unknown")
            }
        }
    }
    
    func updateView(songs: Songs) {
        self.songs = songs
        DispatchQueue.main.async {
            self.progressBar.stopAnimating()
            self.songsListTableView.reloadData()
        }
    }
    
    func loadLyricsScreen(lyricsViewController: LyricsViewController) {
        if let album = self.selectedAlbum {
            lyricsViewController.selectedSong = SelectedSong(album: SelectedAlbum(albumID: album.albumID, albumName: album.albumName, albumImage: album.albumImage, artistName: album.artistName), songName: selectedSongTitle)
        }
    }
    
    func showSelectedAlbum(album: SelectedAlbum) {
        selectedAlbum = album
        DispatchQueue.main.async {
            self.albumName.text = album.albumName
            self.albumImageView.loadImageFromSource(source: album.albumImage)
        }
    }
}
