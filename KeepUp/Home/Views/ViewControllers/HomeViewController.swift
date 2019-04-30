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
    
    var topArtistList: TopArtists?
    var similarArtistList: SimilarArtists?
    var popularSongList: PopularSongs?
    var popularSongsLoaded: Int = 0
    var viewModelDelegate: HomeViewModelProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        popularSongsLoaded = 0
        viewModelDelegate = HomeViewModel()
        viewModelDelegate?.viewControllerDelegate = self
        requestTopArtists()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let viewController = segue.destination as? DiscographyViewController {
            loadAlbumsScreen(albumsViewController: viewController)
            return
        }
        if let viewController = segue.destination as? SongsViewController {
            loadSongsScreen(songsViewController: viewController)
            return
        }
    }
    
    @IBAction func addRemoveFavourites() {
    }
}
