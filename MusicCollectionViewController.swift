//
//  MusicCollectionViewController.swift
//  MobileAndMultimediaSystems
//
//  Created by Kamil Szalek on 25/04/2017.
//  Copyright © 2017 Kamil Szalek. All rights reserved.
//

import UIKit
import AVFoundation

private let reuseIdentifier = "Cell"

class MusicCollectionViewController: UICollectionViewController {

    var songs:[Song] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        gettingSongNames()
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return songs.count
    }

    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MusicCollectionViewCell
    
        // Configure the cell
        cell.titleLabel.text = songs[indexPath.row].fileName
        
        return cell
    }

    
    func gettingSongNames() {
        let folderURL = URL(fileURLWithPath: Bundle.main.resourcePath!)
        
        do {
            let songPath = try FileManager.default.contentsOfDirectory(at: folderURL, includingPropertiesForKeys: nil, options: .skipsHiddenFiles)
            
            for song in songPath {
                var mySong = song.absoluteString
                
                if mySong.contains(".mp3") {
                    let findString = mySong.components(separatedBy: "/")
                    mySong = findString[findString.count-1]
                    mySong = mySong.replacingOccurrences(of: ".mp3", with: "")
                    mySong = mySong.removingPercentEncoding!
                    songs.append(getSong(songName: mySong))
                }
            }
        } catch {
            
        }
    }
    
    
    func getSong(songName: String)-> Song {
        let url = URL.init(fileURLWithPath: Bundle.main.path(forResource: songName, ofType: "mp3")!)
        var song: Song = Song(fileName: songName, artist: "",title: "", artwork: "")
        let playerItem = AVPlayerItem(url: url)
        let metadataList = playerItem.asset.metadata
        
        for item in metadataList {
            if item.commonKey != nil && item.stringValue != nil {
                if item.commonKey == "title" {
                    song.title = item.stringValue!
                }
                if item.commonKey == "artist" {
                    song.artist = item.stringValue!
                }
                if item.commonKey == "artwork" {
                    song.artwork = item.stringValue!
                }
            }
        }
        return song
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showMusicPlayer" {
            if let indexPaths = collectionView?.indexPathsForSelectedItems {
                let destinationController = segue.destination as!
                MusicPlayerViewController
                
                destinationController.songToPlay = songs[indexPaths[0].row].fileName
                
                collectionView?.deselectItem(at: indexPaths[0], animated: false)
                
                // Bar customization
                let backItem = UIBarButtonItem()
                backItem.title = "Wróć"
                destinationController.title = "Grid"
            }
        }
    }
}
