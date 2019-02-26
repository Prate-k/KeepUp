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
//                                                    print(artistData)
                                                    var p = self.parseHTMLContent(content: artistData)
                                                    self.artistNameLabel.text = self.artistName
                                                    self.genreLabel.text = p.genres
                                                    self.originLabel.text = p.origin
                                                    self.membersLabel.text = p.members
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
    
    private func getArtistDetails(content: [String]) -> (artist) {
        var details = artist(origin: "",genres: "",members: "")
        let type = content[0]
        let origin = content[1]
        let genre = content[2]
        let members = content[3]
        
        var isABand = false
        if type.contains("group_or_band") {
            isABand = true
            print("is a band")
        } else {
            isABand = false
            print("is not a band")
        }
        
        if !isABand {
            details.members = "N/A"
        } else {
            if members.contains("*") {
                var values = members.split(separator: "*")
                for i in 1..<values.count {
                    details.members.append(removeHTMLTags(content: String(values[i])))
                }
            }
        }
    
        var values = origin.split(separator: "=")
        details.origin.append(removeHTMLTags(content: String(values[1])))

        if genre.contains("*") {
            var values = genre.split(separator: "*")
            for i in 1..<values.count {
                details.genres.append(removeHTMLTags(content: String(values[i])))
            }
        } else {
            var values = genre.split(separator: "=")
            print(values)
            details.genres.append(removeHTMLTags(content: String(values[1])))
        }
        return details
    }

    private func removeHTMLTags (content: String) -> String {
        var value = content.replacingOccurrences(of: "* ", with: "").replacingOccurrences(of: "[[", with: "")
                    .replacingOccurrences(of: "]]", with: "").replacingOccurrences(of: "{{", with: "")
                    .replacingOccurrences(of: "}}", with: "").replacingOccurrences(of: "nowrap|", with: "")
                    .replacingOccurrences(of: "hlist|", with: "").replacingOccurrences(of: "flatlist|", with: "")
                    .replacingOccurrences(of: "plainlist|", with: "")
        return value
    }
    private func parseHTMLContent(content: String) -> (artist) {
        var str = content.splitStr(content: "\n| ")
        var cleanStr = ""
        var genre = ""
        var origin = ""
        var type = ""
        var members = ""
        print(str)
        for i in 0..<str.count {
            switch str[i] {
            case let x where str[i].contains("genre") :
                genre = String(x)
            case let x where str[i].contains("origin") :
                origin = String(x)
            case let x where str[i].contains("background") :
                type = String(x)
            case let x where str[i].contains("current_members") :
                members = String(x)
            default:
                continue
            }
        }
        
        
        
        print("type: \(type)")
        print("origin: \(origin)")
        print("genre: \(genre)")
        print("members: \(members)")
        
        
       return self.getArtistDetails(content: [type, origin, genre, members])
    }
    
    
    @IBAction func closeArtistInfo()
    {
        dismiss(animated: true, completion: nil)
    }
}

extension String {
    func splitStr(content: String) -> [String] {
        var values = [String]()
        var i = 0
        var value = ""
        while i+3 < self.count {
            var char = self[self.index(self.startIndex, offsetBy: i)]
            var char1 = self[self.index(self.startIndex, offsetBy: i+1)]
            var char2 = self[self.index(self.startIndex, offsetBy: i+2)]
            if char == "\n" && char1 == "|" && char2 == " " {
                values.append(value)
                value = ""
            } else {
                value.append(char)
            }
            i += 1
        }
        return values
    }
}
