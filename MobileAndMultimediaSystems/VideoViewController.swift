//
//  VideoViewController.swift
//  MobileAndMultimediaSystems
//
//  Created by Kamil Szalek on 24/06/2017.
//  Copyright © 2017 Kamil Szalek. All rights reserved.
//

import UIKit
import YouTubePlayer_Swift

class VideoViewController: UIViewController {
    
    var videoToPlayIndex = 0
    var maxSecondsToPlay = 20
    var videos = [
        "m9hnHaxsqGw",
        "jG7dSXcfVqE",
        "V6Y-ahQFQDA",
        ]
    
    @IBOutlet weak var videoView: YouTubePlayerView!
    
    @IBAction func btnPlay(_ sender: UIButton) {
        videoView.play()
    }
    
    @IBAction func btnPause(_ sender: UIButton) {
        videoView.pause()
    }
    
    @IBAction func btnNext(_ sender: UIButton) {
        videoView.stop()
        videoToPlayIndex = videoToPlayIndex + 1
        if (videoToPlayIndex < videos.count) {
            videoView.loadVideoID(videos[videoToPlayIndex])
            videoView.play()
        } else {
            // is a last song
            videoToPlayIndex = videoToPlayIndex - 1
        }
    }
    
    @IBAction func btnPrevious(_ sender: UIButton){
        videoView.stop()
        videoToPlayIndex = videoToPlayIndex - 1
        if (videoToPlayIndex >= 0) {
            videoView.loadVideoID(videos[videoToPlayIndex])
            videoView.play()
        } else {
            // is first song
            videoToPlayIndex = videoToPlayIndex + 1
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        videoView.playerVars = [
            "playsinline": 1 as AnyObject,
            "showinfo": 0 as AnyObject,
            "controls": 0 as AnyObject,
            "end": maxSecondsToPlay as AnyObject,
            "rel": 0 as AnyObject,
        ]
        
        videoView.loadVideoID(videos[videoToPlayIndex])
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
