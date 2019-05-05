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
    func updatePopularSongs(results: PopularSongs)
    func resultsFailure(error: Errors)
}

extension HomeViewController {
    
    func setupView1() {
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
    
    func setupView2() {
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
        self.viewModelDelegate?.getPopularSongsFromRepository()
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
        DispatchQueue.main.async {
            self.topArtistsCollectionView.reloadData()
            DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                self.topArtistsCollectionView.reloadData()
                self.topArtistsCollectionView.layoutIfNeeded()
            })
        }
    }
    
    func updatePopularSongs(results: PopularSongs) {
        self.popularSongList = results
        DispatchQueue.main.async {
            self.popularSongsCollectionView.reloadData()
            DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                self.popularSongsCollectionView.reloadData()
                self.popularSongsCollectionView.layoutIfNeeded()
            })
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
                if let popularSongList = popularSongList {
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
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reusableId, for: indexPath as IndexPath) as? HomeCollectionViewCell else {
            fatalError("Invalid cell type, cell must be HomeCollectionViewCell type")
        }
        if collectionView == self.topArtistsCollectionView {
            if let topArtistList = self.topArtistList {
                if let topArtist = topArtistList.get(i: indexPath.item) {
                        if let imageLink = topArtist.artistThumbnail {
                            cell.imageView.loadImageFromSource(source: imageLink)
                        }
                    
                        cell.imageView.layer.cornerRadius = 16.0
                        cell.imageView.clipsToBounds = true
                        cell.textLabels.layer.cornerRadius = 16.0
                    
                        cell.layer.cornerRadius = 16.0
                    
                        var shadowLayer: CAShapeLayer!
                        let cornerRadius: CGFloat = 16.0
                        let fillColour: UIColor = .white
                        let bounds = cell.layer.bounds
                    
                        if shadowLayer == nil {
                            shadowLayer = CAShapeLayer()
                            shadowLayer.path = UIBezierPath(roundedRect: bounds,  cornerRadius: cornerRadius).cgPath
                            shadowLayer.fillColor = fillColour.cgColor
                            shadowLayer.shadowColor = UIColor.black.cgColor
                            shadowLayer.shadowPath = shadowLayer.path
                            shadowLayer.shadowOffset = CGSize(width: 0, height: 1.2)
                            shadowLayer.shadowOpacity = 0.8
                            shadowLayer.shadowRadius = 8
                            
                            if let shadow = cell.layer.sublayers?[0] as? CAShapeLayer {
                            } else {
                                cell.layer.insertSublayer(shadowLayer, at: 0)
                                cell.layer.masksToBounds = false
                            }
                        }
                    
                        if let artistName = topArtist.artistName {
                            cell.label1.attributedText = NSAttributedString(string: artistName)
                        }
                        return cell
                }
            }
        } else {
            if collectionView == self.popularSongsCollectionView {
                if let popularSongList = self.popularSongList {
                    if let popularSong = popularSongList.get(i: indexPath.item) {
                        
                        if let imageLink = popularSong.album?.albumCover {
                            cell.imageView.loadImageFromSource(source: imageLink)
                        } else {
                            cell.imageView.image = UIImage(named: "dummySong")
                        }
                        
                        cell.imageView.layer.cornerRadius = 16.0
                        cell.imageView.clipsToBounds = true
                        cell.textLabels.layer.cornerRadius = 16.0
                        
                        cell.layer.cornerRadius = 16.0
                        
                        var shadowLayer: CAShapeLayer!
                        let cornerRadius: CGFloat = 16.0
                        let fillColour: UIColor = .white
                        let bounds = cell.layer.bounds
                        
                        if shadowLayer == nil {
                            shadowLayer = CAShapeLayer()
                            shadowLayer.path = UIBezierPath(roundedRect: bounds,  cornerRadius: cornerRadius).cgPath
                            shadowLayer.fillColor = fillColour.cgColor
                            shadowLayer.shadowColor = UIColor.black.cgColor
                            shadowLayer.shadowPath = shadowLayer.path
                            shadowLayer.shadowOffset = CGSize(width: 0, height: 1.2)
                            shadowLayer.shadowOpacity = 0.8
                            shadowLayer.shadowRadius = 8
                            
                            if let shadow = cell.layer.sublayers?[0] as? CAShapeLayer {
                            } else {
                                cell.layer.insertSublayer(shadowLayer, at: 0)
                                cell.layer.masksToBounds = false
                            }
                        }
                        
                        if let songTitle = popularSong.songTitle {
                            cell.label1.attributedText = NSAttributedString(string: songTitle)
                        }
                        
                        if let artistName = popularSong.artist?.artistName {
                            cell.label2.attributedText =  NSAttributedString(string: artistName)
                        }
                        cell.layoutIfNeeded()
                        return cell
                    }
                }
            }
        }
        cell.layoutIfNeeded()
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
