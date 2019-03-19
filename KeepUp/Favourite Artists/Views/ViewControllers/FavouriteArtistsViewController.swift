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
    
    var favouriteArtistList: [Artist] = []
    lazy var favouriteArtistsViewModel: FavouriteArtistsViewModel? = nil
    
    @IBOutlet weak var favCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navBar.setHidesBackButton(false, animated: true)
//        favCollectionView.reloadData()
        // Do any additional setup after loading the view.
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.favouriteArtistsViewModel = FavouriteArtistsViewModel(view: self)
        if let artists = self.favouriteArtistsViewModel?.getFavouriteList() {
            self.favouriteArtistList = artists
        }
        favCollectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.favCollectionView {
            return favouriteArtistList.count
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
        let artist = favouriteArtistList[indexPath.item]
        favCell?.artistName.text = artist.artistName
        favCell?.genre.text = artist.artistGenre
        favCell?.imageView.image = UIImage(named: "dummyArtist")
        if inEditMode {
            favCell?.deleteCheckBoxView.isHidden = false
//            if favCell?.deleteCheckBoxView.isChecked? {
//                favCell?.deleteCheckBoxView.toggleCheck()
//            }
        } else {
            favCell?.deleteCheckBoxView.isHidden = true
        }
        favCell?.deleteCheckBoxView.isChecked = false
        favCell?.deleteCheckBoxView.toggleButton.setImage(UIImage(named: "UnselectedDelete50px"), for: .normal)
        return favCell!
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // handle tap events
        if collectionView == self.favCollectionView {
            if !inEditMode {
                if let home = self.navigationController?.viewControllers[0] as? MainScreenViewController {
                    home.selectedArtistPosition = indexPath.item
                    home.isLoadingAllFavourites = true
                    self.navigationController?.popToRootViewController(animated: false)
                }
            } else {
                if let cell = favCollectionView.cellForItem(at: indexPath) as? FavouriteArtistCollectionViewCell {
                    cell.deleteCheckBoxView.toggleCheck()
                }
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
