//
// Created by Prateek Kambadkone on 2019-03-16.
// Copyright (c) 2019 Prateek Kambadkone. All rights reserved.
//

import Foundation

protocol DiscographyViewModelProtocol: class {
    var viewControllerDelegate: DiscographyViewControllerProtocol? { get set }
    func updateSelectedArtist(result: Result<Artist>)
    
    var repositoryDelegate: DiscographyRepositoryProtocol? { get set }
    func removeArtist(artistName: String)
    func addArtist(newArtist: Artist)
    func getSelectedArtist(artistName: String)
}

extension DiscographyViewModel: DiscographyViewModelProtocol {
    func updateSelectedArtist(result: Result<Artist>) {
        switch result {
        case .success(let data):
            viewControllerDelegate?.updateView(artist: data)
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
    
    func getSelectedArtist(artistName: String) {
        repositoryDelegate?.getSelectedArtist(artistName: artistName)
    }
}
