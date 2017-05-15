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
    var songs: [Song] = []
    var songToPlayIndex: Int = 0
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
    
    @IBAction func playNextSong() {
        audioPlayer.stop()
        songToPlayIndex = songToPlayIndex + 1
        if (songToPlayIndex < songs.count) {
            songToPlay = songs[songToPlayIndex]
            playSong()
        } else {
            // is a last song
            // TODO: Change picture to none
            songToPlayIndex = songToPlayIndex - 1
        }
    }
    
    @IBAction func playPreviousSong(){
        audioPlayer.stop()
        songToPlayIndex = songToPlayIndex - 1
        if (songToPlayIndex >= 0) {
            songToPlay = songs[songToPlayIndex]
            playSong()
        } else {
            // is first song
            // TODO: Change picture to none
            songToPlayIndex = songToPlayIndex + 1
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
        
        playSong()
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    func updateTime() {
        if (audioPlayer.isPlaying && updateTimeAllowed) {
            slider.value = Float(audioPlayer.currentTime)
            
            let seconds = Int(audioPlayer.currentTime) % 60
            let minutes = Int(audioPlayer.currentTime) / 60 % 60
            
            if (seconds < 10) {
                endLabel.text = String(minutes) + ":0" + String(seconds)
            } else {
                endLabel.text = String(minutes) + ":" + String(seconds)
            }
        } else {
            
        }
    }
    
    func playSong() {
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: songToPlay.fileName, ofType: "mp3")!))
            audioPlayer.prepareToPlay()
            audioPlayer.play()
            
            if songToPlay.artwork != nil {
                albumImage.image = UIImage(data: songToPlay.artwork!)
            } else {
                albumImage.image = UIImage(named: "rip")
            }
            slider.maximumValue = Float(audioPlayer.duration)
            
        } catch {
            print(error)
        }
    }
}
