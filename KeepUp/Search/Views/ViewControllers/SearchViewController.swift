//
//  SearchViewController.swift
//  KeepUp
//
//  Created by Prateek Kambadkone on 2019/04/19.
//  Copyright © 2019 Prateek Kambadkone. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {

    var viewModelDelegate: SearchViewModelProtocol?
    var searchResults: SearchResults?
    var isWaitingResult: Bool = false
    
    @IBOutlet weak var resultsTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModelDelegate = SearchViewModel()
        viewModelDelegate?.viewControllerDelegate = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let albumsViewController = segue.destination as? DiscographyViewController {
            if let index = resultsTableView.indexPathForSelectedRow?.item {
                if let searchResults = searchResults {
                    if let selected = searchResults.get(i: index) {
                        albumsViewController.selectedArtist = SelectedArtist(artistID: selected.artistID, artistName: selected.artistName, artistImage: selected.artistThumbnail)
                        return
                    }
                }
            }
            return
        }
    }
}
