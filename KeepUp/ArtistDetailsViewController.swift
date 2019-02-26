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
    var removeArtistBeforeReturning: Bool = false
    
    @IBOutlet private weak var artistImageView: UIImageView!
    @IBOutlet private weak var artistName: UILabel!
    @IBOutlet private weak var genre: UILabel!
    @IBOutlet private weak var albumsListTable: UITableView!
    @IBOutlet private weak var favouriteUnfavouriteButton: UIButton!
    override func viewWillDisappear(_ animated: Bool) {
        if removeArtistBeforeReturning {
            let index = isArtistInFavouriteList(name: selectedArtist.name)
            if index == -1 {
                favouriteUnfavouriteButton.setImage(UIImage(named: "fav"), for: .normal)
                addToFavouritesList()
            } else {
                favouriteUnfavouriteButton.setImage(UIImage(named: "unfav"), for: .normal)
                removeFromFavouritesList()
            }
        }
    }
    
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
            artistName.text = selectedArtist.name
            genre.text = selectedArtist.genre
            selectedArtist.albums.append(Album(albumName: "album 1", released: Date(month: "Oct", year: 2000),
                                               albumArt: UIImage(named: "dummyAlbum")!,
                                               songs: [Song(songTitle:"", lyrics: "", length: "")]))
            selectedArtist.albums.append(Album(albumName: "album 2", released: Date(month: "Oct", year: 2000),
                                               albumArt: UIImage(named: "dummyAlbum")!,
                                               songs: [Song(songTitle:"", lyrics: "", length: "")]))
            selectedArtist.albums.append(Album(albumName: "album 3", released: Date(month: "Oct", year: 2000),
                                               albumArt: UIImage(named: "dummyAlbum")!,
                                               songs: [Song(songTitle:"", lyrics: "", length: "")]))
        } else {
            let alert = UIAlertController(title: "Load Failed!", message: "Could not load albums for artist", preferredStyle: .alert)
            let action = UIAlertAction(title: "Ok", style: .default, handler: {
                action in
                self.dismiss(animated: true, completion: nil)
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
        return selectedArtist.albums.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: resusableId) as? AlbumTableViewCell else {
            fatalError("The dequeued cell is not an instance of MealTableViewCell.")
        }
        let albums = selectedArtist.albums
        if  albums.isEmpty {
            let album = albums[indexPath.row]
            cell.albumImageView.image = album.albumArt
            cell.albumName.text = album.albumName
            cell.releasedDate.text = "\(album.released.month) \(album.released.year)"
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "AlbumsToTracksSegue", sender: nil)
    }
    @IBAction func addRemoveFavourites() {
        removeArtistBeforeReturning = true
        let index = isArtistInFavouriteList(name: selectedArtist.name)
        if index == -1 {
            favouriteUnfavouriteButton.setImage(UIImage(named: "fav"), for: .normal)
            removeArtistBeforeReturning = false
        } else {
            favouriteUnfavouriteButton.setImage(UIImage(named: "unfav"), for: .normal)
            removeArtistBeforeReturning = true
        }
    }
    private func isArtistInFavouriteList (name: String) -> Int {
        var index = -1
        for i in 0..<FavouriteArtists.size {
            if FavouriteArtists.getArtist(at: i)!.name.elementsEqual(selectedArtist.name) {
                index = i
                break
            }
        }
        return index
    }
    private func addToFavouritesList() {
        let index = isArtistInFavouriteList(name: selectedArtist.name)
        if index != -1 {
            return
        }
        let newArtist = Artist(name: selectedArtist.name, genre: selectedArtist.genre, image: selectedArtist.image)
        if let x = newArtist {
            FavouriteArtists.addArtist(artist: x)
        }
    }
    private func removeFromFavouritesList() {
        let index = isArtistInFavouriteList(name: selectedArtist.name)
        if  index == -1 {
            return
        } else {
            FavouriteArtists.removeArtist(at: index)
        }
    }
}
