//
// Created by Prateek Kambadkone on 2019-03-16.
// Copyright (c) 2019 Prateek Kambadkone. All rights reserved.
//

import Foundation

protocol DiscographyViewModelProtocol: class {
    var viewControllerDelegate: DiscographyViewControllerProtocol? { get set }
    func updateSelectedArtist(result: Result<Albums>)
    
    var repositoryDelegate: DiscographyRepositoryProtocol? { get set }
    func removeArtist(artistName: String)
    func addArtist(newArtist: Artist)
    func getSelectedArtist(artistID: Int)
}

extension DiscographyViewModel {
    func textifyDate(date: String) -> String {
        var partsStr = date.split(separator: "-")
        
        var date = String(partsStr[2])
        var month = getMonth(monthNum: String(partsStr[1]))
        var year = String(partsStr[0])
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
    func updateSelectedArtist(result: Result<Albums>) {
        switch result {
        case .success(let albums):
            var album: Album!
            for a in albums.results {
                album = a
                album.setDate(date: textifyDate(date: album.releaseDate!))
            }
            viewControllerDelegate?.updateView(albums: albums)
        case .failure(let error):
            viewControllerDelegate?.albumLoadFailure(error: error)
        }
    }
    
    func removeArtist(artistName: String) {
        repositoryDelegate?.removeSelectedArtist(artistName: artistName)
    }
    
    func addArtist(newArtist: Artist) {
        repositoryDelegate?.addArtist(newArtist: newArtist)
    }
    
    func getSelectedArtist(artistID: Int) {
        repositoryDelegate?.getSelectedArtist(artistID: artistID)
    }
}
