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
        
        if let indexAlbum = selectedAlbumPosition, let indexArtist = selectedArtistPosition{
            
            let selectedArtist = FavouriteArtists.getArtist(at: indexArtist)
            selectedAlbum = selectedArtist?.artistAlbums[indexAlbum]
            albumImageView.image = UIImage(named: "dummyAlbum")    //replace with artistImage.image = selectedArtist.image
            albumName.text = selectedAlbum.albumName
            releaseDate.text = "\(selectedAlbum.albumReleaseDate.releasedMonth) \(selectedAlbum.albumReleaseDate.releasedYear)"
            
            selectedAlbum.albumTracks.append(Song(songTitle: "song 1", songLyrics: "", songLength: "3:45"))
            
            selectedAlbum.albumTracks.append(Song(songTitle: "song 2", songLyrics: "", songLength: "3:47"))
            
            selectedAlbum.albumTracks.append(Song(songTitle: "song 3", songLyrics: "", songLength: "3:48"))
            
        } else {
            let alert = UIAlertController(title: "Load Failed!", message: "Could not load songs for album", preferredStyle: .alert)
            let action = UIAlertAction(title: "Ok", style: .default, handler: {
                action in
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
            fatalError("The dequeued cell is not an instance of MealTableViewCell.")
        }
        
        let songs = selectedAlbum.albumTracks
        if  songs.isEmpty {
            let song = songs[indexPath.row]
            cell.songTitle.text = "song \(indexPath.row+1)"
            cell.songLength.text = "3:4\(5+indexPath.row)"
        }
        
        return cell
    }
    


}
