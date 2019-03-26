//
//  ArtistInfoViewModelExtensions.swift
//  KeepUp
//
//  Created by Prateek Kambadkone on 2019/03/05.
//  Copyright © 2019 Prateek Kambadkone. All rights reserved.
//

import Foundation

protocol ArtistInfoViewModelProtocol: class {
    var viewControllerDelegate: ArtistInfoViewControllerProtocol? { get set }
    var repositoryDelegate: ArtistInfoRepositoryProtocol? { get set }
    func getArtistInfoFromRepository(artistName: String)
    func setArtistInfoOnView(result: Result<ArtistInfo>)
}

extension ArtistInfoViewModel: ArtistInfoViewModelProtocol {
    
    func setArtistInfoOnView(result: Result<ArtistInfo>) {
        switch result {
        case .success(let data):
            print(data)
            self.viewControllerDelegate?.artistInfoShow(artistInfo: data)
        case .failure(let error):
            self.viewControllerDelegate?.artistInfoFailure(error: error)
        }
    }
    
    func getArtistInfoFromRepository(artistName: String) {
        repositoryDelegate?.getArtistDataFromSource(artistName: artistName)
    }
}
