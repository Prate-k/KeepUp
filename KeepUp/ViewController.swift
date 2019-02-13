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
    @IBOutlet weak var tempDisplayField: UITextView!
    @IBOutlet weak var detailsView: UIView!
    @IBOutlet weak var detailsExpandCollapseImage: UIImageView!
    @IBOutlet weak var detailsDropDownLable: UILabel!
    @IBOutlet weak var favouriteUnfavouriteButton: UIButton!

    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        resultView.isHidden = true
    }

    
    @IBAction func addRemoveFavourites() {
        
        let image = favouriteUnfavouriteButton.currentImage
        
        let index = isArtistInFavouriteList(name: resultArtistLabel.text!)
        
        if index == -1 {
            favouriteUnfavouriteButton.setImage(UIImage(named: "fav"), for: .normal)
            addToFavouritesList()
        } else {
            favouriteUnfavouriteButton.setImage(UIImage(named: "unfav"), for: .normal)
            removeFromFavouritesList()
        }
        
    }
    
    private func isArtistInFavouriteList (name: String) -> Int {
        var index = -1
        for i in 0..<favouriteList.count {
            if favouriteList[i].name.elementsEqual(resultArtistLabel.text!) {
                index = i
                break
            }
        }
        return index
    }
    
    private func addToFavouritesList() {
        let index = isArtistInFavouriteList(name: resultArtistLabel.text!)
        if index != -1 {
            return
        }
        
        let newArtist = Artist(name: resultArtistLabel.text, genre: resultGenreLabel.text, image: resultImage.image)
        
        if let x = newArtist {
            favouriteList.append(x)
            printToTempText()
        }
    }
    
    private func removeFromFavouritesList() {
        let index = isArtistInFavouriteList(name: resultArtistLabel.text!)
        if  index == -1 {
            return
        } else {
            favouriteList.remove(at: index)
        }
        printToTempText()
    }
    
    private func printToTempText() {
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
            
            if isArtistInFavouriteList(name: searchedText!) != -1 {
                favouriteUnfavouriteButton.setImage(UIImage(named: "fav"), for: .normal)
            } else {
                favouriteUnfavouriteButton.setImage(UIImage(named: "unfav"), for: .normal)
            }
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

