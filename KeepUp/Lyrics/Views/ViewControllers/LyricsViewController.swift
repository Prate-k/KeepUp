//
//  SongLyricsViewController.swift
//  KeepUp
//
//  Created by Prateek Kambadkone on 2019/03/12.
//  Copyright © 2019 Prateek Kambadkone. All rights reserved.
//

import UIKit

class LyricsViewController: UIViewController {

    @IBOutlet weak var lyricsTextView: UITextView!
    @IBOutlet weak var songTitleLabel: UILabel!
    @IBOutlet weak var artistNameLabel: UILabel!
    
    var artistName: String = ""
    var songTitle: String = ""
    
    var viewModelDelegate: LyricsViewModelProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModelDelegate = LyricsViewModel()
        viewModelDelegate?.viewControllerDelegate = self
        
        setSongTitle(songTitle: songTitle)
        setArtist(artistName: artistName)
        // Do any additional setup after loading the view.
        DispatchQueue.global().async { [weak self] in
            if let self = self {
                self.viewModelDelegate?.getSongLyricsFromRepository(artistName: self.artistName, songTitle: self.songTitle)
            }
        }
    }
}
