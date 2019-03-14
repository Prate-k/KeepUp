//
//  ArtistInfoViewModelExtensions.swift
//  KeepUp
//
//  Created by Prateek Kambadkone on 2019/03/05.
//  Copyright © 2019 Prateek Kambadkone. All rights reserved.
//

import Foundation

protocol ArtistInfoViewModelFunctionable: class {
    func getArtistInfo(artistName: String)
}

extension ArtistInfoViewModel: ArtistInfoViewModelFunctionable {

    func getArtistInfo(artistName: String) {
        let artistInfoRepository: ArtistInfoRepositoryFunctionable = ArtistInfoRepository()
        _ = artistInfoRepository.getArtistDataFromSource(artistName: artistName, completing: { (artistInfo) in
            self.artistInfoViewController?.artistInfoShow(info: artistInfo)
        })
    }
}
