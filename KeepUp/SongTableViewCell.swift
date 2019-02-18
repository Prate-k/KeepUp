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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
