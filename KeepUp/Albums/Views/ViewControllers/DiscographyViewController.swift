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
    var selectedArtistPosition: Int?
    var selectedArtist: Artist!
    var albumList: [Album] = []
    lazy var discographyViewModel: DiscographyViewModel? = nil

    @IBOutlet weak var albumsListTable: UITableView!
    @IBOutlet weak var artistImageView: UIImageView!
    @IBOutlet weak var artistName: UILabel!
    @IBOutlet weak var genre: UILabel!
    @IBOutlet weak var favouriteUnfavouriteButton: UIButton!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let discographyViewController = segue.destination as? SongsViewController {
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
        if let index = selectedArtistPosition, index != -1 {
            discographyViewModel = DiscographyViewModel(view: self)
            DispatchQueue.global().async { [weak self] in
                if let self = self {
                    self.discographyViewModel?.getSelectedArtist(at: index)
                    if let selectedArtist = self.selectedArtist {
                        if let discographyViewModel = self.discographyViewModel {
                            discographyViewModel.getAlbumList(with: selectedArtist.artistName)
                        }
                    }
                }
            }
        } else {
            showEmptySearchAlertDialog(viewController: self)
        }
    }

    @IBAction func addRemoveFavourites() {
        toggleArtistSearched(searchedArtist: selectedArtist)
    }
    
    func numberOfSections(in collectionView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard selectedArtistPosition != nil else {
            return 0
        }
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
