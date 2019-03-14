//
//  ArtistInfoRepositoryExtensions.swift
//  KeepUp
//
//  Created by Prateek Kambadkone on 2019/03/06.
//  Copyright © 2019 Prateek Kambadkone. All rights reserved.
//

import Foundation

protocol ArtistInfoRepositoryFunctionable {
    func getArtistDataFromSource(artistName: String, completing: @escaping (ArtistInfo) -> Void)
}

extension ArtistInfoRepository: ArtistInfoRepositoryFunctionable {
    
    func getArtistDataFromSource(artistName: String, completing: @escaping (ArtistInfo) -> Void) {
        let searchArtistName = artistName.replacingOccurrences(of: " ", with: "_")
        let site = "https://en.wikipedia.org/w/api.php?"
        let query = "action=query&prop=revisions&rvprop=content&format=json&rvsection=0&titles=\(searchArtistName)"
        let networker: Networker = Networker(site: site, query: query, requestType: .GET)
        networker.send(completion: { (data) in
        do {
            if let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [String: Any] {
                print("index of queury \(json.keys)")
                if let query = json["query"] as? [String: Any] {
                    if let pages = query["pages"] as? [String: Any] {
                        let a = pages.first!
                        if let page = pages[a.key] as? [String: Any] {
                            if let revisions = page["revisions"] as? [[String: Any]] {
                                for counter in 0..<revisions.count {
                                    if let temp = revisions[counter] as? [String: Any] {
                                        if let artistData = temp["*"] as? String {
                                                let contents = HTMLParser.parseHTMLContent(content: artistData)
                                                let details = self.refineArtistInfo(values: contents)
                                                completing(details)
//                                                self.artistInfoViewController?.artistInfoShow(info: details)
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
        })
    }
}
