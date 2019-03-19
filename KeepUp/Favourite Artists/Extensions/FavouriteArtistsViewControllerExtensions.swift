//
//  FavouriteArtistsViewControllerExtensions.swift
//  KeepUp
//
//  Created by Prateek Kambadkone on 2019/03/11.
//  Copyright © 2019 Prateek Kambadkone. All rights reserved.
//

import Foundation
import UIKit

extension FavouriteArtistsViewController {
    func removeMarkedArtists (_ positions: [Int]) {
        for i in 0..<positions.count {
            let pos = positions[i] - i
            favouriteArtistsViewModel?.removeArtist(at: pos)
        }
        if let artists = self.favouriteArtistsViewModel?.getFavouriteList() {
            favouriteArtistList = artists
            favCollectionView.reloadData()
        }
    }
    
    func confirmDelete(_ positions: [Int]) {
        let deleteAlert = UIAlertController(title: "Delete?",
                                            message: "All selected artists will be removed",
                                            preferredStyle: UIAlertController.Style.alert)
        
        deleteAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { _ in return}))
        
        deleteAlert.addAction(UIAlertAction(title: "Continue", style: .default, handler: { (_: UIAlertAction!) in
            self.removeMarkedArtists(positions)
        }))
        
        present(deleteAlert, animated: true, completion: nil)
    }
    
    func getMarkedForDelete() -> [Int] {
        var positions = [Int]()
        for i in 0..<favCollectionView.numberOfItems(inSection: 0) {
            if let cell = favCollectionView.cellForItem(at: IndexPath.init(item: i, section: 0))
                as? FavouriteArtistCollectionViewCell {
                if cell.deleteCheckBoxView.isChecked {
                    positions.append(i)
                }
            }
        }
        return positions
    }
    
    func enterEditMode() {
        inEditMode = true //change to edit mode
        navBar.setHidesBackButton(true, animated: true)
        editNavButton.title = "Done"
        favCollectionView.reloadData()
    }
    
    func exitEditMode() {
        inEditMode = false //change to view mode
        navBar.setHidesBackButton(false, animated: true)
        editNavButton.title = "Edit"
        favCollectionView.reloadData()
    }
}
