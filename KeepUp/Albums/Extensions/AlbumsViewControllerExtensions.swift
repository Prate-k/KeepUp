//
//  AlbumsViewControllerExtensions.swift
//  KeepUp
//
//  Created by Prateek Kambadkone on 2019/03/16.
//  Copyright © 2019 Prateek Kambadkone. All rights reserved.
//

import Foundation
import UIKit

extension AlbumsViewController {

    func addToFavouritesList(selectedArtist: Artist) {
        let index = FavouriteArtists.isArtistInFavouriteList(name: selectedArtist.artistName)
        if index != -1 {
            return
        }
        let newArtist = Artist(name: selectedArtist.artistName,
                genre: selectedArtist.artistGenre,
                imageUrl: selectedArtist.artistImageUrl)
        if let x = newArtist {
            FavouriteArtists.addArtist(artist: x)
        }
    }

    func removeFromFavouritesList(selectedArtist: Artist) {
        let index = FavouriteArtists.isArtistInFavouriteList(name: selectedArtist.artistName)
        if  index == -1 {
            return
        } else {
            FavouriteArtists.removeArtist(at: index)
        }
    }
}

extension AlbumsViewController: UITableViewDataSource, UITableViewDelegate {

    func numberOfSections(in collectionView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard selectedArtistPosition != nil else {
            return 0
        }
        return selectedArtist.artistAlbums.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: resusableId) as? AlbumTableViewCell else {
            fatalError("The dequeued cell is not an instance of MealTableViewCell.")
        }
        let albums = selectedArtist.artistAlbums
        if  albums.isEmpty {
            let album = albums[indexPath.row]
            cell.albumImageView.image = UIImage(named: "dummyAlbum")
            cell.albumName.text = album.albumName
            cell.releasedDate.text = "\(album.albumReleaseDate.releasedMonth) \(album.albumReleaseDate.releasedYear)"
        }
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "AlbumsToTracksSegue", sender: nil)
    }
}
