//
//  MenuItem.swift
//  Couri
//
//  Created by David Chen on 6/18/19.
//  Copyright © 2019 Couri. All rights reserved.
//

import Foundation

class MenuItem {
    var itemName: String
    var itemPrice: Double
    var itemImage: String?
    var itemCategory: String
    
    init(itemName: String, itemPrice: Double, itemImage: String?, itemCategory: String) {
        self.itemName = itemName
        self.itemPrice = itemPrice
        self.itemImage = itemImage
        self.itemCategory = itemCategory
    }
}

