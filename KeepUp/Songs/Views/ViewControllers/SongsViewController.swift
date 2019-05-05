//
//  AlbumDetailsViewController.swift
//  KeepUp
//
//  Created by Prateek Kambadkone on 2019/02/15.
//  Copyright © 2019 Prateek Kambadkone. All rights reserved.
//

import UIKit

class SongsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    let resusableId = "songCell"
    var selectedAlbum: SelectedAlbum?   //store details locally
    var songs: Songs?
    var lastSelectedTrack: IndexPath = IndexPath.init(row: -1, section: -1) //tableView animation
    var selectedSongTitle = ""  //for playing and lyrics screen
    
    @IBOutlet weak var releaseDate: UILabel!
    @IBOutlet weak var albumImageView: UIImageView!
    @IBOutlet weak var albumName: UILabel!
    @IBOutlet weak var songsListTableView: UITableView!
    @IBOutlet weak var progressBar: UIActivityIndicatorView!
    
    var viewModelDelegate: SongsViewModelProtocol?
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if selectedSongTitle.isEmpty {
            return
        }
        if let viewController = segue.destination as? LyricsViewController {
            loadLyricsScreen(lyricsViewController: viewController)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let selectedAlbum = self.selectedAlbum {
            showSelectedAlbum(album: selectedAlbum)
            viewModelDelegate = SongsViewModel()
            viewModelDelegate?.viewControllerDelegate = self
            DispatchQueue.global().async { [weak self] in
                if let self = self {
                    self.viewModelDelegate?.getSongs(of: selectedAlbum.albumID)
                }
            }
        } else {
            showEmptySearchAlertDialog(viewController: self)
        }
    }
    
    func numberOfSections(in collectionView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let songs = self.songs {
            return songs.count()
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: resusableId) as? SongTableViewCell else {
            fatalError("The dequeued cell is not an instance of SongTableViewCell.")
        }
        if let songs = self.songs {
            if let song = songs.get(i: indexPath.item) {
                cell.songTitle.text = song.songName
                cell.songLength.text = song.songLengthText
                cell.viewControllerDelegate = self
            }
        }
        return cell
    }
}
