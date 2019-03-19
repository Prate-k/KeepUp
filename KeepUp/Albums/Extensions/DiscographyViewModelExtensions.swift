//
// Created by Prateek Kambadkone on 2019-03-16.
// Copyright (c) 2019 Prateek Kambadkone. All rights reserved.
//

import Foundation

protocol DiscographyViewModelFunctionable: class {
    func getAlbumList(with artistName: String)
    func getSelectedArtist(at index: Int)
    func getArtistIndex(name: String) -> Int
    func removeArtist(at index: Int)
    func addArtist(_ newArtist: Artist)
}

extension DiscographyViewModel: DiscographyViewModelFunctionable {
    func getArtistIndex(name: String) -> Int {
        let albumsRepository: DiscographyRepositoryFunctionable = DiscographyRepository()
        var artistIndex = -1
        albumsRepository.getSelectedArtistIndex(name: name, completing: {(index) in
            artistIndex = index
        })
        return artistIndex
    }
    
    func getAlbumList(with artistName: String) {
        let albumsRepository: DiscographyRepositoryFunctionable = DiscographyRepository()
        _ = albumsRepository.getAlbumsListFromSource(artistName: artistName, completing: { (albums) in
            self.discographyViewController?.albumsListShow(albums: albums)
        })
    }
    
    func getSelectedArtist(at index: Int) {
        let albumsRepository: DiscographyRepositoryFunctionable = DiscographyRepository()
        _ = albumsRepository.getSelectedArtist(at: index, completing: { (artist) in
            self.discographyViewController?.showSelectedArtist(artist: artist)
        })
    }
    
    func removeArtist(at index: Int) {
        let albumsRepository: DiscographyRepositoryFunctionable = DiscographyRepository()
        albumsRepository.removeSelectedArtist(at: index)
    }
    
    func addArtist(_ newArtist: Artist) {
        let albumsRepository: DiscographyRepositoryFunctionable = DiscographyRepository()
        albumsRepository.addArtist(newArtist)
    }
}
