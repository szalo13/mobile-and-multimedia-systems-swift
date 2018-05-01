//
//  MainMenuViewController.swift
//  MobileAndMultimediaSystems
//
//  Created by Szalo on 01.05.2018.
//  Copyright © 2018 Kamil Szalek. All rights reserved.
//

import UIKit
import AVFoundation

class MainMenuViewController: UIViewController {

    var songs:[Song] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.gettingSongNames()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


    // Metoda odpowiedzialna za pobieranie nazw piosenek
    // Pobieranie piosenek odbywa się dla zdefiniowanego folderu głównego biblioteki muzycznej
    func gettingSongNames() {
        // Zdefiniowanie głównej ścieżki docelowej folderu z muzyką
        let folderURL = URL(fileURLWithPath: Bundle.main.resourcePath!)
        
        // Próba znalezienia piosenek wewnątrz zdefiniowanego folderu
        // W przypadku wystąpienia błędu aplikacja przechodzi do instrukcji catch
        do {
            // Pobranie ścieżek docelowych piosenek
            let songPaths = try FileManager.default.contentsOfDirectory(at: folderURL, includingPropertiesForKeys: nil, options: .skipsHiddenFiles)
            
            // Iteracja po elementach tablicy w których znajdują się ścieżki piosenek
            for song in songPaths {
                var mySong = song.absoluteString
                
                // Sprawdzenie czy piosenka jest w formacie MP3
                // Następnie następuje pobranie nazwy piosenki z ścieżki pliku
                // formatowanie nazwy do czytelnej formy
                // A na końcu dodanie piosenek do tablicy zawierającej wszystkie piosenki
                if mySong.contains(".mp3") {
                    let findString = mySong.components(separatedBy: "/")
                    mySong = findString[findString.count-1]
                    mySong = mySong.replacingOccurrences(of: ".mp3", with: "")
                    mySong = mySong.removingPercentEncoding!
                    self.songs.append(getSong(songName: mySong))
                }
            }
        } catch {
            // Wyłapywanie błędów
        }
    }
    
    // Pobieranie wszystkich informacji na temat piosenki
    // Artysty, nazwy, ścieżki dla okładki piosenki
    func getSong(songName: String)-> Song {
        let url = URL.init(fileURLWithPath: Bundle.main.path(forResource: songName, ofType: "mp3")!)
        var song: Song = Song(fileName: songName, artist: "",title: "", artwork: nil)
        let playerItem = AVPlayerItem(url: url)
        let metadataList = playerItem.asset.metadata
        
        for item in metadataList {
            if item.commonKey != nil {
                if item.commonKey == "title" && item.stringValue != nil {
                    song.title = item.stringValue!
                }
                if item.commonKey == "artist" && item.stringValue != nil {
                    song.artist = item.stringValue!
                }
                if item.commonKey == "artwork" {
                    song.artwork = item.dataValue!
                }
            }
        }
        return song
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        //
        // showAdminPanel Seque
        //
        // Sprawdzenie czy nazwa seque nazywa się showAdminPanel
        // Nazwa ta powina być zadeklarowana przy tworzeniu seque
        if segue.identifier == "showAdminPanel" {
            
            let destinationController = segue.destination as!
            MusicCollectionViewController
            
            // Przekazujemy informacje do docelowego kontrolera
            // Tablice z wszystkimi znalezionymi piosenkami
            destinationController.songs = songs
            
            // Ustawiamy jak ma wyglądać UIBarButton w docelowym widoku
            // Przycisk powrotny będzie posiadał label "Wróć"
            // Natomiast sam widok będzie się nazywał "Panel Admina"
            let backItem = UIBarButtonItem()
            backItem.title = "Wróć"
            destinationController.title = "Panel Admina"
        }
    }

}
