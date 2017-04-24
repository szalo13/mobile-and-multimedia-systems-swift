//
//  IconDetailViewController.swift
//  MobileAndMultimediaSystems
//
//  Created by Kamil Szalek on 24/04/2017.
//  Copyright © 2017 Kamil Szalek. All rights reserved.
//

import UIKit

class IconDetailViewController: UIViewController {

    @IBOutlet var iconImageView: UIImageView! {
        didSet {
            iconImageView.image = UIImage( named: icon?.name ?? "" )
        }
    }
    
    var icon: Icon?
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
