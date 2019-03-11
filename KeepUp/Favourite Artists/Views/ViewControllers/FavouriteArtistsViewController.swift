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
    let reusableId1 = "FavArtistCell"
    var inEditMode = false
    
    @IBOutlet weak var favCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        favCollectionView.reloadData()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        favCollectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.favCollectionView {
            return FavouriteArtists.getSize()
        }
        return 0
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reusableId1, for: indexPath as IndexPath)
        let favCell = cell as? FavouriteArtistCollectionViewCell
        let artist = FavouriteArtists.getArtist(at: indexPath.item)!
        favCell?.artistName.text = artist.artistName
        favCell?.genre.text = artist.artistGenre
        favCell?.imageView.image = UIImage(named: "dummyArtist")
        if inEditMode {
            favCell?.deleteCheckBoxView.isHidden = false
            favCell?.deleteCheckBoxView.toggleButton.setImage(UIImage(named: "UnselectedDelete50px"), for: .normal)
        } else {
            
            favCell?.deleteCheckBoxView.isHidden = true
        }
        favCell?.deleteCheckBoxView.isChecked = false
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
                    cell.deleteCheckBoxView.toggleSelection(cell.deleteCheckBoxView.toggleButton)
                }
            }
        }
    }
    
    @IBAction func editFavouriteList(_ sender: UIButton) {
        let numSelected  =  DeleteCheckBoxView.getNumberMarkedForDelete() //get number of checkboxes selected
        if inEditMode { //if done clicked (exiting edit mode)
            confirmDelete(numberSelected: numSelected)//confirm for delete
        } else { //if edit clicked (entering edit mode)
            enterEditMode()
        }
        DeleteCheckBoxView.resetMarkedCounter()
    }
    
    private func removeSelectedArtists(numberSelected: Int) {
        if numberSelected >= 0 {
            for i in 0..<favCollectionView.numberOfItems(inSection: 0) {
                let cell = favCollectionView.cellForItem(at: IndexPath.init(item: i, section: 0)) as? FavouriteArtistCollectionViewCell
                if let cell = cell {
                    if cell.deleteCheckBoxView.isChecked {
                        print("deleting: \(cell.artistName.text!)")
                        FavouriteArtists.removeArtist(at: i)
                    }
                }
            }
        }
        favCollectionView.reloadData()
        exitEditMode()
    }
    
    private func confirmDelete(numberSelected: Int) {
        if numberSelected == 0 { //if none to delete... return
            return
        }
        var deleteAlert = UIAlertController(title: "Delete?", message: "All selected artists will be removed", preferredStyle: UIAlertController.Style.alert)
        
        deleteAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
            self.exitEditMode()
        }))
        
        deleteAlert.addAction(UIAlertAction(title: "Continue", style: .default, handler: { (action: UIAlertAction!) in
            self.removeSelectedArtists(numberSelected: numberSelected)
        }))
        
        present(deleteAlert, animated: true, completion: nil)
    }
    
    private func enterEditMode() {
        inEditMode = true //change to edit mode
        editNavButton.title = "Done"
        favCollectionView.reloadData()
    }
    
    private func exitEditMode() {
        inEditMode = false //change to view mode
        editNavButton.title = "Edit"
        favCollectionView.reloadData()
    }
}

