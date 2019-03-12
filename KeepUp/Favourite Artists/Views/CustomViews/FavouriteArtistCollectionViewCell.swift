//
//  FavouriteArtistCollectionViewCell.swift
//  KeepUp
//
//  Created by Prateek Kambadkone on 2019/02/13.
//  Copyright © 2019 Prateek Kambadkone. All rights reserved.
//

import UIKit

class FavouriteArtistCollectionViewCell: UICollectionViewCell
{
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var artistName: UILabel!
    @IBOutlet weak var genre: UILabel!
    @IBOutlet weak var deleteCheckBoxView: DeleteCheckBoxView!
}
