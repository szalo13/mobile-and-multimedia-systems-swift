//
//  MusicCollectionViewCell.swift
//  MobileAndMultimediaSystems
//
//  Created by Kamil Szalek on 25/04/2017.
//  Copyright © 2017 Kamil Szalek. All rights reserved.
//

import UIKit

class MusicCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var albumImage: UIImageView!
    @IBOutlet var addButton: UIButton!
    
    // Deklaracja zmiennej kontrollera który jest przekazywany wewnątrz komórki
    // MusicCollectionViewCell
    weak var controller: MusicCollectionViewController!
    
    // Deklaracja zmiennej odpowiedzialnej za przechowywanie piosenki
    var song: Song?
    
    @IBAction func addSong(_ sender: Any) {
        // 1. Deklaracja option menu
        let optionMenu = UIAlertController(title: nil, message: "Czy chcesz dodać piosenkę?", preferredStyle: .actionSheet)
        
        // 2. Deklaracja przycisku 'Dodaj'
        let addAction = UIAlertAction(title: "Dodaj", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            // Akcja do wykonania
            librarySongs.append(self.song!)
            print("Dodawanie piosenki")
        })
        
        // 3. Deklaracja przycisku 'Anuluj'
        let cancelAction = UIAlertAction(title: "Anuluj", style: .cancel, handler: {
            (alert: UIAlertAction!) -> Void in
            print("Zamkniecie menu")
        })
        
        // 4. Dodanie przycisków do zadeklarowanego option menu
        optionMenu.addAction(addAction)
        optionMenu.addAction(cancelAction)
        
        // 5. Wyświetlenie zadeklarowanego menu
        self.controller.present(optionMenu, animated: true, completion: nil)
    }
    
    
}
