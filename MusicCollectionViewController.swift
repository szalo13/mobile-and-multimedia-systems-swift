//
//  MusicCollectionViewController.swift
//  MobileAndMultimediaSystems
//
//  Created by Kamil Szalek on 25/04/2017.
//  Copyright © 2017 Kamil Szalek. All rights reserved.
//

import UIKit
import AVFoundation

private let reuseIdentifier = "Cell"

class MusicCollectionViewController: UICollectionViewController {

    var songs:[Song] = []
    
    
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
    
        // Configure the cell - title and image
        cell.titleLabel.text = songs[indexPath.row].fileName
        
        if songs[indexPath.row].artwork != nil {
            cell.albumImage.image = UIImage(data: songs[indexPath.row].artwork!)
        } else {
            // no artwork
        }
        
        return cell
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
                    songs.append(getSong(songName: mySong))
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
                if item.commonKey == "artwork" && item.dataValue != nil {
                    song.artwork = item.dataValue!
                }
            }
        }
        return song
    }
    
    
    // Metoda odpowiedzialna za przygotowanie wszystkich potrzebnych informacji
    // Przed wykonaniem przejścia do następnego widoku,
    // Deklarujemy parametry które będą przekazywane z aktualnego widoku do następnego
    // Proces odbywa się dla konkretnego identyfikatora seque
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        //
        // ShowMusicPlayer Seque
        //
        // Sprawdzenie czy nazwa seque nazywa się showMusicPlayer
        // Nazwa ta powina być zadeklarowana przy tworzeniu seque
        if segue.identifier == "showMusicPlayer" {
            if let indexPaths = collectionView?.indexPathsForSelectedItems {
                
                // Określenie klasy, jaka odpowiada docelowemu widokowi
                // W tym przypadku punktem odbioru jest controller odpowiadający
                // instancji klasy MusicPlayerViewController
                let destinationController = segue.destination as!
                MusicPlayerViewController
                
                // Przekazujemy informacje do docelowego kontrolera
                // Tablice z wszystkimi elementami tablicy
                // Konkretny index tablicy odpowiadający wybranemu aktualnie utoworowi
                // Konkretną wybraną piosenkę
                destinationController.songs = songs
                destinationController.songToPlayIndex = indexPaths[0].row
                destinationController.songToPlay = songs[indexPaths[0].row]
                
                collectionView?.deselectItem(at: indexPaths[0], animated: false)
                
                // Ustawiamy jak ma wyglądać UIBarButton w docelowym widoku
                // Przycisk powrotny będzie posiadał label "Wróć"
                // Natomiast sam widok będzie się nazywał "Odtwarzacz Mp3"
                let backItem = UIBarButtonItem()
                backItem.title = "Wróć"
                destinationController.title = "Odtwarzacz Mp3"
            }
        }
    }
}
