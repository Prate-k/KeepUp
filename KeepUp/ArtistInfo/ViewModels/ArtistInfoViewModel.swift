//
//  ArtistInfoViewModel.swift
//  KeepUp
//
//  Created by Prateek Kambadkone on 2019/03/05.
//  Copyright © 2019 Prateek Kambadkone. All rights reserved.
//

import Foundation

class ArtistInfoViewModel {
    
    weak var artistInfoViewController: ArtistInfoFetching?
    
    init(view: ArtistInfoFetching) {
        self.artistInfoViewController = view
    }
}
