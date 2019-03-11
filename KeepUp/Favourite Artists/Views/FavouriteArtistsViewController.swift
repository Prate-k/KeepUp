//
//  FavouriteArtistsViewController.swift
//  KeepUp
//
//  Created by Prateek Kambadkone on 2019/03/10.
//  Copyright © 2019 Prateek Kambadkone. All rights reserved.
//

import UIKit

class FavouriteArtistsViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    let reusableId1 = "FavArtistCell"
    
    @IBOutlet weak var favCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
        if collectionView == self.favCollectionView {
            let favCell = cell as? FavouriteArtistCollectionViewCell

            // Use the outlet in our custom class to get a reference to the UILabel in the cell
            let artist = FavouriteArtists.getArtist(at: indexPath.item)!
            favCell?.artistName.text = artist.artistName
            favCell?.genre.text = artist.artistGenre
            favCell?.imageView.image = UIImage(named: "dummyArtist")
            return favCell!
        }
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // handle tap events
        if collectionView == self.favCollectionView {
            self.performSegue(withIdentifier: "FavArtistToAlbumsSegue", sender: nil)
        }
    }
}
