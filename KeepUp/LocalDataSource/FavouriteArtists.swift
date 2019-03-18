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

    static func getList() -> [Artist] {
        return favouriteList
    }
    
    
    static var size = 0
    static func getArtist(at: Int) -> Artist? {
        if !favouriteList.isEmpty, at >= 0, at < getSize() {
            return favouriteList[at]
        }
        return nil
    }

    static func getArtist(by name: String) -> Artist? {
        if !favouriteList.isEmpty && !name.isEmpty {
            for artist in favouriteList {
                if artist.artistName.elementsEqual(name) {
                    return artist
                }
            }
        }
        return nil
    }

    static func addArtist(artist: Artist?) {
        if let artist = artist {
            size += 1
            favouriteList.append(artist)
        }
    }
    static func removeArtist(at: Int) {
        if !favouriteList.isEmpty, at >= 0, at < getSize() {
            size -= 1
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
        for i in 0..<10 {
            favouriteList.append(Artist(name: "Artist \(i)", genre: "Rock", imageUrl: "dummyArtist"))
            for artist in favouriteList where artist.artistAlbums.isEmpty {
                var num = 1
                for i in 0..<3 {
                    var songs: [Song] = []
                    for j in 0..<3 {
                        songs.append(Song(songTitle: "song \(num)",
                            songLyrics: "",
                            songLength: "3:4\(j+1)",
                            isHidden: false))
                        num += 1
                    }
                    artist.artistAlbums.append(Album(albumName: "album \(i+1)",
                        albumReleaseDate: ReleasedDate(releasedMonth: "Oct", releasedYear: 2000),
                        albumArtUrl: "dummyAlbum",
                        albumTracks: songs))
                }
            }
        }
    }
}
