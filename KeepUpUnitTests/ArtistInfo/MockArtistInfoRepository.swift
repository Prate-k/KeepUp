//
//  MockArtistInfoRepository.swift
//  KeepUpUnitTests
//
//  Created by Prateek Kambadkone on 2019/04/30.
//  Copyright © 2019 Prateek Kambadkone. All rights reserved.
//

import Foundation
@testable import KeepUp

class MockArtistInfoRepository: ArtistInfoRepositoryProtocol {
    lazy var networkDelegate: ArtistInfoNetworkProtocol? = nil
    
    func dataReady(result: Result<[String]>) {
        //from network
    }
    func notifyViewModel(info: [String]) {
        //from dataReady
    }
    
    weak var viewModelDelegate: ArtistInfoViewModelProtocol?
    
    var artistInfo: ArtistInfo?
    
    init () {
        viewModelDelegate?.repositoryDelegate = self
    }
    
    func getArtistDataFromSource(artistName: String) {
        var result: Result<ArtistInfo>
        if artistName.isEmpty {
            let artistInfo = ArtistInfo(origin: "Agoura Hills, California, U.S.",
                                        genres: """
                                                    Alternative rock\n
                                                    nu metal alternative\n
                                                    metal\n
                                                    rap rock\n
                                                    electronic rock
                                                    """,
                                        members: """
                                                    Rob Bourdon\n
                                                    Brad Delson\n
                                                    Mike Shinoda\n
                                                    Dave Farrell\n
                                                    Joe Hahn
                                                    """,
                                        isSolo: false)
            result = Result.success(artistInfo)
        } else {
            result = Result.failure(Errors.NetworkError)
        }
        viewModelDelegate?.setArtistInfoOnView(result: result)
    }
}
