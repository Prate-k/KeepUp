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
    var selectedAlbumPosition: Int?
    var selectedArtistPosition: Int?
    var selectedAlbum: Album!
    var songsList: [Song] = []
    var lastSelectedTrack: IndexPath = IndexPath.init(row: -1, section: -1)
    
    @IBOutlet weak var releaseDate: UILabel!
    @IBOutlet weak var albumImageView: UIImageView!
    @IBOutlet weak var albumName: UILabel!
    @IBOutlet weak var songsListTableView: UITableView!
    
    lazy var songsViewModel: SongsViewModel? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let indexAlbum = selectedAlbumPosition, let indexArtist = selectedArtistPosition {
            songsViewModel = SongsViewModel(view: self)
            DispatchQueue.global().async { [weak self] in
                if let self = self {
                    self.songsViewModel?.getAlbum(of: indexArtist, in: indexAlbum)
                }
            }
        } else {
            showEmptySearchAlertDialog(viewController: self)
        }
        // Do any additional setup after loading the view.
    }
    
    func numberOfSections(in collectionView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard selectedAlbumPosition != nil else {
            return 0
        }
        return selectedAlbum.albumTracks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: resusableId) as? SongTableViewCell else {
            fatalError("The dequeued cell is not an instance of SongTableViewCell.")
        }
        if  !songsList.isEmpty {
            let song = songsList[indexPath.row]
            cell.songTitle.text = song.songTitle
            cell.songLength.text = song.songLength
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
            } else {
                guard let oldCell = tableView.cellForRow(at: lastSelectedTrack) as? SongTableViewCell else {
                    fatalError("The dequeued cell is not an instance of SongTableViewCell.")
                }
                oldCell.displayOptions(oldCell.displayOptionsButton)
            }
        }
    }
    
}
