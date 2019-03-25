//
//  DiscographyViewControllerExtensions.swift
//  KeepUp
//
//  Created by Prateek Kambadkone on 2019/03/16.
//  Copyright © 2019 Prateek Kambadkone. All rights reserved.
//

import Foundation
import UIKit

protocol DiscographyViewControllerProtocol: class {
    var viewModelDelegate: DiscographyViewModelProtocol? { get set }
    func albumLoadFailure(error: Errors)
    func updateView(artist: Artist)
}

extension DiscographyViewController: DiscographyViewControllerProtocol {
    
    func albumLoadFailure(error: Errors) {
        DispatchQueue.main.async {
            self.progressBar.stopAnimating()
            switch error {
            case .NetworkError:
                showCouldNotLoadAlbumError(viewController: self)
            case .InvalidInput:
                showEmptySearchAlertDialog(viewController: self)
            case .EmptySearch:
                print("Empty search")
            case .Unknown:
                print("Unknown")
            }
        }
    }
    
    func updateView(artist: Artist) {
        self.selectedArtist = artist
        self.albumList = artist.artistAlbums
        DispatchQueue.main.async {
            if let artist = self.selectedArtist {
                self.artistName.text = artist.artistName
                self.genre.text = artist.artistGenre
                
                self.myStackView.isHidden = false
                self.albumsListTable.reloadData()
                self.progressBar.stopAnimating()
            } else {
                self.albumLoadFailure(error: Errors.InvalidInput)
            }
        }
    }

    func toggleArtistSearched(selectedArtist: Artist) {
        isArtistFavourited = !isArtistFavourited
        DispatchQueue.main.async {
            if self.isArtistFavourited {
                self.favouriteUnfavouriteButton.setImage(UIImage(named: "fav"), for: .normal)
                self.addToFavouritesList(selectedArtist: selectedArtist)
            } else {
                self.favouriteUnfavouriteButton.setImage(UIImage(named: "unfav"), for: .normal)
                self.removeFromFavouritesList(selectedArtistName: selectedArtist.artistName)
            }
        }
    }
    
    func addToFavouritesList(selectedArtist: Artist) {
        if selectedArtist.artistName.isEmpty {
            DispatchQueue.main.async {
                self.progressBar.stopAnimating()
            }
            showCouldNotLoadAlbumError(viewController: self)
        }
        let newArtist = Artist(name: selectedArtist.artistName,
                genre: selectedArtist.artistGenre,
                imageUrl: selectedArtist.artistImageUrl)
        if let x = newArtist {
            viewModelDelegate?.addArtist(newArtist: x)
        }
    }
    
    func removeFromFavouritesList(selectedArtistName: String) {
        if selectedArtistName.isEmpty {
            DispatchQueue.main.async {
                self.progressBar.stopAnimating()
            }
            showCouldNotLoadAlbumError(viewController: self)
        } else {
            viewModelDelegate?.removeArtist(artistName: selectedArtistName)
        }
    }
}