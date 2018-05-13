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
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // Ilość sekcji gridu
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    // Przypisanie ilości elementów kolekcji
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return songs.count
    }

    
    // Tworzenie widoku kolekcji
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MusicCollectionViewCell
    
        // Konfiguracja komórki - ustawienie tytułu i obrazka
        cell.titleLabel.text = songs[indexPath.row].fileName
        
        // Przekazywanie kontrollera widoku wewnątrz komórki
        cell.controller = self
        
        // Przekazywanie piosenki
        cell.song = songs[indexPath.row]
        
        if songs[indexPath.row].artwork != nil {
            cell.albumImage.image = UIImage(data: songs[indexPath.row].artwork!)
        } else {
            // Brak okładki
            cell.albumImage.image = UIImage(named: "image-not-available")
        }
        
        return cell
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
