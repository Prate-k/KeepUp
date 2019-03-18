//
//  MainScreenViewModel.swift
//  KeepUp
//
//  Created by Prateek Kambadkone on 2019/03/18.
//  Copyright © 2019 Prateek Kambadkone. All rights reserved.
//

import Foundation

class MainScreenViewModel {
    weak var mainScreenViewController: MainScreenPopulating?
    
    init(view: MainScreenPopulating) {
        self.mainScreenViewController = view
    }
}
