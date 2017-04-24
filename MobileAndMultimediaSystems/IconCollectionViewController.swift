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
    Icon(name: "sky", price: 0.99, isFeatured: true)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false


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
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

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
}
