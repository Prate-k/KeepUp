//
//  ArtistDetailsViewController.swift
//  KeepUp
//
//  Created by Prateek Kambadkone on 2019/02/15.
//  Copyright © 2019 Prateek Kambadkone. All rights reserved.
//

import UIKit

class AlbumsViewController: UIViewController {

    let resusableId = "albumCell"
    var selectedArtistPosition: Int?
    var selectedArtist: Artist!

    @IBOutlet private weak var artistImageView: UIImageView!
    @IBOutlet private weak var artistName: UILabel!
    @IBOutlet private weak var genre: UILabel!
    @IBOutlet private weak var albumsListTable: UITableView!
    @IBOutlet private weak var favouriteUnfavouriteButton: UIButton!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let discographyViewController = segue.destination as? TrackListViewController {
            discographyViewController.selectedAlbumPosition = albumsListTable.indexPathForSelectedRow?.item
            discographyViewController.selectedArtistPosition = selectedArtistPosition
            return
        }
        if let artistInfoViewController = segue.destination as? ArtistInfoViewController {
            if let name = artistName.text {
                artistInfoViewController.artistName.append("\(name)")
                return
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        //use viewmodel to get the selected artist from the "local database"
        if let index = selectedArtistPosition, index != -1 {
            selectedArtist = FavouriteArtists.getArtist(at: index)
            artistImageView.image = UIImage(named: "dummyArtist")
             //replace with artistImage.image = selectedArtist.image
            artistName.text = selectedArtist.artistName
            genre.text = selectedArtist.artistGenre
            for i in 0..<3 {
                selectedArtist.artistAlbums.append(Album(albumName: "album \(i+1)",
                                         albumReleaseDate: ReleasedDate(releasedMonth: "Oct", releasedYear: 2000),
                                         albumArtUrl: "dummyAlbum",
                                         albumTracks: [Song(songTitle: "",
                                                            songLyrics: "", songLength: "", isHidden: false)]))
            }
        } else {
            showEmptySearchAlertDialog(viewController: self)
        }
    }

    @IBAction func addRemoveFavourites() {
        let index = FavouriteArtists.isArtistInFavouriteList(name: selectedArtist.artistName)
        if index == -1 {
            favouriteUnfavouriteButton.setImage(UIImage(named: "fav"), for: .normal)
            addToFavouritesList(selectedArtist: selectedArtist)
        } else {
            favouriteUnfavouriteButton.setImage(UIImage(named: "unfav"), for: .normal)
            removeFromFavouritesList(selectedArtist: selectedArtist)
        }
    }
}
