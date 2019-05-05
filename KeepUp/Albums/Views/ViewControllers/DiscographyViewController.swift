//
//  DiscographyViewController.swift
//  KeepUp
//
//  Created by Prateek Kambadkone on 2019/02/15.
//  Copyright © 2019 Prateek Kambadkone. All rights reserved.
//

import UIKit

class DiscographyViewController: UIViewController {

    let resusableId = "albumCell"
    var isArtistFavourited = true  //shows if artist is still in favourite list
    
    var selectedArtist: SelectedArtist?
    var albums: Albums?
    var viewModelDelegate: DiscographyViewModelProtocol?   //used for mvvm comm
    let queue = DispatchQueue(label: "AlbumsTaskQueue", qos: .userInteractive, attributes: .concurrent)

    @IBOutlet weak var artistInfoButton: UIButton!
    @IBOutlet weak var progressBar: UIActivityIndicatorView!
    @IBOutlet weak var albumsListTable: UITableView!
    @IBOutlet weak var artistImageView: UIImageView!
    @IBOutlet weak var artistName: UILabel!
    @IBOutlet weak var favouriteUnfavouriteButton: UIButton!
    @IBOutlet weak var myStackView: UIStackView!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let songsViewController = segue.destination as? SongsViewController {
            if let index = albumsListTable.indexPathForSelectedRow?.item {
                if let albums = self.albums {
                    if let album = albums.get(i: index) {
                        if let artistName = selectedArtist?.artistName {
                        songsViewController.selectedAlbum = SelectedAlbum(albumID: album.albumID, albumName: album.albumName, albumImage: album.albumCover, artistName: artistName)
                        }
                        return
                    }
                }
            }
            return
        }
        if let artistInfoViewController = segue.destination as? ArtistInfoViewController {
            if let name = selectedArtist?.artistName {
                artistInfoViewController.artistName.append("\(name)")
                return
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        guard let selectedArtist = self.selectedArtist else {
            showEmptySearchAlertDialog(viewController: self)
            return
        }
        
        
        viewModelDelegate = DiscographyViewModel()
        viewModelDelegate?.viewControllerDelegate = self
        
        queue.async {
            self.viewModelDelegate?.isArtistFavourited(selectedArtist.artistName)
        }
        queue.async {
            self.viewModelDelegate?.getAlbums(of: selectedArtist.artistID)
        }
        progressBar.hidesWhenStopped = true
        myStackView.isHidden = true
    
        progressBar.startAnimating()
    }

    @IBAction func addRemoveFavourites() {
        if let artist = selectedArtist {
            toggleArtistSearched(selectedArtist: artist)
        } else {
            showCouldNotLoadAlbumError(viewController: self)
        }
    }
    
}
