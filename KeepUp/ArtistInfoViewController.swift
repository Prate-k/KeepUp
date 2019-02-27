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
    
    struct Artist {
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
        
        let task = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) in
            guard error == nil else {
                return
            }
            guard let data = data else {
                return
            }
            DispatchQueue.main.async {
                do {
                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                        print("index of queury \(json.keys)")
                        if let query = json["query"] as? [String: Any] {
                            if let pages = query["pages"] as? [String: Any] {
                                let a = pages.first!
                                if let page = pages[a.key] as? [String: Any] {
                                    if let revisions = page["revisions"] as? [[String: Any]] {
                                        for counter in 0..<revisions.count {
                                            if let temp = revisions[counter] as? [String: Any] {
                                                if let artistData = temp["*"] as? String {
                                                    self.scrollView.isHidden = false
                                                    self.waitForDataIndicator.stopAnimating()
                                                    var details = self.parseHTMLContent(content: artistData)
                                                    self.artistNameLabel.text = self.artistName
                                                    self.genreLabel.text = details.genres
                                                    self.originLabel.text = details.origin
                                                    self.membersLabel.text = details.members
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                } catch let error {
                    print(error.localizedDescription)
                }
            }
        })
        task.resume()
    }
    
    private func getArtistDetails(content: [String]) -> (Artist) {
        var details = Artist(origin: "",genres: "",members: "")
        let type = content[0]
        let origin = content[1]
        let genre = content[2]
        let members = content[3]
        
        var isABand = false
        if type.contains("group_or_band") {
            isABand = true
//            print("is a band")
        } else {
            isABand = false
//            print("is not a band")
        }
        
        if !isABand {
            details.members = "N/A"
        } else {
            if members.contains("*") {
                var values = members.split(separator: "*")
                for counter in 1..<values.count {
                    details.members.append(removeHTMLTags(content: String(values[counter])))
                }
            }
        }
        
        if !origin.isEmpty {
            var values = origin.split(separator: "=")
            details.origin.append(removeHTMLTags(content: String(values[1])))
        } else {
            details.origin = "N/A"
        }
        
        if genre.contains("*") {
            var values = genre.split(separator: "*")
            for counter in 1..<values.count {
                let value = removeHTMLTags(content: String(values[counter]))
                if !value.isEmpty {
                    details.genres.append(value)
                }
            }
        } else {
            if !genre.isEmpty {
                var values = genre.split(separator: "=")
                details.genres.append(removeHTMLTags(content: String(values[1])))
            } else {
                details.genres = "N/A"
            }
        }
        return details
    }

    private func removeHTMLTags (content: String) -> String {
        var value = content
        value = value.replacingOccurrences(of: "]]", with: "").replacingOccurrences(of: "[[", with: "")
                    .replacingOccurrences(of: "}}", with: "").replacingOccurrences(of: "{{", with: "")
        if value.contains("|") {
            value = String(value.split(separator: "|")[1])
        }
        var noTags = ""
        if (value.contains("<") || value.contains("<!--        ")) && (value.contains("/>") || (value.contains("</")) || value.contains("-->")) {
            for i in 0..<value.count {
                var char = value[value.index(value.startIndex, offsetBy: i)]
                if char == "<" {
                    noTags.append("\n")
                    break
                } else {
                    noTags.append(char)
                }
            }
            value = noTags
        }
        if value.contains("url=") {
            value = ""
        }
        return value
    }
    
    private func parseHTMLContent(content: String) -> (Artist) {
        var str = content.splitStr(content: "| ")
        var cleanStr = ""
        var genre = ""
        var origin = ""
        var type = ""
        var members = ""
        for counter in 0..<str.count {
            switch str[counter] {
            case let value where str[counter].contains("genre"):
                genre = String(value)
            case let value where str[counter].contains("origin") :
                origin = String(value)
            case let value where str[counter].contains("background") :
                type = String(value)
            case let value where str[counter].contains("current_members") :
                members = String(value)
            default:
                continue
            }
        }
       return self.getArtistDetails(content: [type, origin, genre, members])
    }
    @IBAction func closeArtistInfo() {
        dismiss(animated: true, completion: nil)
    }
}

extension String {
    func splitStr(content: String) -> [String] {
        var values = [String]()
        var counter = 0
        var value = ""
        while counter+3 < self.count {
            var char = self[self.index(self.startIndex, offsetBy: counter)]
            var char1 = self[self.index(self.startIndex, offsetBy: counter+1)]
            var char2 = self[self.index(self.startIndex, offsetBy: counter+2)]
            if char == "\n" && char1 == "|" && char2 == " " {
                value.append("\n")
                values.append(value)
                value = ""
            } else {
                value.append(char)
            }
            counter += 1
        }
        return values
    }
}
