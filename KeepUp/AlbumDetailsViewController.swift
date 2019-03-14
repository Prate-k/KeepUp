//
//  AlbumDetailsViewController.swift
//  KeepUp
//
//  Created by Prateek Kambadkone on 2019/02/15.
//  Copyright © 2019 Prateek Kambadkone. All rights reserved.
//

import UIKit

class AlbumDetailsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    let resusableId = "songCell"
    var selectedAlbumPosition: Int?
    var selectedArtistPosition: Int?
    var selectedAlbum: Album!
    
    @IBOutlet weak var releaseDate: UILabel!
    @IBOutlet weak var albumImageView: UIImageView!
    @IBOutlet weak var albumName: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let indexAlbum = selectedAlbumPosition, let indexArtist = selectedArtistPosition {
            
            let selectedArtist = FavouriteArtists.getArtist(at: indexArtist)
            selectedAlbum = selectedArtist?.artistAlbums[indexAlbum]
            albumImageView.image = UIImage(named: "dummyAlbum")    //replace with artistImage.image = selectedArtist.image
            albumName.text = selectedAlbum.albumName
            releaseDate.text = "\(selectedAlbum.albumReleaseDate.releasedMonth) \(selectedAlbum.albumReleaseDate.releasedYear)"
            
            selectedAlbum.albumTracks.append(Song(songTitle: "song 1", songLyrics: "", songLength: "3:45", isHidden: false))
            
            selectedAlbum.albumTracks.append(Song(songTitle: "song 2", songLyrics: "", songLength: "3:47", isHidden: false))
            
            selectedAlbum.albumTracks.append(Song(songTitle: "song 3", songLyrics: "", songLength: "3:48", isHidden: false))
            
        } else {
            let alert = UIAlertController(title: "Load Failed!", message: "Could not load songs for album", preferredStyle: .alert)
            let action = UIAlertAction(title: "Ok", style: .default, handler: { _ in
                self.navigationController?.popViewController(animated: true)
            })
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
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
        let songs = selectedAlbum.albumTracks
        if  songs.isEmpty {
            _ = songs[indexPath.row]
            cell.songTitle.text = "song \(indexPath.row+1)"
            cell.songLength.text = "3:4\(5+indexPath.row)"
        }
        cell.trackOptionsView.isHidden = true
        cell.displayOptionsButton.setImage(UIImage(named: "shiftLeft"), for: .normal)
        return cell
    }
    
    var lastSelectedTrack: IndexPath = IndexPath.init(row: -1, section: -1)
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
