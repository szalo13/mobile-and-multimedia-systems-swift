//
//  MusicPlayerViewController.swift
//  MobileAndMultimediaSystems
//
//  Created by Kamil Szalek on 25/04/2017.
//  Copyright © 2017 Kamil Szalek. All rights reserved.
//

import UIKit
import AVFoundation

class MusicPlayerViewController: UIViewController {

    var audioPlayer = AVAudioPlayer()
    var timer: Timer!
    
    @IBOutlet weak var startLabel: UILabel!
    @IBOutlet weak var endLabel: UILabel!
    @IBOutlet weak var slider: UISlider!
    
    @IBAction func play(_ sender: Any) {
        print("play")
        audioPlayer.play()
    }
    
    @IBAction func pause(_ sender: Any) {
        if (audioPlayer.isPlaying){
            audioPlayer.pause()
        } else {
            
        }
    }
    
    @IBAction func restart(_ sender: Any) {
        if (audioPlayer.isPlaying){
            audioPlayer.stop()
            audioPlayer.currentTime = 0
            audioPlayer.play()
        } else {
            audioPlayer.currentTime = 0
            audioPlayer.play()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "sample1", ofType: "mp3")!))
            audioPlayer.prepareToPlay()
            
            slider.maximumValue = Float(audioPlayer.duration)
            
        } catch {
            print(error)
        }
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
     func updateTime() {
        slider.value = Float(audioPlayer.currentTime)
        endLabel.text = String(audioPlayer.currentTime)
        startLabel.text = String(Float(audioPlayer.currentTime))
    }

}
