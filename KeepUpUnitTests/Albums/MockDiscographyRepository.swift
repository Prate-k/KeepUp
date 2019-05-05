//
//  MockAlbumsRepository.swift
//  KeepUpUnitTests
//
//  Created by Prateek Kambadkone on 2019/04/30.
//  Copyright © 2019 Prateek Kambadkone. All rights reserved.
//

import Foundation
@testable import KeepUp

class MockDiscographyRepository: DiscographyRepositoryProtocol {
    func checkIfInFavourites(_ artistName: String) {
        
    }
    
    func removeSelectedArtist(artistName: String) {
        print("")
    }
    
    func addArtist(newArtist: SelectedArtist) {
        print("")
    }
    var viewModelDelegate: DiscographyViewModelProtocol?
    
    func dataReady(result: Result<Albums>) {
        switch result {
        case .success(let album):
            viewModelDelegate?.updateAlbumsForArtist(result: Result.success(album))
        case .failure(let error):
            viewModelDelegate?.updateAlbumsForArtist(result: Result.failure(error))
        }
    }
    
    func getAlbums(of artistID: Int) {
        if artistID < 0 {
            dataReady(result: Result.failure(.InvalidInput))
        } else {
            var albums: [Album] = []
            for index in 0..<12 {
                albums.append(Album(albumID: index, albumName: "Album\(index)",
                    albumCover: "Image\(index)", genreID: index, releaseDate: "2019-\(index)-20"))
            }
            dataReady(result: Result.success(Albums(results: albums)))
        }
    }
}
