//
//  MockAlbumsViewController.swift
//  KeepUpUnitTests
//
//  Created by Prateek Kambadkone on 2019/04/30.
//  Copyright © 2019 Prateek Kambadkone. All rights reserved.
//

import Foundation
@testable import KeepUp
import XCTest

class MockDiscographyViewController: DiscographyViewControllerProtocol {
    var viewModelDelegate: DiscographyViewModelProtocol?
    
    func albumLoadFailure(error: Errors) {
        XCTAssert(error == .InvalidInput)
    }
    
    func updateView(albums: Albums) {
        var bool = true
        var mon = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
        for index in 0..<12 {
            let result = albums.get(i: index)
            if result?.albumID != index || result?.albumName !=  "Album\(index)",
               result?.albumCover != "Image\(index)" || result?.genreID != index ||
                result?.releaseDate != "2019-\(mon[index])-20"{
                bool = false
                break
            }
        }
        XCTAssert(bool)
    }
    
    func toggleArtistSearched(selectedArtist: SelectedArtist) {
    }
    
    func addToFavouritesList(selectedArtist: SelectedArtist) {
        if selectedArtist.artistName.isEmpty {
        }
        let newArtist = SelectedArtist(artistID: selectedArtist.artistID, artistName: selectedArtist.artistName, artistImage: selectedArtist.artistImage)
        viewModelDelegate?.addArtist(newArtist: newArtist)
    }
    
    func removeFromFavouritesList(selectedArtistName: String) {
        if selectedArtistName.isEmpty {
        } else {
            viewModelDelegate?.removeArtist(artistName: selectedArtistName)
        }
    }
}
