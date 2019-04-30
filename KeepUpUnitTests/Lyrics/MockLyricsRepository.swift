//
//  MockLyricsRepository.swift
//  KeepUpUnitTests
//
//  Created by Prateek Kambadkone on 2019/04/30.
//  Copyright © 2019 Prateek Kambadkone. All rights reserved.
//

import Foundation
@testable import KeepUp

class MockLyricsRepository: LyricsRepositoryProtocol {
    var viewModelDelegate: LyricsViewModelProtocol?
    
    var networkDelegate: LyricsNetworkProtocol?

    func dataReady(result: Result<String>) {
        switch result {
        case .success(let data):
            viewModelDelegate?.setLyricsOnView(result: Result.success(data))
        case .failure(let error):
            viewModelDelegate?.setLyricsOnView(result: Result.failure(error))
        }
    }
    
    func getSongLyricsFromDataSource(artistName: String, albumName: String, songTitle: String) {
        if artistName.isEmpty || songTitle.isEmpty {
            dataReady(result: Result.failure(Errors.InvalidInput))
        } else {
            let exampleWords = """
                            lyrics... lyrics, Lyrics \t lyrics, \n lyrics
                            \n\n Lyrics
                            """
            dataReady(result: Result.success(exampleWords))
        }
    }
    
    func getAPIKey() -> String {
        return "6"
    }
}
