//
//  ArtistInfoViewModel.swift
//  KeepUp
//
//  Created by Prateek Kambadkone on 2019/03/05.
//  Copyright © 2019 Prateek Kambadkone. All rights reserved.
//

import Foundation

class ArtistInfoViewModel {
    
    lazy var viewControllerDelegate: ArtistInfoViewControllerProtocol? = nil
    lazy var repositoryDelegate: ArtistInfoRepositoryProtocol? = nil
    
    init() {
        repositoryDelegate = ArtistInfoRepository()
        repositoryDelegate?.viewModelDelegate = self
    }
    
    func setRepositoryDelegate(repository: ArtistInfoRepositoryProtocol?) {
        if let repository = repository {
            repositoryDelegate = repository
        } else {
            repositoryDelegate = ArtistInfoRepository()
        }
        repositoryDelegate?.viewModelDelegate = self
    }
    
    func setViewControllerDelegate(viewController: ArtistInfoViewControllerProtocol?) {
        if let viewController = viewController {
            viewControllerDelegate = viewController
        } else {
            viewControllerDelegate = ArtistInfoViewController()
        }
        viewControllerDelegate?.viewModelDelegate = self
    }
}
