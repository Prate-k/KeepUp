//
//  HTMLParser.swift
//  KeepUp
//
//  Created by Prateek Kambadkone on 2019/03/05.
//  Copyright © 2019 Prateek Kambadkone. All rights reserved.
//

import Foundation

class HTMLParser {
    static func removeHTMLTags (content: String) -> String {
        var value = content
        var noTags = ""
        if (value.contains("<") || value.contains("<!--")) && (value.contains("/>") || (value.contains("</")) || value.contains("-->")) {
            for i in 0..<value.count {
                let char = value[value.index(value.startIndex, offsetBy: i)]
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
        
        value = value.replacingOccurrences(of: "]]", with: "").replacingOccurrences(of: "[[", with: "")
            .replacingOccurrences(of: "}}", with: "").replacingOccurrences(of: "{{", with: "")
        if value.contains("|") {
            value = String(value.split(separator: "|")[1])
        }
        return value
    }
    
   static func parseHTMLContent(content: String) -> [String] {
        var str = content.splitStr(content: "| ")
        var genre = ""
        var origin = ""
        var type = ""
        var members = ""
        var birthPlace = ""
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
            case let value where str[counter].contains("birth_place") :
                birthPlace = String(value)
            default:
                continue
            }
        }
        
//        print("name:\(artistName)")
        print("origin:\(origin)")
        print("born:\(birthPlace)")
        print("genre:\(genre)")
        print("members:\(members)")
        return [type, origin, birthPlace, genre, members]
    }
    
}
