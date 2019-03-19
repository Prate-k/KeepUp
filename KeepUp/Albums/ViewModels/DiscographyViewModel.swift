//
//  DiscographyViewModel.swift
//  KeepUp
//
//  Created by Prateek Kambadkone on 2019/03/16.
//  Copyright © 2019 Prateek Kambadkone. All rights reserved.
//

import Foundation

class DiscographyViewModel {
    weak var discographyViewController: DiscographyListFetching?

    init(view: DiscographyListFetching) {
        self.discographyViewController = view
    }
}
