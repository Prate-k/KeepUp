//
//  ViewController.swift
//  KeepUp
//
//  Created by Prateek Kambadkone on 2019/02/12.
//  Copyright © 2019 Prateek Kambadkone. All rights reserved.
//

import UIKit



class MainScreenViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    let reusableId = "FavArtistCell"
    
    var selectedArtistPosition = -1
    
    @IBOutlet weak var searchText: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var resultView: UIView!
    @IBOutlet weak var resultImageView: UIImageView!
    @IBOutlet weak var resultArtistLabel: UILabel!
    @IBOutlet weak var resultGenreLabel: UILabel!
    @IBOutlet weak var detailsView: UIView!
    @IBOutlet weak var detailsExpandCollapseImage: UIImageView!
    @IBOutlet weak var detailsDropDownLable: UILabel!
    @IBOutlet weak var favouriteUnfavouriteButton: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        resultView.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView.reloadData()
        resultImageView.image = nil
        resultArtistLabel.text = ""
        resultGenreLabel.text = ""
        favouriteUnfavouriteButton.imageView?.image = UIImage(named: "unfav")
        resultView.isHidden = true
        searchText.text = ""
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let navigationController = segue.destination as? UINavigationController ,
         let artistDetailsViewController = navigationController.viewControllers.first as? ArtistDetailsViewController {
            artistDetailsViewController.selectedArtistPosition = collectionView.indexPathsForSelectedItems?[0].item
        } else {
            return
        }
    }
    
    @IBAction func addRemoveFavourites() {
        
        let index = isArtistInFavouriteList(name: resultArtistLabel.text!)
        
        if index == -1 {
            favouriteUnfavouriteButton.setImage(UIImage(named: "fav"), for: .normal)
            addToFavouritesList()
        } else {
            favouriteUnfavouriteButton.setImage(UIImage(named: "unfav"), for: .normal)
            removeFromFavouritesList()
        }
    }
    
    @IBAction func clearSearch() {
        resultImageView.image = nil
        resultArtistLabel.text = ""
        resultGenreLabel.text = ""
        favouriteUnfavouriteButton.imageView?.image = UIImage(named: "unfav")
        resultView.isHidden = true
        searchText.text = ""
    }
    
    private func isArtistInFavouriteList (name: String) -> Int {
        var index = -1
        for i in 0..<FavouriteArtists.size {
            if FavouriteArtists.getArtist(at:i)!.name.elementsEqual(resultArtistLabel.text!) {
                index = i
                break
            }
        }
        return index
    }
    
    private func addToFavouritesList() {
        let index = isArtistInFavouriteList(name: resultArtistLabel.text!)
        if index != -1 {
            return
        }
        
        let newArtist = Artist(name: resultArtistLabel.text, genre: resultGenreLabel.text, image: resultImageView.image)
        
        if let x = newArtist {
            FavouriteArtists.addArtist(artist: x)
            printToTempText()
            collectionView.reloadData()
        }
    }
    
    private func removeFromFavouritesList() {
        let index = isArtistInFavouriteList(name: resultArtistLabel.text!)
        if  index == -1 {
            return
        } else {
            FavouriteArtists.removeArtist(at: index)
            printToTempText()
            collectionView.reloadData()
        }
        
    }
    
    private func printToTempText() {
        var str = ""
        for i in 0..<FavouriteArtists.size {
            str.append(FavouriteArtists.getArtist(at: i)!.name + ", ")
        }
    }
    
    @IBAction func searchArtist() {
        let searchedText = searchText.text
        
        if searchedText?.isEmpty ?? true {
            let alert = UIAlertController(title: "Empty Search", message: "Seach field is empty - Please enter an artist's name.", preferredStyle: .alert)
            let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
        } else {
            resultView.isHidden = false
            resultArtistLabel.text = searchedText
            resultGenreLabel.text = "Random"
            resultImageView.image = UIImage(named: "dummyArtist")
            
            if isArtistInFavouriteList(name: searchedText!) != -1 {
                favouriteUnfavouriteButton.setImage(UIImage(named: "fav"), for: .normal)
            } else {
                favouriteUnfavouriteButton.setImage(UIImage(named: "unfav"), for: .normal)
            }
        }
    }
    

    @IBAction func detailsViewPressed() {
        let image = detailsExpandCollapseImage.image
        
        if (image?.isEqual(UIImage(named: "expand")))! {
            detailsExpandCollapseImage.image = UIImage(named: "collapse")
        } else {
            detailsExpandCollapseImage.image = UIImage(named: "expand")
        }
    }
    
    // tell the collection view how many cells to make
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return FavouriteArtists.getSize()
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
//    // make a cell for each cell index path
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reusableId, for: indexPath as IndexPath) as! FavouriteArtistCollectionViewCell
        
        // Use the outlet in our custom class to get a reference to the UILabel in the cell
        let artist = FavouriteArtists.getArtist(at: indexPath.item)!
        cell.artistName.text = artist.name
        cell.genre.text = artist.genre
        cell.imageView.image = artist.image
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // handle tap events
            print(indexPath.item)
    }
}

