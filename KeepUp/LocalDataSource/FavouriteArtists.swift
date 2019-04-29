//
//  staticMembers.swift
//  KeepUp
//
//  Created by Prateek Kambadkone on 2019/02/15.
//  Copyright © 2019 Prateek Kambadkone. All rights reserved.
//

import Foundation

class FavouriteArtists {
    private static var favouriteList = [SelectedArtist]()

    static func getList() -> [SelectedArtist] {
        return favouriteList
    }
    
    static var size = 0
    static func getArtist(at: Int) -> SelectedArtist? {
        if !favouriteList.isEmpty, at >= 0, at < getSize() {
            return favouriteList[at]
        }
        return nil
    }

    static func getArtist(by name: String) -> SelectedArtist? {
        if !favouriteList.isEmpty && !name.isEmpty {
            for artist in favouriteList {
                if artist.artistName.elementsEqual(name) {
                    return artist
                }
            }
        }
        return nil
    }

    static func addArtist(artist: SelectedArtist?) {
        if let artist = artist {
            size += 1
            favouriteList.append(artist)
        }
    }
    static func removeArtist(at: Int) {
        if !favouriteList.isEmpty, at >= 0, at < getSize() {
            size -= 1
            print("removing: \(favouriteList[at].artistName)")
            favouriteList.remove(at: at)
        }
    }
    
    static func getSize() -> Int {
        return favouriteList.count
    }
    
    static func isArtistInFavouriteList (name: String) -> Int {
        var index = -1
        for counter in 0..<FavouriteArtists.getSize() {
            if let artist = FavouriteArtists.getArtist(at: counter) {
                if artist.artistName.elementsEqual(name) {
                    index = counter
                    break
                }
            }
        }
        return index
    }
    
    static func isEmpty() -> Bool {
        if getSize() == 0 {
            return true
        } else {
            return false
        }
    }
    
    static func insertTestArtists () {
//        for i in 1..<10 {
//            favouriteList.append(Artist(name: "Artist \(i)", genre: "Rock", imageUrl: "dummyArtist"))
//            for artist in favouriteList where artist.artistAlbums.isEmpty {
//                var num = 1
//                for i in 0..<3 {
//                    var songs: Songs = []
//                    for j in 0..<3 {
//                        songs.append(Song(songID: num,
//                            songName: "",
//                            songLength: j+1,
//                            songLengthText: false))
//                        num += 1
//                    }
////                    artist.artistAlbums.append(Album(albumName: "album \(i+1)",
////                        albumReleaseDate: ReleasedDate(releasedMonth: "Oct", releasedYear: 2000),
////                        albumArtUrl: "dummyAlbum",
////                        albumTracks: songs))
//                }
//            }
//        }
        
//        favouriteList[0].artistName = "Linkin Park"
//        favouriteList[1].artistName = "Taylor Swift"
//        favouriteList[2].artistName = "12 Stones"
    }
}
