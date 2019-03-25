//
//  MainScreenViewControllerExtensions.swift
//  KeepUp
//
//  Created by Prateek Kambadkone on 2019/03/14.
//  Copyright © 2019 Prateek Kambadkone. All rights reserved.
//

import Foundation
import UIKit

protocol MainScreenPopulating: class {
    func toggleArtistSearched(searchedArtistName: String)
    func addToFavouritesList(searchedArtistName: String)
    func removeFromFavouritesList(searchedArtistName: String)
}

extension MainScreenViewController: MainScreenPopulating {
    func toggleArtistSearched(searchedArtistName: String) {
        let index = mainScreenViewModel?.getArtistIndex(name: searchedArtistName)
        if index == -1 {
            favouriteUnfavouriteButton.setImage(UIImage(named: "fav"), for: .normal)
            addToFavouritesList(searchedArtistName: searchedArtistName)
        } else {
            favouriteUnfavouriteButton.setImage(UIImage(named: "unfav"), for: .normal)
            removeFromFavouritesList(searchedArtistName: searchedArtistName)
        }
        if let artists = self.mainScreenViewModel?.getFavouriteList() {
            favouriteArtistList = artists
            favCollectionView.reloadData()
        }
    }
    
    func addToFavouritesList(searchedArtistName: String) {
        let index = mainScreenViewModel?.getArtistIndex(name: searchedArtistName)
        if index != -1 {
            return
        }
        let newArtist = Artist(name: searchedArtistName,
                               genre: "Random",
                               imageUrl: "dummyArtist")
        if let x = newArtist {
            mainScreenViewModel?.addArtist(x)
        }
    }
    
    func removeFromFavouritesList(searchedArtistName: String) {
        let index = mainScreenViewModel?.getArtistIndex(name: searchedArtistName)
        if  index == -1 {
            return
        } else {
            if let index = index {
                mainScreenViewModel?.removeArtist(at: index)
            }
        }
    }
}

extension MainScreenViewController {
    func loadAlbumsScreen(albumsViewController: DiscographyViewController) {
        if isLoadingAllFavourites {
            albumsViewController.selectedArtistName = favouriteArtistList[selectedArtistPosition].artistName
        } else {
            if let index = favCollectionView.indexPathsForSelectedItems?[0].item {
                albumsViewController.selectedArtistName = favouriteArtistList[index].artistName
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
    
    func showResultView(searchedText: String) {
        searchedArtistName = searchedText
        resultView.isHidden = false
        resultArtistLabel.text = searchedText
        resultGenreLabel.text = "Random"
        resultImageView.image = UIImage(named: "dummyArtist")
        if mainScreenViewModel?.getArtistIndex(name: searchedText) != -1 {
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
