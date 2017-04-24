//
//  IconCollectionViewController.swift
//  MobileAndMultimediaSystems
//
//  Created by Kamil Szalek on 24/04/2017.
//  Copyright © 2017 Kamil Szalek. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class IconCollectionViewController: UICollectionViewController {
    
    private var iconSet: [Icon] =
    [
    Icon(name: "cat", price: 2.99, isFeatured: false),
    Icon(name: "dribbble", price: 1.99, isFeatured: false),
    Icon(name: "ghost", price: 4.99, isFeatured: false),
    Icon(name: "hat", price: 2.99, isFeatured: false),
    Icon(name: "owl", price: 5.99, isFeatured: false),
    Icon(name: "pot", price: 1.99, isFeatured: false),
    Icon(name: "pumkin", price: 0.99, isFeatured: true),
    Icon(name: "rip", price: 7.99, isFeatured: true),
    Icon(name: "skull", price: 8.99, isFeatured: true),
    Icon(name: "sky", price: 0.99, isFeatured: true),
    Icon(name: "toxic", price: 2.99, isFeatured: false),
    Icon(name: "ic_book", price: 2.99, isFeatured: false),
    Icon(name: "ic_backpack", price: 3.99, isFeatured: false),
    Icon(name: "ic_camera", price: 4.99, isFeatured: false),
    Icon(name: "ic_coffee", price: 3.99, isFeatured: false),
    Icon(name: "ic_glasses", price: 3.99, isFeatured: false),
    Icon(name: "ic_ice_cream", price: 4.99, isFeatured: false),
    Icon(name: "ic_smoking_pipe", price: 6.99, isFeatured: false),
    Icon(name: "ic_vespa", price: 9.99, isFeatured: true)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // return numbers of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // return the numbers of items
        return iconSet.count;
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! IconCollectionViewCell
    
        // Configure the cell
        let icon = iconSet[indexPath.row]
        cell.iconImageView.image = UIImage(named: icon.name)
        cell.iconPriceLabel.text = "$\(icon.price)"
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        

        
        if segue.identifier == "showIconDetail" {
            if let indexPaths = collectionView?.indexPathsForSelectedItems {
                let destinationController = segue.destination as!
                IconDetailViewController
                
                destinationController.icon = iconSet[indexPaths[0].row]
                collectionView?.deselectItem(at: indexPaths[0], animated: false)
                
                // Bar customization
                let backItem = UIBarButtonItem()
                backItem.title = "Wróć"
                destinationController.title = "Grid"
            }
        }
    }
}
