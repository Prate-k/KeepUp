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
    var numberMarkedForDelete = 0
    
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
    
    private func removeMarkedArtists (_ positions: [Int]) {
        for i in 0..<positions.count {
            FavouriteArtists.removeArtist(at: positions[i])
        }
        favCollectionView.reloadData()
    }
    
    private func confirmDelete(_ positions: [Int]) {
        let deleteAlert = UIAlertController(title: "Delete?", message: "All selected artists will be removed", preferredStyle: UIAlertController.Style.alert)
        
        deleteAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { _ in return}))
        
        deleteAlert.addAction(UIAlertAction(title: "Continue", style: .default, handler: { (_: UIAlertAction!) in
            self.removeMarkedArtists(positions)
        }))
        
        present(deleteAlert, animated: true, completion: nil)
    }
    
    private func getMarkedForDelete() -> [Int] {
        var positions = [Int]()
        for i in 0..<favCollectionView.numberOfItems(inSection: 0) {
            if let cell = favCollectionView.cellForItem(at: IndexPath.init(item: i, section: 0)) as? FavouriteArtistCollectionViewCell {
                if cell.deleteCheckBoxView.isChecked {
                    positions.append(i)
                }
            }
        }
        print(positions)
        return positions
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
