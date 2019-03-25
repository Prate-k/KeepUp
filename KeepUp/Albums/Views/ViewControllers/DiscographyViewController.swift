//
//  DiscographyViewController.swift
//  KeepUp
//
//  Created by Prateek Kambadkone on 2019/02/15.
//  Copyright © 2019 Prateek Kambadkone. All rights reserved.
//

import UIKit

class DiscographyViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    let resusableId = "albumCell"
    var selectedArtistName = ""  //used for passing data between prev screen and this
    
    var selectedArtist: Artist?  //stores selected artist details
    var albumList: [Album] = []  //stores locally selected artist album
    var isArtistFavourited = true  //shows if artist is still in favourite list
    
    var viewModelDelegate: DiscographyViewModelProtocol?   //used for mvvm comm

    @IBOutlet weak var progressBar: UIActivityIndicatorView!
    @IBOutlet weak var albumsListTable: UITableView!
    @IBOutlet weak var artistImageView: UIImageView!
    @IBOutlet weak var artistName: UILabel!
    @IBOutlet weak var genre: UILabel!
    @IBOutlet weak var favouriteUnfavouriteButton: UIButton!
    @IBOutlet weak var myStackView: UIStackView!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let songViewController = segue.destination as? SongsViewController {
            if let index = albumsListTable.indexPathForSelectedRow?.item {
                songViewController.selectedAlbumName = albumList[index].albumName
                songViewController.selectedArtistName = selectedArtist?.artistName
            }
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
        artistImageView.loadImageFromSource(source: "")
        viewModelDelegate = DiscographyViewModel()
        viewModelDelegate?.viewControllerDelegate = self
        viewModelDelegate?.getSelectedArtist(artistName: selectedArtistName)
        progressBar.hidesWhenStopped = true
        myStackView.isHidden = true
        if selectedArtistName.isEmpty {
            showEmptySearchAlertDialog(viewController: self)
            return
        } else {
            progressBar.startAnimating()
        }
    }

    @IBAction func addRemoveFavourites() {
        if let artist = selectedArtist {
            toggleArtistSearched(selectedArtist: artist)
        } else {
            showCouldNotLoadAlbumError(viewController: self)
        }
    }
    
    func numberOfSections(in collectionView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return albumList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: resusableId) as? AlbumTableViewCell else {
            fatalError("The dequeued cell is not an instance of AlbumTableViewCell.")
        }
        if !albumList.isEmpty {
            let album = albumList[indexPath.row]
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
