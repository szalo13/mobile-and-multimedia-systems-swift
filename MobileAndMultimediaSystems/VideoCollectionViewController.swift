//
//  VideoCollectionViewController.swift
//  MobileAndMultimediaSystems
//
//  Created by Kamil Szalek on 26/04/2017.
//  Copyright © 2017 Kamil Szalek. All rights reserved.
//

import UIKit
import AVFoundation

private let reuseIdentifier = "Cell"

class VideoCollectionViewController: UICollectionViewController {
    
    var videos:[String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        gettingVideosNames()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return videos.count
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! VideoCollectionViewCell
        
        let youTubeURL = "https://www.youtube.com/embed/jG7dSXcfVqE"
        let htmlString = "<iframe width=\"\(cell.webView.frame.width)\" height=\"\(cell.webView.frame.height)\" src=\"\(youTubeURL)?&playsinline=1\" frameborder=\"0\" allowfullscreen></iframe>"
        
        print(htmlString)
        
        cell.webView.allowsInlineMediaPlayback = true
        cell.webView.loadHTMLString( htmlString, baseURL: nil)
        // Configure the cell - title and image
        //        cell.titleLabel.text = videos[indexPath.row].fileName
        
        //        if videos[indexPath.row].artwork != nil {
        //            cell.albumImage.image = UIImage(data: songs[indexPath.row].artwork!)
        //        } else {
        //            // no artwork
        //        }
        
        return cell
    }
    
    
    func gettingVideosNames() {
        videos.append("https://www.youtube.com/embed/jG7dSXcfVqE")
    }
    
    
//    func getSong(songName: String)-> Song {
//        let url = URL.init(fileURLWithPath: Bundle.main.path(forResource: songName, ofType: "mp3")!)
//        var song: Song = Song(fileName: songName, artist: "",title: "", artwork: nil)
//        let playerItem = AVPlayerItem(url: url)
//        let metadataList = playerItem.asset.metadata
//        
//        for item in metadataList {
//            if item.commonKey != nil {
//                if item.commonKey == "title" && item.stringValue != nil {
//                    song.title = item.stringValue!
//                }
//                if item.commonKey == "artist" && item.stringValue != nil {
//                    song.artist = item.stringValue!
//                }
//                if item.commonKey == "artwork" && item.dataValue != nil {
//                    song.artwork = item.dataValue!
//                }
//            }
//        }
//        return song
//    }
    
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "showMusicPlayer" {
//            if let indexPaths = collectionView?.indexPathsForSelectedItems {
//                let destinationController = segue.destination as!
//                MusicPlayerViewController
//                
//                destinationController.songToPlay = songs[indexPaths[0].row]
//                
//                collectionView?.deselectItem(at: indexPaths[0], animated: false)
//                
//                // Bar customization
//                let backItem = UIBarButtonItem()
//                backItem.title = "Wróć"
//                destinationController.title = "Grid"
//            }
//        }
//    }
}
