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
    var selectedSongTitle = ""  //lyrics title
    
    @IBOutlet weak var releaseDate: UILabel!
    @IBOutlet weak var albumImageView: UIImageView!
    @IBOutlet weak var albumName: UILabel!
    @IBOutlet weak var songsListTableView: UITableView!
    @IBOutlet weak var progressBar: UIActivityIndicatorView!
    
    var viewModelDelegate: SongsViewModelProtocol?
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
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
            }
        }
        cell.trackOptionsView.isHidden = true
        cell.displayOptionsButton.setImage(UIImage(named: "shiftLeft"), for: .normal)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Prev: \(lastSelectedTrack), curr: \(indexPath)")
        if lastSelectedTrack.row == -1 && lastSelectedTrack.section == -1 {
            lastSelectedTrack = indexPath
            guard let newCell = tableView.cellForRow(at: lastSelectedTrack) as? SongTableViewCell else {
                fatalError("The dequeued cell is not an instance of SongTableViewCell.")
            }
            newCell.displayOptions(newCell.displayOptionsButton)
            newCell.isSelected = true
            lastSelectedTrack = indexPath
            if let songTitle = newCell.songTitle.text {
                selectedSongTitle = songTitle
            }
        } else {
            if lastSelectedTrack != indexPath {
                guard let oldCell = tableView.cellForRow(at: lastSelectedTrack) as? SongTableViewCell else {
                    fatalError("The dequeued cell is not an instance of SongTableViewCell.")
                }
                oldCell.isSelected = false
                oldCell.displayOptions(oldCell.displayOptionsButton)
                guard let newCell = tableView.cellForRow(at: indexPath) as? SongTableViewCell else {
                    fatalError("The dequeued cell is not an instance of SongTableViewCell.")
                }
                newCell.displayOptions(newCell.displayOptionsButton)
                lastSelectedTrack = indexPath
                if let songTitle = newCell.songTitle.text {
                    selectedSongTitle = songTitle
                }
            } else {
                guard let oldCell = tableView.cellForRow(at: lastSelectedTrack) as? SongTableViewCell else {
                    fatalError("The dequeued cell is not an instance of SongTableViewCell.")
                }
                oldCell.displayOptions(oldCell.displayOptionsButton)
                if let songTitle = oldCell.songTitle.text {
                    selectedSongTitle = songTitle
                }
            }
        }
    }
}
