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
    lazy var lyricsViewModel: LyricsViewModel? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        lyricsViewModel = LyricsViewModel(view: self)
        DispatchQueue.global().async { [weak self] in
            if let self = self {
                self.setArtist(artistName: self.artistName)
                self.setSongTitle(songTitle: self.songTitle)
                self.lyricsViewModel?.getSongLyrics(artistName: self.artistName, songTitle: self.songTitle)
            }
        }
    }
}
