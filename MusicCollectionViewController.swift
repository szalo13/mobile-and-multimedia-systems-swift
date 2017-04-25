//
//  MusicCollectionViewController.swift
//  MobileAndMultimediaSystems
//
//  Created by Kamil Szalek on 25/04/2017.
//  Copyright © 2017 Kamil Szalek. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class MusicCollectionViewController: UICollectionViewController {

    var songs:[String] = []
    
    
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
        cell.titleLabel.text = songs[indexPath.row]
        
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
                    songs.append(mySong)
                }
            }
        } catch {
            
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showMusicPlayer" {
            if let indexPaths = collectionView?.indexPathsForSelectedItems {
                let destinationController = segue.destination as!
                MusicPlayerViewController
                
                destinationController.song = songs[indexPaths[0].row]
                
                collectionView?.deselectItem(at: indexPaths[0], animated: false)
                
                // Bar customization
                let backItem = UIBarButtonItem()
                backItem.title = "Wróć"
                destinationController.title = "Grid"
            }
        }
    }
}
