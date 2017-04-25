//
//  MusicPlayerViewController.swift
//  MobileAndMultimediaSystems
//
//  Created by Kamil Szalek on 25/04/2017.
//  Copyright © 2017 Kamil Szalek. All rights reserved.
//

import UIKit
import AVFoundation

var audioPlayer = AVAudioPlayer()
var songAlreadyPlaying: String = ""

class MusicPlayerViewController: UIViewController {

    var songToPlay: Song = Song(fileName: "", artist: "", title: "", artwork: nil)
    var timer: Timer!
    var updateTimeAllowed: Bool = true
    
    @IBOutlet weak var startLabel: UILabel!
    @IBOutlet weak var endLabel: UILabel!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var albumImage: UIImageView!
    
    @IBAction func play(_ sender: Any) {
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
    
    @IBAction func changeTime(_ sender: Any) {
        audioPlayer.currentTime = TimeInterval(slider.value)
        updateTimeAllowed = true
    }
    
    @IBAction func stopTimeUpdate(_ sender: Any) {
        updateTimeAllowed = false
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: songToPlay.fileName, ofType: "mp3")!))
            audioPlayer.prepareToPlay()
            audioPlayer.play()
            albumImage.image = UIImage(data: songToPlay.artwork!)
            slider.maximumValue = Float(audioPlayer.duration)
            
        } catch {
            print(error)
        }
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    func updateTime() {
        if (audioPlayer.isPlaying && updateTimeAllowed) {
            slider.value = Float(audioPlayer.currentTime)
            endLabel.text = String(audioPlayer.currentTime)
        } else {
            
        }
    }
}
