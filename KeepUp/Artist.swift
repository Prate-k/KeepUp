//
//  Artist.swift
//  KeepUp
//
//  Created by Prateek Kambadkone on 2019/02/13.
//  Copyright © 2019 Prateek Kambadkone. All rights reserved.
//

import Foundation
import UIKit

class Artist {
    
    var name: String!
    var genre: String!
    var image: UIImage!
    
    required init!(name: String!, genre: String!, image: UIImage!)
    {
        guard name != nil || genre != nil || image != nil else {
            return nil
        }
        self.name = name
        self.genre = genre
        self.image = image
    }
    
    
    
}
