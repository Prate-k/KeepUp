//
//  ArtistDetailsViewController.swift
//  KeepUp
//
//  Created by Prateek Kambadkone on 2019/02/15.
//  Copyright © 2019 Prateek Kambadkone. All rights reserved.
//

import UIKit

class ArtistDetailsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let resusableId = "albumCell"
    var selectedArtistPosition: Int?
    var selectedArtist: Artist!
    
    @IBOutlet weak var artistImageView: UIImageView!
    @IBOutlet weak var artistName: UILabel!
    @IBOutlet weak var genre: UILabel!
    @IBOutlet weak var albumsListTable: UITableView!
    @IBOutlet weak var favouriteUnfavouriteButton: UIButton!
    
    @IBAction func returnToPreviousScreen(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let index = selectedArtistPosition {
            
            selectedArtist = FavouriteArtists.getArtist(at: index)
            artistImageView.image = UIImage(named: "dummyAlbum")    //replace with artistImage.image = selectedArtist.image
            artistName.text = selectedArtist.name
            genre.text = selectedArtist.genre
        } else {
            let alert = UIAlertController(title: "Load Failed!", message: "Could not load albums for artist", preferredStyle: .alert)
            let action = UIAlertAction(title: "Ok", style: .default, handler: {
                action in
                self.dismiss(animated: true, completion: nil)
            })
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
        }
        
    }
    
    func numberOfSections(in collectionView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard selectedArtistPosition != nil else {
            return 0
        }
        return selectedArtist.albums.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: resusableId) as? AlbumDetailsTableViewCell else {
            fatalError("The dequeued cell is not an instance of MealTableViewCell.")
        }
        
        let albums = selectedArtist.albums
        if  albums.count > 0 {
            let album = albums[indexPath.row]
            cell.albumImageView.image = album.albumArt
            cell.albumName.text = album.albumName
            cell.releasedDate.text = "\(album.released.month) \(album.released.year)"
        }
        
        return cell
    }
    
    @IBAction func addRemoveFavourites() {
        
        let index = isArtistInFavouriteList(name: selectedArtist.name)
        
        if index == -1 {
            favouriteUnfavouriteButton.setImage(UIImage(named: "fav"), for: .normal)
            addToFavouritesList()
        } else {
            favouriteUnfavouriteButton.setImage(UIImage(named: "unfav"), for: .normal)
            removeFromFavouritesList()
        }
    }
    
    private func isArtistInFavouriteList (name: String) -> Int {
        var index = -1
        for i in 0..<FavouriteArtists.size {
            if FavouriteArtists.getArtist(at: i)!.name.elementsEqual(selectedArtist.name) {
                index = i
                break
            }
        }
        return index
    }
    
    private func addToFavouritesList() {
        let index = isArtistInFavouriteList(name: selectedArtist.name)
        if index != -1 {
            return
        }
        
        let newArtist = Artist(name: selectedArtist.name, genre: selectedArtist.genre, image: selectedArtist.image)
        
        if let x = newArtist {
            FavouriteArtists.addArtist(artist: x)
        }
    }
    
    private func removeFromFavouritesList() {
        let index = isArtistInFavouriteList(name: selectedArtist.name)
        if  index == -1 {
            return
        } else {
            FavouriteArtists.removeArtist(at: index)
        }
        
    }
    
    
    

}
