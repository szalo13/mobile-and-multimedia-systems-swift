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

    @IBOutlet weak var videoView: YouTubePlayerView!
    
    @IBAction func btnPlay(_ sender: UIButton) {
        videoView.play()
    }
    
    
    @IBAction func btnPause(_ sender: UIButton) {
        
        videoView.playerVars = [
            "playsinline": 1 as AnyObject,
            "showinfo": 0 as AnyObject,
            "controls": 0 as AnyObject,
            "end": 5 as AnyObject,
            "rel": 0 as AnyObject,
        ]
        videoView.loadVideoID("m9hnHaxsqGw")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Video player config
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
