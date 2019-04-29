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
    @IBOutlet weak var progressBar: UIActivityIndicatorView!
    
    var artistName: String = ""
    var songTitle: String = ""
    var selectedSong: SelectedSong?
    
    var viewModelDelegate: LyricsViewModelProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModelDelegate = LyricsViewModel()
        viewModelDelegate?.viewControllerDelegate = self
        
        guard let song = selectedSong else {
            showCouldNotLoadLyricsError(viewController: self)
            return
        }
        setSongTitle(songTitle: song.songName)
        setArtist(artistName: song.artistName)
        progressBar.startAnimating()
        lyricsTextView.isHidden = true
        // Do any additional setup after loading the view.
        DispatchQueue.global().async { [weak self] in
            if let self = self {
                if let selectedSong = self.selectedSong {
                    self.viewModelDelegate?.getSongLyrics(of: selectedSong)
                }
            }
        }
    }
}
