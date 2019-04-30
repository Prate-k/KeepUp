//
// Created by Prateek Kambadkone on 2019-03-16.
// Copyright (c) 2019 Prateek Kambadkone. All rights reserved.
//

import Foundation

protocol DiscographyViewModelProtocol: class {
    var viewControllerDelegate: DiscographyViewControllerProtocol? { get set }
    func updateAlbumsForArtist(result: Result<Albums>)
    var repositoryDelegate: DiscographyRepositoryProtocol? { get set }
    func removeArtist(artistName: String)
    func addArtist(newArtist: SelectedArtist)
    func getAlbums(of artistID: Int)
}

extension DiscographyViewModel {
    func textifyDate(date: String) -> String {
        var partsStr = date.split(separator: "-")
        let date = String(partsStr[2])
        let month = getMonth(monthNum: String(partsStr[1]))
        let year = String(partsStr[0])
        return "\(date) \(month) \(year)"
    }
    
    func getMonth(monthNum: String) -> String {
        switch monthNum {
        case "01" :return "Jan"
        case "02" :return "Feb"
        case "03" :return "Mar"
        case "04" :return "Apr"
        case "05" :return "May"
        case "06" :return "Jun"
        case "07" :return "Jul"
        case "08" :return "Aug"
        case "09" :return "Sep"
        case "10" :return "Oct"
        case "11" :return "Nov"
        case "12" :return "Dec"
        default: return ""
        }
    }
}

extension DiscographyViewModel: DiscographyViewModelProtocol {
    func updateAlbumsForArtist(result: Result<Albums>) {
        switch result {
        case .success(let albums):
            var album: Album!
            for a in albums.results {
                album = a
                if let date = album.releaseDate {
                    album.setDate(date: textifyDate(date: date))
                }
            }
            viewControllerDelegate?.updateView(albums: albums)
        case .failure(let error):
            viewControllerDelegate?.albumLoadFailure(error: error)
        }
    }
    func removeArtist(artistName: String) {
        repositoryDelegate?.removeSelectedArtist(artistName: artistName)
    }
    
    func addArtist(newArtist: SelectedArtist) {
        repositoryDelegate?.addArtist(newArtist: newArtist)
    }
    
    func getAlbums(of artistID: Int) {
        repositoryDelegate?.getAlbums(of: artistID)
    }
}
