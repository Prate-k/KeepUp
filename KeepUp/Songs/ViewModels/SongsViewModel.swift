//
//  SongsViewModel.swift
//  KeepUp
//
//  Created by Prateek Kambadkone on 2019/03/17.
//  Copyright © 2019 Prateek Kambadkone. All rights reserved.
//

import Foundation

class SongsViewModel {
    weak var songsViewController: SongsListFetching?
    
    init(view: SongsListFetching) {
        self.songsViewController = view
    }
}
