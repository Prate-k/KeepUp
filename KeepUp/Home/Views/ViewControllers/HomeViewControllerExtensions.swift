//
//  MainScreenViewControllerExtensions.swift
//  KeepUp
//
//  Created by Prateek Kambadkone on 2019/03/14.
//  Copyright © 2019 Prateek Kambadkone. All rights reserved.
//

import Foundation
import UIKit

protocol HomeViewControllerProtocol: class {
    var viewModelDelegate: HomeViewModelProtocol? { get set }
    func updateTopArtists(results: TopArtists)
    func updatePopularSong(result: PopularSong, rank: Int)
    func resultsFailure(error: Errors)
}

extension HomeViewController {
    func setUpView1() {
        var shadowLayer: CAShapeLayer!
        let fillColour: UIColor = .white
        let bounds = topArtistsLabelView.layer.bounds

        if shadowLayer == nil {
            shadowLayer = CAShapeLayer()
            shadowLayer.path = UIBezierPath(roundedRect: bounds,  cornerRadius: 0.0).cgPath
            shadowLayer.fillColor = fillColour.cgColor
            shadowLayer.shadowColor = UIColor.black.cgColor
            shadowLayer.shadowPath = shadowLayer.path
            shadowLayer.shadowOffset = CGSize(width: 0, height: 1.0)
            shadowLayer.shadowOpacity = 0.5
            shadowLayer.shadowRadius = 1

            topArtistsLabelView.layer.insertSublayer(shadowLayer, at: 0)
            topArtistsLabelView.layer.masksToBounds = false
        }
    }
    
    func setUpView2() {
        var shadowLayer: CAShapeLayer!
        let fillColour: UIColor = .white
        let bounds = popularSongsLabelView.layer.bounds
        
        if shadowLayer == nil {
            shadowLayer = CAShapeLayer()
            shadowLayer.path = UIBezierPath(roundedRect: bounds,  cornerRadius: 0.0).cgPath
            shadowLayer.fillColor = fillColour.cgColor
            shadowLayer.shadowColor = UIColor.black.cgColor
            shadowLayer.shadowPath = shadowLayer.path
            shadowLayer.shadowOffset = CGSize(width: 0, height: 1.0)
            shadowLayer.shadowOpacity = 0.5
            shadowLayer.shadowRadius = 1
            
            popularSongsLabelView.layer.insertSublayer(shadowLayer, at: 0)
            popularSongsLabelView.layer.masksToBounds = false
        }
    }

    func requestTopArtists() {
        self.viewModelDelegate?.getTopArtistsFromRepository()
    }
    
    func requestPopularSongs() {
        popularSongsLoaded = 0
        if let topArtistlist = self.topArtistList {
            for i in 0..<topArtistlist.count() {
                if let topArtist = topArtistlist.get(i: i) {
                    if let artistID = topArtist.artistID {
                        self.viewModelDelegate?.getPopularSongsFromRepository(artistID: artistID, artistRank: i)
                    }
                }
            }
        }
        
    }
    
    func updateTopArtistsCollectionView() {
        DispatchQueue.main.async {
            self.topArtistsCollectionView.reloadData()
        }
        if !hasRequestedSongs {
            requestPopularSongs()
            hasRequestedSongs = true
        }
    }
    
    func updatePopularSongsCollectionView() {
        DispatchQueue.main.async {
            self.popularSongsCollectionView.reloadData()
        }
    }
    
    func setTopArtistCellProperties(cell: UICollectionViewCell, topArtist: TopArtist) -> UICollectionViewCell {
        if let topArtistCell = cell as? HomeCollectionViewCell {
            topArtistCell.label1.text = topArtist.artistName

            if let image = topArtist.artistThumbnail {
                topArtistCell.imageView.loadImageFromSource(source: image)
            }
            topArtistCell.imageView.layer.cornerRadius = 16.0
            topArtistCell.imageView.clipsToBounds = true
            topArtistCell.textLabels.layer.cornerRadius = 16.0

            topArtistCell.layer.cornerRadius = 16.0

            var shadowLayer: CAShapeLayer!
            let cornerRadius: CGFloat = 16.0
            let fillColour: UIColor = .white
            let bounds = topArtistCell.layer.bounds

            if shadowLayer == nil {
                shadowLayer = CAShapeLayer()
                shadowLayer.path = UIBezierPath(roundedRect: bounds,  cornerRadius: cornerRadius).cgPath
                shadowLayer.fillColor = fillColour.cgColor
                shadowLayer.shadowColor = UIColor.black.cgColor
                shadowLayer.shadowPath = shadowLayer.path
                shadowLayer.shadowOffset = CGSize(width: 0, height: 1)
                shadowLayer.shadowOpacity = 0.5
                shadowLayer.shadowRadius = 4

                topArtistCell.layer.insertSublayer(shadowLayer, at: 0)
                topArtistCell.layer.masksToBounds = false
            }
            return topArtistCell
        }
        return cell
    }
    
    func setPopularSongCellProperties(cell: UICollectionViewCell, popularSong: PopularSong) -> UICollectionViewCell {
        if let popularSongCell = cell as? HomeCollectionViewCell {
            popularSongCell.label1.text = popularSong.songTitle
            popularSongCell.label2.text =  popularSong.artist?.artistName
            
            if let imageLink = popularSong.album?.albumCover {
                popularSongCell.imageView.loadImageFromSource(source: imageLink)
            } else {
                popularSongCell.imageView.image = UIImage(named: "dummySong")
            }
            
            popularSongCell.imageView.layer.cornerRadius = 16.0
            popularSongCell.imageView.clipsToBounds = true
            popularSongCell.textLabels.layer.cornerRadius = 16.0
            
            popularSongCell.layer.cornerRadius = 16.0
            
            var shadowLayer: CAShapeLayer!
            let cornerRadius: CGFloat = 16.0
            let fillColour: UIColor = .white
            let bounds = popularSongCell.layer.bounds
            
            if shadowLayer == nil {
                shadowLayer = CAShapeLayer()
                shadowLayer.path = UIBezierPath(roundedRect: bounds,  cornerRadius: cornerRadius).cgPath
                shadowLayer.fillColor = fillColour.cgColor
                shadowLayer.shadowColor = UIColor.black.cgColor
                shadowLayer.shadowPath = shadowLayer.path
                shadowLayer.shadowOffset = CGSize(width: 0, height: 1)
                shadowLayer.shadowOpacity = 0.5
                shadowLayer.shadowRadius = 8
                
                popularSongCell.layer.insertSublayer(shadowLayer, at: 0)
                popularSongCell.layer.masksToBounds = false
            }
            return popularSongCell
        }
        return cell
    }
    
    func loadAlbumsScreen(albumsViewController: DiscographyViewController) {
        if let index = topArtistsCollectionView.indexPathsForSelectedItems?[0].item {
            if let topArtists = self.topArtistList {
                if let artist = topArtists.get(i: index) {
                    albumsViewController.selectedArtist = SelectedArtist(artistID: artist.artistID,
                                                                         artistName: artist.artistName,
                                                                         artistImage: artist.artistThumbnail)
                }
            }
        }
    }
    
    func loadSongsScreen (songsViewController: SongsViewController) {
        if let index = popularSongsCollectionView.indexPathsForSelectedItems?[0].item {
            if let topSongs = self.popularSongList {
                if let song = topSongs.get(i: index) {
                    if let album = song.album, let artist = song.artist {
                        songsViewController.selectedAlbum = SelectedAlbum(albumID: album.albumID,
                                                                          albumName: album.albumName,
                                                                          albumImage: album.albumCover,
                                                                          artistName: artist.artistName)
                    }
                }
            }
        }
    }
}

extension HomeViewController: HomeViewControllerProtocol {
    func updateTopArtists(results: TopArtists) {
        self.topArtistList = results
        updateTopArtistsCollectionView()
    }
    
    func updatePopularSong(result: PopularSong, rank: Int) {
        
        DispatchQueue.main.async {
            if self.popularSongList == nil {
                self.popularSongList = PopularSongs()
                for _ in 0..<10 {
                    self.popularSongList?.results.append(PopularSong())
                }
            }
            self.popularSongList?.set(result, at: rank)
            if self.popularSongsLoaded < 9 {
                self.popularSongsLoaded += 1
            } else {
                self.updatePopularSongsCollectionView()
            }
            self.updateTopArtistsCollectionView()
            self.updatePopularSongsCollectionView()
        }
        
    }
    
    func resultsFailure(error: Errors) {
    }
}

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.topArtistsCollectionView {
            if let topArtistList = topArtistList {
                return topArtistList.count()
            }
        } else {
            if collectionView == self.popularSongsCollectionView {
                if let popularSongList = topArtistList {
                    return popularSongList.count()
                }
            }
        }
        return 0
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reusableId, for: indexPath as IndexPath)
        if collectionView == self.topArtistsCollectionView {
            if let cell = cell as? HomeCollectionViewCell {
                if let topArtistList = self.topArtistList {
                    if let topArtist = topArtistList.get(i: indexPath.item) {
                        return setTopArtistCellProperties(cell: cell, topArtist: topArtist)
                    }
                }
            }
        } else {
            if collectionView == self.popularSongsCollectionView {
                if let cell = cell as? HomeCollectionViewCell {
                    if let popularSongList = self.popularSongList {
                        if let popularSong = popularSongList.get(i: indexPath.item) {
                            return setPopularSongCellProperties(cell: cell, popularSong: popularSong)
                        }
                    }
                }
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == self.popularSongsCollectionView {
            self.performSegue(withIdentifier: "HomeToSongsSegue", sender: nil)
        } else {
            if collectionView == self.topArtistsCollectionView {
                self.performSegue(withIdentifier: "HomeToDiscographySegue", sender: nil)
            }
        }
    }
}
