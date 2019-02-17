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
    @IBOutlet weak var navItem: UINavigationItem!
    
    @IBAction func returnToPreviousScreen(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let indexAlbum = selectedAlbumPosition, let indexArtist = selectedArtistPosition{
            
            selectedAlbum = FavouriteArtists.getArtist(at: indexArtist)!.albums[indexAlbum]
            albumImageView.image = UIImage(named: "dummyAlbum")    //replace with artistImage.image = selectedArtist.image
            albumName.text = selectedAlbum.albumName
            releaseDate.text = "\(selectedAlbum.released.month) \(selectedAlbum.released.year)"
            
            selectedAlbum.songs.append(Song(songTitle: "song 1", lyrics: "", length: "3:45"))
            
            selectedAlbum.songs.append(Song(songTitle: "song 2", lyrics: "", length: "3:47"))
            
            selectedAlbum.songs.append(Song(songTitle: "song 3", lyrics: "", length: "3:48"))
            
            navItem.title = "\(FavouriteArtists.getArtist(at: indexArtist)!.name!) > \(selectedAlbum.albumName) > "
        } else {
            let alert = UIAlertController(title: "Load Failed!", message: "Could not load songs for album", preferredStyle: .alert)
            let action = UIAlertAction(title: "Ok", style: .default, handler: {
                action in
                self.dismiss(animated: true, completion: nil)
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
        return selectedAlbum.songs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: resusableId) as? SongTableViewCell else {
            fatalError("The dequeued cell is not an instance of MealTableViewCell.")
        }
        
        let songs = selectedAlbum.songs
        if  songs.count > 0 {
            let song = songs[indexPath.row]
            cell.songTitle.text = song.songTitle
            cell.songLength.text = "3:45"
        }
        
        return cell
    }
    


}
