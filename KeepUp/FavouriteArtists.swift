//
//  staticMembers.swift
//  KeepUp
//
//  Created by Prateek Kambadkone on 2019/02/15.
//  Copyright © 2019 Prateek Kambadkone. All rights reserved.
//

import Foundation

class FavouriteArtists {
    private static var favouriteList = [Artist]()
    public static var size = 0
    
    
    public static func getArtist(at: Int) -> Artist?{
        if favouriteList.count > 0, at >= 0, at < favouriteList.count {
            return favouriteList[at]
        }
        return nil
    }
    
    public static func addArtist(artist: Artist?) -> (){
        if let a = artist {
            size += 1
            return favouriteList.append(a)
        }
    }
    
    public static func removeArtist(at: Int) -> (){
        if favouriteList.count > 0, at >= 0, at < favouriteList.count {
            size -= 1
            favouriteList.remove(at: at)
        }
    }
    
    public static func getSize() -> Int {
        return favouriteList.count
    }
}
