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
    
    let apiString = "en.wikipedia.org/w/api.php?"
    let apiReq = "action=query&prop=revisions&rvprop=content&format=jsonfm&rvsection=0"
    var artistName: String = ""
    
    struct artist {
        var origin: String
        var genres: String
        var members: String
    }
    
    var details: artist?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let searchArtistName = artistName.replacingOccurrences(of: " ", with: "_")
        let urlString = "https://en.wikipedia.org/w/api.php?action=query&prop=revisions&rvprop=content&format=json&rvsection=0&titles=\(searchArtistName)"
        
        let url = URL(string: urlString)!
        let session = URLSession.shared
        let request = URLRequest(url: url)
        
        let task = session.dataTask(with: request as URLRequest, completionHandler: {
            (data, response, error) in
            guard error == nil else {
                return
            }
            guard let data = data else {
                return
            }
            
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                    if let query = json["query"] as? [String: Any] {
                        if let pages = query["pages"] as? [String: Any] {
                            let a = pages.first!
                            if let page = pages[a.key] as? [String: Any] {
                                if let revisions = page["revisions"] as? [[String: Any]] {
                                    for i in 0..<revisions.count {
                                        if let temp = revisions[i] as? [String: Any] {
                                            if let artistData = temp["*"] as? String {
//                                                print("data: \(artistData)")
                                                    var str = artistData
                                                    str = str.replacingOccurrences(of: "nowrap|", with: "")
                                                        .replacingOccurrences(of: "[", with: "")
                                                        .replacingOccurrences(of: "]", with: "")
                                                        .replacingOccurrences(of: "{", with: "")
                                                        .replacingOccurrences(of: "}", with: "")
                                                    let arr = str.split(separator: "\n")
                                                    var j = 0
                                                    var origin = ""
                                                    var genres = ""
                                                    var members = ""
                                                    while j < arr.count {
                                                        if arr[j].contains("origin") {
                                                            origin = String((arr[j].split(separator: "=")[1])).replacingOccurrences(of: " ", with: "")
                                                            origin.append("\n")
//                                                            print(origin)
                                                        } else if arr[j].contains("genre") {
                                                            if j+1 != arr.count && !arr[j+1].contains("*") {
                                                                genres = String((arr[j].split(separator: "=")[1])).replacingOccurrences(of: " ", with: "")
                                                                genres.append("\n")
                                                            } else {
                                                                j += 1
                                                                while arr[j].contains("*"){
                                                                    genres.append("\(arr[j].replacingOccurrences(of: "* ", with: ""))\n")
                                                                    j += 1
                                                                }
                                                            }
//                                                            print(genres)
                                                        } else if arr[j].contains("current_members") {
                                                            if j+1 != arr.count && !arr[j+1].contains("*") {
                                                                members = String((arr[j].split(separator: "=")[1])).replacingOccurrences(of: " ", with: "")
                                                                members.append("\n")
                                                            } else {
                                                                j += 1
                                                                while arr[j].contains("*"){
                                                                    members.append("\(arr[j].replacingOccurrences(of: "* ", with: ""))\n")
                                                                    j += 1
                                                                }
//                                                            print(members)
                                                            }
                                                        }
                                                        j += 1
                                                    }
                                                    self.details = artist(origin: origin, genres: genres, members: members)
                                                    print(self.details)
                                                    self.artistNameLabel.text = self.artistName
                                                    self.genreLabel.text = self.details?.genres
                                                    self.originLabel.text = self.details?.origin
                                                    self.membersLabel.text = self.details?.members
                                                
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
            }catch let error {
                print(error.localizedDescription)
            }
        })
        
        task.resume()
        
        
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
