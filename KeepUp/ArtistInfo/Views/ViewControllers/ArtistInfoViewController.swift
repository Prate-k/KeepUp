//
//  ArtistInfoViewController.swift
//  KeepUp
//
//  Created by Prateek Kambadkone on 2019/02/19.
//  Copyright © 2019 Prateek Kambadkone. All rights reserved.
//

import UIKit
import WebKit

class ArtistInfoViewController: UIViewController {

    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var originLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var membersLabel: UILabel!
    @IBOutlet weak var waitForDataIndicator: UIActivityIndicatorView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var originHeaderLabel: UILabel!
    @IBOutlet weak var membersHeaderLabel: UILabel!
    @IBOutlet weak var membersStackView: UIStackView!
    
    var artistName: String = ""
    lazy var artistInfoViewModel: ArtistInfoViewModel? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        artistInfoViewModel = ArtistInfoViewModel(view: self)
        scrollView.isHidden = true
        waitForDataIndicator.isHidden = false
        waitForDataIndicator.startAnimating()
        DispatchQueue.global().async { [weak self] in
            if let self = self {
                self.artistInfoViewModel?.getArtistInfo(artistName: self.artistName)
            }
        }
    }

    @IBAction func closeArtistInfo() {
        dismiss(animated: true, completion: nil)
    }
}
