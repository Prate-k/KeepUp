//
//  FavouriteArtistsViewController.swift
//  KeepUp
//
//  Created by Prateek Kambadkone on 2019/03/10.
//  Copyright © 2019 Prateek Kambadkone. All rights reserved.
//

import UIKit

class FavouriteArtistsViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
   
    @IBOutlet weak var editNavButton: UIBarButtonItem!
    @IBOutlet weak var navBar: UINavigationItem!
    
    let reusableId1 = "FavArtistCell"
    var inEditMode = false
    var numberMarkedForDelete = 0
    
    var favouriteArtists: [SelectedArtist]?
    lazy var favouriteArtistsViewModel: FavouriteArtistsViewModel? = nil
    
    @IBOutlet weak var favCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navBar.setHidesBackButton(false, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let albumsViewController = segue.destination as? DiscographyViewController {
            if let index = favCollectionView.indexPathsForSelectedItems?.index(0, offsetBy: 0) {
                if let artists = favouriteArtists {
                    let artist = artists[index]
                    albumsViewController.selectedArtist = SelectedArtist(artistID: artist.artistID, artistName: artist.artistName, artistImage: artist.artistImage)
                    return
                }
            }
            return
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.favouriteArtistsViewModel = FavouriteArtistsViewModel(view: self)
        if let artists = self.favouriteArtistsViewModel?.getFavouriteList() {
            self.favouriteArtists = artists
        }
        favCollectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.favCollectionView {
            if let favouriteArtists = favouriteArtists {
                 return favouriteArtists.count
            }
        }
        return 0
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reusableId1, for: indexPath as IndexPath)
        let favCell = cell as? FavouriteArtistCollectionViewCell
        if let favouriteArtists = favouriteArtists {
            let artist = favouriteArtists[indexPath.item]
            favCell?.artistName.text = artist.artistName
            favCell?.genre.text = ""
            favCell?.imageView.loadImageFromSource(source: artist.artistImage)
            if inEditMode {
                favCell?.deleteCheckBoxView.isHidden = false
            } else {
                favCell?.deleteCheckBoxView.isHidden = true
            }
            favCell?.deleteCheckBoxView.isChecked = false
            favCell?.deleteCheckBoxView.toggleButton.setImage(UIImage(named: "UnselectedDelete50px"), for: .normal)
        }
        return favCell!
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if !inEditMode {
            self.performSegue(withIdentifier: "FavouriteArtistToAlbumsSegue", sender: nil)
        } else {
            if let cell = favCollectionView.cellForItem(at: indexPath) as? FavouriteArtistCollectionViewCell {
                cell.deleteCheckBoxView.toggleCheck()
            }
        }
    }
    
    @IBAction func editFavouriteList(_ sender: UIButton) {
        if inEditMode { //if done clicked (exiting edit mode)
            let positions = getMarkedForDelete()
            if !positions.isEmpty {
                confirmDelete(positions)
            }
            exitEditMode()
        } else { //if edit clicked (entering edit mode)
            enterEditMode()
        }
        favCollectionView.reloadData()
    }
}
