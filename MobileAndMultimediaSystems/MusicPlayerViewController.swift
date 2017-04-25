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
    
    @IBOutlet weak var startLabel: UILabel!
    @IBOutlet weak var endLabel: UILabel!
    
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

        do {
            print("try")
            audioPlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "sample1", ofType: "mp3")!))
            print("prepare")
            audioPlayer.prepareToPlay()
            
        } catch {
            print(error)
        }
        
        // Do any additional setup after loading the view.
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
