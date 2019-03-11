//
//  ArtistDetailsViewController.swift
//  KeepUp
//
//  Created by Prateek Kambadkone on 2019/02/15.
//  Copyright © 2019 Prateek Kambadkone. All rights reserved.
//

import UIKit

class ArtistDetailsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    let resusableId = "albumCell"
    var selectedArtistPosition: Int?
    var selectedArtist: Artist!
    @IBOutlet private weak var artistImageView: UIImageView!
    @IBOutlet private weak var artistName: UILabel!
    @IBOutlet private weak var genre: UILabel!
    @IBOutlet private weak var albumsListTable: UITableView!
    @IBOutlet private weak var favouriteUnfavouriteButton: UIButton!
    

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let albumDetailsViewController = segue.destination as? AlbumDetailsViewController {
            albumDetailsViewController.selectedAlbumPosition = albumsListTable.indexPathForSelectedRow?.item
            albumDetailsViewController.selectedArtistPosition = selectedArtistPosition
            return
        }
        if let artistInfoDetailsViewController = segue.destination as? ArtistInfoViewController {
            if let name = artistName.text {
                artistInfoDetailsViewController.artistName.append("\(name)")
                return
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        if let index = selectedArtistPosition, index != -1 {
            
            selectedArtist = FavouriteArtists.getArtist(at: index)
            artistImageView.image = UIImage(named: "dummyArtist")    //replace with artistImage.image = selectedArtist.image
            artistName.text = selectedArtist.artistName
            genre.text = selectedArtist.artistGenre
            selectedArtist.artistAlbums.append(Album(albumName: "album 1", albumReleaseDate: ReleasedDate(releasedMonth: "Oct", releasedYear: 2000),
                                                     albumArtUrl: "dummyAlbum",
                                                     albumTracks: [Song(songTitle:"", songLyrics: "", songLength: "")]))
            selectedArtist.artistAlbums.append(Album(albumName: "album 2", albumReleaseDate: ReleasedDate(releasedMonth: "Oct", releasedYear: 2000),
                                                     albumArtUrl: "dummyAlbum",
                                                     albumTracks: [Song(songTitle:"", songLyrics: "", songLength: "")]))
            selectedArtist.artistAlbums.append(Album(albumName: "album 3", albumReleaseDate: ReleasedDate(releasedMonth: "Oct", releasedYear: 2000),
                                                     albumArtUrl: "dummyAlbum",
                                                     albumTracks: [Song(songTitle:"", songLyrics: "", songLength: "")]))
        } else {
            let alert = UIAlertController(title: "Load Failed!", message: "Could not load albums for artist", preferredStyle: .alert)
            let action = UIAlertAction(title: "Ok", style: .default, handler: {
                action in
                self.navigationController?.popViewController(animated: true)
            })
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
        }
    }
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
    @IBAction func addRemoveFavourites() {
        let index = FavouriteArtists.isArtistInFavouriteList(name: selectedArtist.artistName)
        if index == -1 {
            favouriteUnfavouriteButton.setImage(UIImage(named: "fav"), for: .normal)
            addToFavouritesList()
        } else {
            favouriteUnfavouriteButton.setImage(UIImage(named: "unfav"), for: .normal)
            removeFromFavouritesList()
        }
    }
    private func addToFavouritesList() {
        let index = FavouriteArtists.isArtistInFavouriteList(name: selectedArtist.artistName)
        if index != -1 {
            return
        }
        let newArtist = Artist(name: selectedArtist.artistName, genre: selectedArtist.artistGenre, imageUrl: selectedArtist.artistImageUrl)
        if let x = newArtist {
            FavouriteArtists.addArtist(artist: x)
        }
    }
    private func removeFromFavouritesList() {
        let index = FavouriteArtists.isArtistInFavouriteList(name: selectedArtist.artistName)
        if  index == -1 {
            return
        } else {
            FavouriteArtists.removeArtist(at: index)
        }
    }
}
