//
//  DiscographyViewControllerExtensions.swift
//  KeepUp
//
//  Created by Prateek Kambadkone on 2019/03/16.
//  Copyright © 2019 Prateek Kambadkone. All rights reserved.
//

import Foundation
import UIKit

protocol DiscographyListFetching: class {
    func toggleArtistSearched(searchedArtist: Artist)
    func addToFavouritesList(selectedArtist: Artist)
    func removeFromFavouritesList(selectedArtist: Artist)
    
    func albumsListShow(albums: [Album])
    func showSelectedArtist(artist: Artist)
}

extension DiscographyViewController: DiscographyListFetching {
    func showSelectedArtist(artist: Artist) {
        selectedArtist = artist
        DispatchQueue.main.async {
            self.artistName.text = artist.artistName
            self.genre.text = artist.artistGenre
            self.artistImageView.image = UIImage(named: "dummyArtist")
        }
    }
    
    func albumsListShow(albums: [Album]) {
        albumList = albums
        DispatchQueue.main.async {
            self.albumsListTable.reloadData()
        }
    }
    
    func toggleArtistSearched(searchedArtist: Artist) {
        let index = discographyViewModel?.getArtistIndex(name: selectedArtist.artistName)
        DispatchQueue.main.async {
            if index == -1 {
                self.favouriteUnfavouriteButton.setImage(UIImage(named: "fav"), for: .normal)
                self.addToFavouritesList(selectedArtist: searchedArtist)
            } else {
                self.favouriteUnfavouriteButton.setImage(UIImage(named: "unfav"), for: .normal)
                self.removeFromFavouritesList(selectedArtist: searchedArtist)
            }
        }
    }
    
    func addToFavouritesList(selectedArtist: Artist) {
        let index = discographyViewModel?.getArtistIndex(name: selectedArtist.artistName)
        if index != -1 {
            return
        }
        let newArtist = Artist(name: selectedArtist.artistName,
                genre: selectedArtist.artistGenre,
                imageUrl: selectedArtist.artistImageUrl)
        if let x = newArtist {
            discographyViewModel?.addArtist(x)
        }
    }
    
    func removeFromFavouritesList(selectedArtist: Artist) {
        let index = discographyViewModel?.getArtistIndex(name: selectedArtist.artistName)
        if  index == -1 {
            return
        } else {
            if let index = index {
                discographyViewModel?.removeArtist(at: index)
            }
        }
    }
}
