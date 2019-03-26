//
//  SongLyricsViewModel.swift
//  KeepUp
//
//  Created by Prateek Kambadkone on 2019/03/15.
//  Copyright © 2019 Prateek Kambadkone. All rights reserved.
//

import Foundation

class LyricsViewModel {
    
    lazy var viewControllerDelegate: LyricsViewControllerProtocol? = nil
    lazy var repositoryDelegate: LyricsRepositoryProtocol? = nil
    
    init() {
        repositoryDelegate = LyricsRepository()
        repositoryDelegate?.viewModelDelegate = self
    }
    
    func setRepositoryDelegate(repository: LyricsRepositoryProtocol?) {
        if let repository = repository {
            repositoryDelegate = repository
        } else {
            repositoryDelegate = LyricsRepository()
        }
        repositoryDelegate?.viewModelDelegate = self
    }
    
    func setViewControllerDelegate(viewController: LyricsViewControllerProtocol?) {
        if let viewController = viewController {
            viewControllerDelegate = viewController
        } else {
            viewControllerDelegate = LyricsViewController()
        }
        viewControllerDelegate?.viewModelDelegate = self
    }
}
