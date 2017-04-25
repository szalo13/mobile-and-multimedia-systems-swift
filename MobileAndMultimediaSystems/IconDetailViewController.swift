//
//  IconDetailViewController.swift
//  MobileAndMultimediaSystems
//
//  Created by Kamil Szalek on 24/04/2017.
//  Copyright © 2017 Kamil Szalek. All rights reserved.
//

import UIKit

class IconDetailViewController: UIViewController {
    
    var icon: Icon?
    
    @IBOutlet var iconImageView: UIImageView! {
        didSet {
            iconImageView.image = UIImage( named: icon?.name ?? "" )
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
