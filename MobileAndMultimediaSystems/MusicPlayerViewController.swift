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

    // Definicja music playera
    var audioPlayer = AVAudioPlayer()
    
    // Definicja podstawowych zmiennych
    var songToPlay: Song = Song(fileName: "", artist: "", title: "", artwork: nil)
    var songs: [Song] = []
    var songToPlayIndex: Int = 0
    var timer: Timer!
    var updateTimeAllowed: Bool = true
    
    // Stworzenie zmiennych polaczonych z widokiem
    @IBOutlet weak var startLabel: UILabel!
    @IBOutlet weak var endLabel: UILabel!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var albumImage: UIImageView!
    
    // Definicja zmiennych akcji
    // Odtworzenie aktualnie wybranej piosenki
    @IBAction func play(_ sender: Any) {
        self.audioPlayer.play()
    }
    
    // Pauza aktualnie wybranej piosenki
    @IBAction func pause(_ sender: Any) {
        if (self.audioPlayer.isPlaying){
            self.audioPlayer.pause()
        } else {
            
        }
    }
    
    // Restart aktualnie wybranej piosenki
    // Jeśli odtwaracz aktualnie odtwarza muzyke:
    // - zastopowanie muzyki, zmiana czasu na 0, odtworzenie ponowne
    @IBAction func restart(_ sender: Any) {
        if (self.audioPlayer.isPlaying){
            self.audioPlayer.stop()
            self.audioPlayer.currentTime = 0
            self.audioPlayer.play()
        } else {
            self.audioPlayer.currentTime = 0
            self.audioPlayer.play()
        }
    }
    
    // Zmiana aktualnie wyświetlanego czasu oraz pozycji slidera
    @IBAction func changeTime(_ sender: Any) {
        self.audioPlayer.currentTime = TimeInterval(slider.value)
        updateTimeAllowed = true
    }
    
    // Zablokowanie updatu slidera
    @IBAction func stopTimeUpdate(_ sender: Any) {
        updateTimeAllowed = false
    }
    
    // Granie nastepnej piosenki
    // Jesli piosenka jest ostatnią to wybiera ją ponownie
    @IBAction func playNextSong() {
        self.audioPlayer.stop()
        songToPlayIndex = songToPlayIndex + 1
        
        // Sprawdzenie czy piosenka jest ostatnią piosenką
        if (songToPlayIndex < songs.count) {
            songToPlay = songs[songToPlayIndex]
            playSong()
        } else {
            songToPlayIndex = songToPlayIndex - 1
        }
    }
    
    // Granie poprzedniej piosenki
    // Jeśli wybrana piosenka jest pierwszą, to odtworzenie jej ponownie
    @IBAction func playPreviousSong(){
        self.audioPlayer.stop()
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
    
    // Metoda wywoływana podczas załadowania widoku
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Ustawienie timera
        // Timer ma za zadanie odświeżać czas piosenki
        // oraz progress slider w odstępach 0.1s
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
        
        // Odtworzenie piosenki
        playSong()
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // Funkcja odpowiedzialna za update aktualnego czasu odtwarzania
    func updateTime() {
        if (self.audioPlayer.isPlaying && updateTimeAllowed) {
            slider.value = Float(self.audioPlayer.currentTime)
            
            let seconds = Int(self.audioPlayer.currentTime) % 60
            let minutes = Int(self.audioPlayer.currentTime) / 60 % 60
            
            if (seconds < 10) {
                endLabel.text = String(minutes) + ":0" + String(seconds)
            } else {
                endLabel.text = String(minutes) + ":" + String(seconds)
            }
        } else {
            
        }
    }
    
    // Funkcja odpowiedzialna za odtworzenie piosenki
    func playSong() {
        do {
            
            // Sprawdzenie czy AVAudioPlayer może odtworzyć piosenkę
            // A także czy piosenka jest w formacie mp3
            // Przygotowanie do odtworzenia
            // Odtworzenie piosenki
            self.audioPlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: songToPlay.fileName, ofType: "mp3")!))
            self.audioPlayer.prepareToPlay()
            self.audioPlayer.play()
            
            // Sprawdzenie czy piosenka posiada okładkę
            // Jeśli piosenka nie posiada okładki zostaje wybrany zdefiniowany obrazek
            // Z biblioteki obrazków znajdującej się w folderze Assets.xcassets
            // Wybrany obrazek odpowiada obrazkowi o podanej nazwie: "image-not-available"
            if songToPlay.artwork != nil {
                albumImage.image = UIImage(data: songToPlay.artwork!)
            } else {
                albumImage.image = UIImage(named: "image-not-available")
            }
            
            // Określenie maksymalnej wartości slidera odpowiadającej długości piosenki
            slider.maximumValue = Float(self.audioPlayer.duration)
            
        } catch {
            print(error)
        }
    }
}
