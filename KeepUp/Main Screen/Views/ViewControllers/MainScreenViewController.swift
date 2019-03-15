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
        if let viewController = segue.destination as? ArtistDetailsViewController {
            loadArtistDetailsScreen(artistDetailsViewController: viewController)
        }
        if let viewController = segue.destination as? ArtistInfoViewController {
            loadArtistInfoScreen(artistInfoViewController: viewController)
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

    @IBAction func searchArtist() {
        if let searchedText = searchText.text {
            if searchedText.isEmpty {
                showEmptySearchAlertDialog(viewController: self)
            } else {
                showResultView(searchedText: searchedText)
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
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.favCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reusableId1, for: indexPath as IndexPath)
            // Use the outlet in our custom class to get a reference to the UILabel in the cell
            if let artist = FavouriteArtists.getArtist(at: indexPath.item) {
                return setFavouriteArtistCellProperties(cell: cell, artist: artist)
            }
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reusableId2, for: indexPath as IndexPath)
            if let topTracksCell = cell as? TopTracksCollectionViewCell {
                // Use the outlet in our custom class to get a reference to the UILabel in the cell
                topTracksCell.songArtImageView.image = UIImage(named: "dummySong")
                topTracksCell.songTitleLabel.text = "song \(indexPath.item + 1)"
            }
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // handle tap events
        if collectionView == self.favCollectionView {
            self.performSegue(withIdentifier: "HomeToAlbumsSegue", sender: nil)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                 withReuseIdentifier: reusableHeaderId,
                                                 for: indexPath)
        
        if collectionView == favCollectionView {
            if favCollectionView.cellForItem(at: indexPath) != nil {
                if let headerView = rotateViewLeft(view: header) as? UICollectionReusableView {
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
