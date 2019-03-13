//
//  SongTableViewCell.swift
//  KeepUp
//
//  Created by Prateek Kambadkone on 2019/02/15.
//  Copyright © 2019 Prateek Kambadkone. All rights reserved.
//

import UIKit

class SongTableViewCell: UITableViewCell {

    
    @IBOutlet weak var songLength: UILabel!
    @IBOutlet weak var songTitle: UILabel!
    @IBOutlet weak var songImageView: UIImageView!
    @IBOutlet weak var trackOptionsView: UIView!
    @IBOutlet weak var trackDetailsView: UIView!
    @IBOutlet weak var trackOptionsStackView: UIStackView!
    @IBOutlet weak var displayOptionsButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    
    @IBAction func displayOptions(_ sender: UIButton) {
        trackOptionsView.isHidden = !trackOptionsView.isHidden
        
        if trackOptionsView.isHidden {
            displayOptionsButton.setImage(UIImage(named: "shiftLeft"), for: .normal)
        } else {
            displayOptionsButton.setImage(UIImage(named: "shiftRight"), for: .normal)
        }
    }
    
    @IBAction func hideTrackAction(_ sender: Any) {
        print("Hiding track")    }
    @IBAction func playTrackAction(_ sender: Any) {
        print("Playing track")
    }
    @IBAction func showLyricsAction(_ sender: Any) {
        print("Displaying lyrics")
    }
}
