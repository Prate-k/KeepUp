//
//  SearchResultCell.swift
//  KeepUp
//
//  Created by Prateek Kambadkone on 2019/04/20.
//  Copyright © 2019 Prateek Kambadkone. All rights reserved.
//

import UIKit

class SearchResultCell: UITableViewCell {
    
    @IBOutlet weak var artistThumbnailImageView: UIImageView!
    @IBOutlet weak var artistNameLabel: UILabel!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
