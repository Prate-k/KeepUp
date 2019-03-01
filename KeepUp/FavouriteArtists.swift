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
        if !favouriteList.isEmpty, at >= 0, at < getSize() {
            return favouriteList[at]
        }
        return nil
    }
    public static func addArtist(artist: Artist?) -> (){
        if let artist = artist {
            size += 1
            return favouriteList.append(artist)
        }
    }
    public static func removeArtist(at: Int) -> (){
        if !favouriteList.isEmpty, at >= 0, at < getSize() {
            size -= 1
            favouriteList.remove(at: at)
        }
    }
    public static func getSize() -> Int {
        return favouriteList.count
    }
    public static func isArtistInFavouriteList (name: String) -> Int {
        var index = -1
        for counter in 0..<FavouriteArtists.getSize() {
            if FavouriteArtists.getArtist(at:counter)!.name.elementsEqual(name) {
                index = counter
                break
            }
        }
        return index
    }
}

