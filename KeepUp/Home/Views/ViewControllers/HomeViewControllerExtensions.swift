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
            shadowLayer.shadowOpacity = 0.8
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
            shadowLayer.shadowOpacity = 0.8
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
        requestPopularSongs()
    }
    
    func updatePopularSongsCollectionView() {
        DispatchQueue.main.async {
            self.popularSongsCollectionView.reloadData()
        }
    }
    
    func setTopArtistCellProperties(cell: UICollectionViewCell,
                                          topArtist: TopArtist) -> UICollectionViewCell {
        if let topArtistCell = cell as? HomeCollectionViewCell {
            topArtistCell.label1.text = topArtist.artistName
//            topArtistCell.genre.text =  topArtist.artistGenre

            topArtistCell.imageView.loadImageFromSource(source: topArtist.artistThumbnail!)
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
                shadowLayer.shadowOffset = CGSize(width: 0, height: 1.5)
                shadowLayer.shadowOpacity = 0.8
                shadowLayer.shadowRadius = 8

                topArtistCell.layer.insertSublayer(shadowLayer, at: 0)
                topArtistCell.layer.masksToBounds = false
            }
            return topArtistCell
        }
        return cell
    }
    
    func setPopularSongCellProperties(cell: UICollectionViewCell,
                                    popularSong: PopularSong) -> UICollectionViewCell {
        if let popularSongCell = cell as? HomeCollectionViewCell {
//            print(popularSong)
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
                shadowLayer.shadowOffset = CGSize(width: 0, height: 1.5)
                shadowLayer.shadowOpacity = 0.8
                shadowLayer.shadowRadius = 8
                
                popularSongCell.layer.insertSublayer(shadowLayer, at: 0)
                popularSongCell.layer.masksToBounds = false
            }
            return popularSongCell
        }
        return cell
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
        }
        
    }
    

    func resultsFailure(error: Errors) {
//        isWaitingResult = false
//        self.searchResults?.removeAll()
//        self.searchResults = nil
//        updateTableView()
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
        // handle tap events
        //        if collectionView == self.favCollectionView {
        //            self.performSegue(withIdentifier: "HomeToDiscographySegue", sender: nil)
        //        }
    }
}












//protocol MainScreenPopulating: class {
//    func toggleArtistSearched(searchedArtistName: String)
//    func addToFavouritesList(searchedArtistName: String)
//    func removeFromFavouritesList(searchedArtistName: String)
//}
//
//extension MainScreenViewController: MainScreenPopulating {
//    func toggleArtistSearched(searchedArtistName: String) {
////        let index = mainScreenViewModel?.getArtistIndex(name: searchedArtistName)
////        if index == -1 {
////            favouriteUnfavouriteButton.setImage(UIImage(named: "fav"), for: .normal)
////            addToFavouritesList(searchedArtistName: searchedArtistName)
////        } else {
////            favouriteUnfavouriteButton.setImage(UIImage(named: "unfav"), for: .normal)
////            removeFromFavouritesList(searchedArtistName: searchedArtistName)
////        }
////        if let artists = self.mainScreenViewModel?.getFavouriteList() {
////            favouriteArtistList = artists
////            favCollectionView.reloadData()
////        }
//    }
//
//    func addToFavouritesList(searchedArtistName: String) {
////        let index = mainScreenViewModel?.getArtistIndex(name: searchedArtistName)
////        if index != -1 {
////            return
////        }
////        let newArtist = Artist(name: searchedArtistName,
////                               genre: "Random",
////                               imageUrl: "dummyArtist")
////        if let x = newArtist {
////            mainScreenViewModel?.addArtist(x)
////        }
//    }
//
//    func removeFromFavouritesList(searchedArtistName: String) {
////        let index = mainScreenViewModel?.getArtistIndex(name: searchedArtistName)
////        if  index == -1 {
////            return
////        } else {
////            if let index = index {
////                mainScreenViewModel?.removeArtist(at: index)
////            }
////        }
//    }
//}
//
//extension MainScreenViewController {
//    func loadAlbumsScreen(albumsViewController: DiscographyViewController) {
////        if isLoadingAllFavourites {
////            albumsViewController.selectedArtistName = favouriteArtistList[selectedArtistPosition].artistName
////        } else {
////            if let index = favCollectionView.indexPathsForSelectedItems?[0].item {
////                albumsViewController.selectedArtistName = favouriteArtistList[index].artistName
////            }
////        }
////        isLoadingAllFavourites = false
//    }
//
//    func loadArtistInfoScreen (artistInfoViewController: ArtistInfoViewController) {
////        if let name = resultArtistLabel.text {
////            artistInfoViewController.artistName.append("\(name)")
////            return
////        }
//    }
//
//    func requestTopArtists() {
//
//    }
//
//    func setUpViews() {
//        var shadowLayer: CAShapeLayer!
//        let fillColour: UIColor = .white
//        let bounds = topArtistsLabelView.layer.bounds
//
//        if shadowLayer == nil {
//            shadowLayer = CAShapeLayer()
//            shadowLayer.path = UIBezierPath(roundedRect: bounds,  cornerRadius: 0.0).cgPath
//            shadowLayer.fillColor = fillColour.cgColor
//            shadowLayer.shadowColor = UIColor.black.cgColor
//            shadowLayer.shadowPath = shadowLayer.path
//            shadowLayer.shadowOffset = CGSize(width: 0, height: 1.0)
//            shadowLayer.shadowOpacity = 0.8
//            shadowLayer.shadowRadius = 1
//
//            topArtistsLabelView.layer.insertSublayer(shadowLayer, at: 0)
//            topArtistsLabelView.layer.masksToBounds = false
//        }
//    }
//
//    func setTopArtistCellProperties(cell: UICollectionViewCell,
//                                          artist: Artist) -> UICollectionViewCell {
//        if let topArtistCell = cell as? TopArtistsCollectionViewCell {
//
//
//            topArtistCell.artistName.text = artist.artistName
//            topArtistCell.genre.text =  artist.artistGenre
//
//            topArtistCell.imageView.image = UIImage(named: "dummyArtist")
//            topArtistCell.imageView.layer.cornerRadius = 16.0
//            topArtistCell.imageView.clipsToBounds = true
//            topArtistCell.textLabels.layer.cornerRadius = 16.0
//
//            topArtistCell.layer.cornerRadius = 16.0
//
//            var shadowLayer: CAShapeLayer!
//            let cornerRadius: CGFloat = 16.0
//            let fillColour: UIColor = .white
//            let bounds = topArtistCell.layer.bounds
//
//            if shadowLayer == nil {
//                shadowLayer = CAShapeLayer()
//                shadowLayer.path = UIBezierPath(roundedRect: bounds,  cornerRadius: cornerRadius).cgPath
//                shadowLayer.fillColor = fillColour.cgColor
//                shadowLayer.shadowColor = UIColor.black.cgColor
//                shadowLayer.shadowPath = shadowLayer.path
//                shadowLayer.shadowOffset = CGSize(width: 0, height: 1.5)
//                shadowLayer.shadowOpacity = 0.8
//                shadowLayer.shadowRadius = 8
//
//                topArtistCell.layer.insertSublayer(shadowLayer, at: 0)
//                topArtistCell.layer.masksToBounds = false
//            }
//
//
//
//            favCollectionViewCellSize = topArtistCell.frame.size
//            return topArtistCell
//        }
//        return cell
//    }
//

//}
