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
        scrollView.isHidden = true
        waitForDataIndicator.isHidden = false
        waitForDataIndicator.startAnimating()
        
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
            var result = String(data: data, encoding: String.Encoding.utf8) ?? ""
            
            print(result)
            
            DispatchQueue.main.async {
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
                                                    
                                                    self.scrollView.isHidden = false
                                                    self.waitForDataIndicator.stopAnimating()
//                                                    print("data: \(artistData)")
                                                    let (origin, genres, members) = self.parseHTMLContent(content: self.removeHTMLTags(content: artistData))
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
            }
        })
        
        task.resume()
        
    }
    
    private func parseHTMLContent(content: String) -> (origin: String, genres: String, members: String) {
        var str = content
        var neededValues: [String] = []
        var isBackgroundFound: Bool = false
        var isGenreFound: Bool = false
        var isOriginFound: Bool = false
        var isMembersFound: Bool = false
        
        let lines = str.split(separator: "|")
        for i in 0..<lines.count {
            switch String(lines[i]) {
            case let line where line.contains("background") && !isBackgroundFound :
                neededValues.append(String(line))
                isBackgroundFound = true
            case let line where line.contains("origin") && !isOriginFound:
                neededValues.append(String(line))
                isOriginFound = true
            case let line where line.contains("genre") && !isGenreFound:
                neededValues.append(String(line))
                isGenreFound = true
            case let line where line.contains("current_members") && !isMembersFound:
                isMembersFound = true
                neededValues.append(String(line))
            default:
                continue
            }
        }
        
        print(neededValues)
        var origin = ""
        var genres = ""
        var members = ""
        
        var isABand: Bool = false
        for i in 0..<neededValues.count {
            if neededValues[i].contains("background") {
                let values: String = String(neededValues[i].split(separator: "=")[1])
                if values.contains("solo_singer") {
                    isABand = false
                    print("\(artistName) is not a band")
                } else if values.contains("group_or_band"){
                    isABand = true
                    print("\(artistName) is a band")
                }
            } else if neededValues[i].contains("origin") {
                origin = String(neededValues[i].split(separator: "=")[1])
            } else if neededValues[i].contains("genre") {
                let values = String(neededValues[i].split(separator: "=")[1])
                let data = values.split(separator: "\n")
                if data.count > 0 {
                    for j in 0..<data.count {
                        genres.append(contentsOf: "\(data[j]) \n")
                        genres = genres.replacingOccurrences(of: "* ", with: "")
                    }
                } else {
                    genres = String(neededValues[i].split(separator: "=")[1])
                }
            } else if neededValues[i].contains("current_members") {
                if isABand {
                    let values = String(neededValues[i].split(separator: "=")[1])
                    let data = values.split(separator: "\n")
                    if data.count > 0 {
                        for j in 0..<data.count {
                            members.append(contentsOf: "\(data[j]) \n")
                            members = members.replacingOccurrences(of: "* ", with: "")
                        }
                    }
                } else {
                    members = "N/A"
                }
            }
        }
        return (origin, genres, members)
    }

    private func removeHTMLTags(content: String) -> String {
//        var str = content.replacingOccurrences(of: "[", with: "")
//            .replacingOccurrences(of: "]", with: "")
//            .replacingOccurrences(of: "{", with: "")
//            .replacingOccurrences(of: "}", with: "")
//            .replacingOccurrences(of: "nowrap|", with: "")
//            .replacingOccurrences(of: "flatlist|", with: "")
        var str = content
        var cleanStr = ""
        
        var i: Int = 0
        while i < str.count {
            if str[str.index(str.startIndex, offsetBy: i)] == "<" {
                i += 1
                while str[str.index(str.startIndex, offsetBy: i)] != ">" {
                    i += 1
                }
                i += 1
            }
            if i < str.count {
                cleanStr.append(contentsOf: "\(str[str.index(str.startIndex, offsetBy: i)])")
            }
            i += 1
        }
        var cleanerStr = ""
        i = 0
        while i < cleanStr.count {
            if cleanStr[cleanStr.index(cleanStr.startIndex, offsetBy: i)] == "|" {
                
            }
        }
        return cleanStr
    }
    
    
    @IBAction func closeArtistInfo()
    {
        dismiss(animated: true, completion: nil)
    }

}

