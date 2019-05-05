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
    func updateView(albums: Albums)
    func isArtistInList(_ check: Bool)
}

extension DiscographyViewController {
}

extension DiscographyViewController: DiscographyViewControllerProtocol {
    func albumLoadFailure(error: Errors) {
        DispatchQueue.main.async {
            self.progressBar.stopAnimating()
            switch error {
            case .NetworkError:
                showCouldNotLoadAlbumError(viewController: self)
            case .InvalidInput:
                print("Empty Search")
            case .EmptySearch:
                print("Empty search")
            case .Unknown:
                print("Unknown")
            }
        }
    }
    
    func updateView(albums: Albums) {
        self.albums = albums
        DispatchQueue.main.async {
            self.myStackView.isHidden = false
            self.albumsListTable.reloadData()
            self.progressBar.stopAnimating()
        }
    }

    func toggleArtistSearched(selectedArtist: SelectedArtist) {
        isArtistFavourited = !isArtistFavourited
        DispatchQueue.main.async {
            if self.isArtistFavourited {
                self.favouriteUnfavouriteButton.setImage(UIImage(named: "fav"), for: .normal)
                self.addToFavouritesList(selectedArtist: selectedArtist)
            } else {
                self.favouriteUnfavouriteButton.setImage(UIImage(named: "unfav"), for: .normal)
                self.removeFromFavouritesList(selectedArtist: selectedArtist)
            }
        }
    }
    
    func addToFavouritesList(selectedArtist: SelectedArtist) {
        if selectedArtist.artistName.isEmpty {
            DispatchQueue.main.async {
                self.progressBar.stopAnimating()
                showCouldNotLoadAlbumError(viewController: self)
            }
        }
        let newArtist = SelectedArtist(artistID: selectedArtist.artistID, artistName: selectedArtist.artistName, artistImage: selectedArtist.artistImage)
        viewModelDelegate?.addArtist(newArtist: newArtist)
    }
    
    func removeFromFavouritesList(selectedArtist: SelectedArtist) {
        if selectedArtist.artistName.isEmpty {
            DispatchQueue.main.async {
                self.progressBar.stopAnimating()
                showCouldNotLoadAlbumError(viewController: self)
            }
            
        } else {
            viewModelDelegate?.removeArtist(artistName: selectedArtist.artistName)
        }
    }
    
    func isArtistInList(_ check: Bool) {
        guard let selectedArtist = self.selectedArtist else {
            return
        }
        isArtistFavourited = check
        DispatchQueue.main.async {
            self.artistName.text = selectedArtist.artistName
            if let artistImage = selectedArtist.artistImage {
                self.artistImageView.loadImageFromSource(source: artistImage)
            } else {
                self.artistImageView.image = UIImage(named: "dummyArtist")
            }
            if check {
                self.favouriteUnfavouriteButton.setImage(UIImage(named: "fav"), for: .normal)
            } else {
                self.favouriteUnfavouriteButton.setImage(UIImage(named: "unfav"), for: .normal)
            }
        }
    }
}

extension DiscographyViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in collectionView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let albums = self.albums {
            return albums.count()
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: resusableId) as? AlbumTableViewCell else {
            fatalError("The dequeued cell is not an instance of AlbumTableViewCell.")
        }
        if let albums = self.albums {
            if let album = albums.get(i: indexPath.row) {
                if let image = album.albumCover {
                    cell.albumImageView.loadImageFromSource(source: image)
                }
                cell.albumName.text = album.albumName
                if let date = album.releaseDate {
                    cell.releasedDate.text = "\(date)"
                }
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "AlbumsToTracksSegue", sender: nil)
    }

}
