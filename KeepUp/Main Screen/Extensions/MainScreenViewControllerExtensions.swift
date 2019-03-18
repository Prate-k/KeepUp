//
//  MainScreenViewControllerExtensions.swift
//  KeepUp
//
//  Created by Prateek Kambadkone on 2019/03/14.
//  Copyright © 2019 Prateek Kambadkone. All rights reserved.
//

import Foundation
import UIKit

extension MainScreenViewController {
    func loadAlbumsScreen(albumsViewController: DiscographyViewController) {
        if isLoadingAllFavourites {
            albumsViewController.selectedArtistPosition = selectedArtistPosition
        } else {
            if let index = favCollectionView.indexPathsForSelectedItems?[0].item {
                albumsViewController.selectedArtistPosition = index
            }
        }
        isLoadingAllFavourites = false
    }
    
    func loadArtistInfoScreen (artistInfoViewController: ArtistInfoViewController) {
        if let name = resultArtistLabel.text {
            artistInfoViewController.artistName.append("\(name)")
            return
        }
    }
    
    func addToFavouritesList() {
        if favouriteUnfavouriteButton.imageView?.image == UIImage(named: "unfav") {
            favouriteUnfavouriteButton.setImage(UIImage(named: "fav"), for: .normal)
        }
        let newArtist = Artist(name: resultArtistLabel.text, genre: resultGenreLabel.text, imageUrl: "dummyArtist")
        if let newArtist = newArtist {
            FavouriteArtists.addArtist(artist: newArtist)
            favCollectionView.reloadData()
            topTracksCollectionView.reloadData()
        }
    }
    
    func removeFromFavouritesList(index: Int) {
        if favouriteUnfavouriteButton.imageView?.image == UIImage(named: "fav") {
            favouriteUnfavouriteButton.setImage(UIImage(named: "unfav"), for: .normal)
        }
        FavouriteArtists.removeArtist(at: index)
        favCollectionView.reloadData()
        topTracksCollectionView.reloadData()
    }
    
    func showResultView(searchedText: String) {
        resultView.isHidden = false
        resultArtistLabel.text = searchedText
        resultGenreLabel.text = "Random"
        resultImageView.image = UIImage(named: "dummyArtist")
        if FavouriteArtists.isArtistInFavouriteList(name: searchedText) != -1 {
            favouriteUnfavouriteButton.setImage(UIImage(named: "fav"), for: .normal)
        } else {
            favouriteUnfavouriteButton.setImage(UIImage(named: "unfav"), for: .normal)
        }
    }
    
    func setFavouriteArtistCellProperties(cell: UICollectionViewCell,
                                          artist: Artist) -> UICollectionViewCell {
        if let favouriteArtistCell = cell as? FavouriteArtistCollectionViewCell {
            favouriteArtistCell.artistName.text = artist.artistName
            favouriteArtistCell.genre.text = artist.artistGenre
            favouriteArtistCell.imageView.image = UIImage(named: "dummyArtist")
            favCollectionViewCellSize = favouriteArtistCell.frame.size
            return favouriteArtistCell
        }
        return cell
    }
    
    func rotateViewLeft(view: UIView) -> UIView {
        let headerView = view as? FavouriteArtistsCollectionViewHeader
        if let headerView = headerView {
            headerView.viewAllView.isHidden = false
            headerView.viewAllView.transform = CGAffineTransform.init(rotationAngle: -CGFloat.pi/2)
            headerView.frame.size.height = favCollectionViewCellSize.height
            headerView.viewAllView.frame.size.width = favCollectionViewCellSize.height
            headerView.viewAllLabel.frame.size.width = favCollectionViewCellSize.height
            return headerView
        }
        return view
    }
}
