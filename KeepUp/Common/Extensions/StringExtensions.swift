//
//  StringExtensions.swift
//  KeepUp
//
//  Created by Prateek Kambadkone on 2019/03/05.
//  Copyright © 2019 Prateek Kambadkone. All rights reserved.
//

import Foundation

extension String {
    func splitStr(content: String) -> [String] {
        var values = [String]()
        var counter = 0
        var value = ""
        while counter+3 < self.count {
            let char = self[self.index(self.startIndex, offsetBy: counter)]
            let char1 = self[self.index(self.startIndex, offsetBy: counter+1)]
            let char2 = self[self.index(self.startIndex, offsetBy: counter+2)]
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
