//
//  Error.swift
//  KeepUp
//
//  Created by Prateek Kambadkone on 2019/03/20.
//  Copyright © 2019 Prateek Kambadkone. All rights reserved.
//

import Foundation

enum Result<Value> {
    case success(Value), failure(Errors)
}

enum Errors {
    case EmptySearch
    case InvalidInput
    case NetworkError
    case Unknown
}
