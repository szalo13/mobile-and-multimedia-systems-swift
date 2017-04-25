//
//  song.swift
//  MobileAndMultimediaSystems
//
//  Created by Kamil Szalek on 25/04/2017.
//  Copyright © 2017 Kamil Szalek. All rights reserved.
//

import Foundation

struct Song {
    var fileName: String = ""
    var artist: String = ""
    var title: String = ""
    var artwork: String = ""
    
    init(fileName: String, artist: String, title: String, artwork: String){
        self.fileName = fileName
        self.artist = artist
        self.title = title
        self.artwork = artwork
    }
}
