//
//  JSONParser.swift
//  KeepUp
//
//  Created by Prateek Kambadkone on 2019/03/28.
//  Copyright © 2019 Prateek Kambadkone. All rights reserved.
//

import Foundation


func searchStringsJSON(json: [String:Any], searchString: String) -> [String] {
    var array: [String] = []
    let jsonKeys = json.keys
    for i in 0..<jsonKeys.count {
        let level1 = json[jsonKeys.index(jsonKeys.startIndex, offsetBy: i)]
        if let level2 = json[level1.key] as? [String:Any] {
            array.append(contentsOf: searchStringsJSON(json: level2, searchString: searchString))
        }
        else if let level2 = json[level1.key] as? [[String:Any]] {
            for i in 0..<level2.count {
                array.append(contentsOf: searchStringsJSON(json: level2[i], searchString: searchString))
            }
        } else if let value = json[level1.key] as? String {
            if value.contains(searchString) {
                array.append(value)
            }
        }
    }
    return array
}
