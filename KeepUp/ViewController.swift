//
//  ViewController.swift
//  KeepUp
//
//  Created by Prateek Kambadkone on 2019/02/12.
//  Copyright © 2019 Prateek Kambadkone. All rights reserved.
//

import UIKit

var favouriteList = [Artist]()

class ViewController: UIViewController {

    @IBOutlet weak var searchText: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var resultView: UIView!
    @IBOutlet weak var resultImage: UIImageView!
    @IBOutlet weak var resultArtistLabel: UILabel!
    @IBOutlet weak var resultGenreLabel: UILabel!
    @IBOutlet weak var addToFavButton: UIButton!
    @IBOutlet weak var removeFromFavButton: UIButton!
    @IBOutlet weak var tempDisplayField: UITextView!
    @IBOutlet weak var detailsView: UIView!
    @IBOutlet weak var detailsExpandCollapseImage: UIImageView!
    @IBOutlet weak var detailsDropDownLable: UILabel!

    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        resultView.isHidden = true
    }

    @IBAction func addToFavouritesList() {
        let newArtist = Artist(name: resultArtistLabel.text, genre: resultGenreLabel.text, image: resultImage.image)
        if let x = newArtist {
            favouriteList.append(x)
            var str = ""
            for i in 0..<favouriteList.count {
                str.append(favouriteList[i].name + ", ")
            }
            tempDisplayField.text.append(str + "\n")
        }
    }
    
    @IBAction func removeFromFavouritesList() {
            for i in 0..<favouriteList.count {
                if favouriteList[i].name == resultArtistLabel.text {
                    favouriteList.remove(at: i)
                    break
                }
            }
        var str = ""
        for i in 0..<favouriteList.count {
            str.append(favouriteList[i].name + ", ")
        }
        tempDisplayField.text.append(str + "\n")
    }
    
    @IBAction func searchArtist() {
        let searchedText = searchText.text
        if searchedText?.isEmpty ?? true {
            let alert = UIAlertController(title: "Empty Search", message: "Seach field is empty - Please enter an artist's name.", preferredStyle: .alert)
            let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
        } else {
            resultView.isHidden = false
            resultArtistLabel.text = searchedText
            resultGenreLabel.text = "Random"
            resultImage.image = UIImage(named: "dummyArtist")
        }
    }
    

    @IBAction func detailsViewPressed() {
        let image = detailsExpandCollapseImage.image
        
        if (image?.isEqual(UIImage(named: "expand")))! {
            detailsExpandCollapseImage.image = UIImage(named: "collapse")
        } else {
            detailsExpandCollapseImage.image = UIImage(named: "expand")
        }
    }
}

