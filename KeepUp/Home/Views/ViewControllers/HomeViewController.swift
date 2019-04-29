//
//  ViewController.swift
//  KeepUp
//
//  Created by Prateek Kambadkone on 2019/02/12.
//  Copyright © 2019 Prateek Kambadkone. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var topArtistsCollectionView: UICollectionView!
    @IBOutlet weak var popularSongsCollectionView: UICollectionView!
    @IBOutlet weak var topArtistsStackView: UIStackView!
    @IBOutlet weak var topArtistsLabelView: UIView!
    @IBOutlet weak var popularSongsLabelView: UIView!
    @IBOutlet weak var topArtistsLabel: UILabel!
    @IBOutlet weak var popularSongsLabel: UILabel!
    @IBOutlet weak var popularSongsStackView: UIStackView!
    
    let reusableId = "HomeCell"
    let reusableIdTopArtist = "TopArtistCell"
    let reusableIdPopularSong = "PopularSongCell"
    var selectedArtistPosition = -1
    var isLoadingAllFavourites = false
    
    var topArtistList: TopArtists? = nil
    var similarArtistList: SimilarArtists? = nil
    var popularSongList: PopularSongs? = nil
    var popularSongsLoaded: Int = 0
    var viewModelDelegate: HomeViewModelProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
//        setUpView1()
//        setUpView2()
        popularSongsLoaded = 0
        viewModelDelegate = HomeViewModel()
        viewModelDelegate?.viewControllerDelegate = self
        requestTopArtists()
    }
    
    
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        if isLoadingAllFavourites {
//            if selectedArtistPosition != -1 {
//                print("Selected artist is: \(selectedArtistPosition)")
//                self.performSegue(withIdentifier: "HomeToDiscographySegue", sender: nil)
//            }
//        } else {
//            self.mainScreenViewModel = MainScreenViewModel(view: self)
//            if let artists = self.mainScreenViewModel?.getFavouriteList() {
//                self.favouriteArtistList = artists
//            }
////            self.favCollectionView.reloadData()
//        }
//    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if let viewController = segue.destination as? DiscographyViewController {
//            loadAlbumsScreen(albumsViewController: viewController)
//        }
//        if let viewController = segue.destination as? ArtistInfoViewController {
//            loadArtistInfoScreen(artistInfoViewController: viewController)
//        }
    }
    
//    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
//        popularSongsCollectionView.layoutIfNeeded()
//        topArtistsCollectionView.layoutIfNeeded()
//    }
    @IBAction func addRemoveFavourites() {
//        toggleArtistSearched(searchedArtistName: searchedArtistName)
    }
    
    
}
