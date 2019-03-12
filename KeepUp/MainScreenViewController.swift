//
//  ViewController.swift
//  KeepUp
//
//  Created by Prateek Kambadkone on 2019/02/12.
//  Copyright © 2019 Prateek Kambadkone. All rights reserved.
//

import UIKit

class MainScreenViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    let reusableId1 = "FavArtistCell"
    let reusableId2 = "TopTracksCell"
    let reusableHeaderId = "ViewAllFavHeader"
    var favCollectionViewCellSize: CGSize!
    var selectedArtistPosition = -1
    var isLoadingAllFavourites = false
    
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
    @IBOutlet weak var favCollectionView: UICollectionView!
    @IBOutlet weak var dropDownView: UIView! 
    @IBOutlet weak var topTracksCollectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        resultView.isHidden = true
        let layout = favCollectionView.collectionViewLayout as? UICollectionViewFlowLayout
        layout?.sectionHeadersPinToVisibleBounds = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if isLoadingAllFavourites {
            if selectedArtistPosition != -1 {
                clearSearch()
                print("Selected artist is: \(selectedArtistPosition)")
                self.performSegue(withIdentifier: "HomeToAlbumsSegue", sender: nil)
            }
        } else {
            favCollectionView.reloadData()
            topTracksCollectionView.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let artistDetailsViewController = segue.destination as? ArtistDetailsViewController {
            if isLoadingAllFavourites {
                artistDetailsViewController.selectedArtistPosition = selectedArtistPosition
            } else {
                if let index = favCollectionView.indexPathsForSelectedItems?[0].item {
                    artistDetailsViewController.selectedArtistPosition = index
                }
            }
            isLoadingAllFavourites = false
        }
        if let artistInfoDetailsViewController = segue.destination as? ArtistInfoViewController {
            if let name = resultArtistLabel.text {
                artistInfoDetailsViewController.artistName.append("\(name)")
                return
            }
        }
    }
    
    @IBAction func addRemoveFavourites() {
        let index = FavouriteArtists.isArtistInFavouriteList(name: resultArtistLabel.text!)
        if index == -1 {
            addToFavouritesList()
        } else {
            removeFromFavouritesList(index: index)
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

    
    private func addToFavouritesList() {
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
    
    private func removeFromFavouritesList(index: Int) {
        if favouriteUnfavouriteButton.imageView?.image == UIImage(named: "fav") {
            favouriteUnfavouriteButton.setImage(UIImage(named: "unfav"), for: .normal)
        }
        FavouriteArtists.removeArtist(at: index)
        favCollectionView.reloadData()
        topTracksCollectionView.reloadData()
    }
    @IBAction func searchArtist() {
        let searchedText = searchText.text
        if searchedText?.isEmpty ?? true {
            let alert = UIAlertController(title: "Empty Search",
                            message: "Seach field is empty - Please enter an artist's name.", preferredStyle: .alert)
            let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
        } else {
            resultView.isHidden = false
            resultArtistLabel.text = searchedText
            resultGenreLabel.text = "Random"
            resultImageView.image = UIImage(named: "dummyArtist")
            if FavouriteArtists.isArtistInFavouriteList(name: searchedText!) != -1 {
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
            dropDownView.isHidden = false
        } else {
            detailsExpandCollapseImage.image = UIImage(named: "expand")
            dropDownView.isHidden = true
        }
    }
    
    @IBAction func loadAllFavouriteArtists() {
        self.performSegue(withIdentifier: "HomeToFavArtistsSegue", sender: nil)
    }
    // tell the collection view how many cells to make
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.favCollectionView {
            return FavouriteArtists.getSize()
        }
        if collectionView == self.topTracksCollectionView {
            return FavouriteArtists.getSize()
        }
        return 0
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    //    // make a cell for each cell index path
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.favCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reusableId1, for: indexPath as IndexPath) as? FavouriteArtistCollectionViewCell
            
            // Use the outlet in our custom class to get a reference to the UILabel in the cell
            let artist = FavouriteArtists.getArtist(at: indexPath.item)!
            cell?.artistName.text = artist.artistName
            cell?.genre.text = artist.artistGenre
            cell?.imageView.image = UIImage(named: "dummyArtist")
            favCollectionViewCellSize = cell?.frame.size
            return cell!
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reusableId2, for: indexPath as IndexPath) as? TopTracksCollectionViewCell
            
            // Use the outlet in our custom class to get a reference to the UILabel in the cell
            cell?.songArtImageView.image = UIImage(named: "dummySong")
            cell?.songTitleLabel.text = "song \(indexPath.item + 1)"
            return cell!
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // handle tap events
        if collectionView == self.favCollectionView {
            self.performSegue(withIdentifier: "HomeToAlbumsSegue", sender: nil)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: reusableHeaderId, for: indexPath)
        
        if collectionView == favCollectionView {
            if (favCollectionView.cellForItem(at: indexPath) != nil)
            {
                let headerView = header as? FavouriteArtistsCollectionViewHeader
                if let headerView = headerView {
                    headerView.viewAllView.isHidden = false
                    headerView.viewAllView.transform = CGAffineTransform.init(rotationAngle: -CGFloat.pi/2)
                    headerView.frame.size.height = favCollectionViewCellSize.height
                    headerView.viewAllView.frame.size.width = favCollectionViewCellSize.height
                    headerView.viewAllLabel.frame.size.width = favCollectionViewCellSize.height
                    return headerView
                }
            } else {
                let headerView = header as? FavouriteArtistsCollectionViewHeader
                if let headerView = headerView {
                    headerView.viewAllView.isHidden = true
                    return headerView
                }
            }
        }
        return header
    }
}

