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

    
    
    var artistName: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func closeArtistInfo()
    {
        dismiss(animated: true, completion: nil)
    }

}
