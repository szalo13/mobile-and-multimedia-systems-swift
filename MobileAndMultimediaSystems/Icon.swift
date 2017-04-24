//
//  Icon.swift
//  MobileAndMultimediaSystems
//
//  Created by Kamil Szalek on 24/04/2017.
//  Copyright © 2017 Kamil Szalek. All rights reserved.
//

import Foundation

struct Icon {
    var name: String = ""
    var price: Double = 0.0
    var isFeatured: Bool = false
    
    init(name: String, price: Double, isFeatured: Bool){
        self.name = name;
        self.price = price;
        self.isFeatured = isFeatured;
    }
}
