//
//  MenuCategoryModels.swift
//  Couri
//
//  Created by David Chen on 6/18/19.
//  Copyright © 2019 Couri. All rights reserved.
//

import UIKit

class RestaurantForCategory: NSObject {
    var rareTeaCategories = [Category]()
    
    var milkTea: Category = {
        let mt = Category()
        mt.categoryName = "Milk Tea"
        mt.iconName = "boba icon"
        return mt
    }()
    
    var hotMilkTea: Category = {
        let hmt = Category()
        hmt.categoryName = "Hot Milk Tea"
        hmt.iconName = "hot boba icon"
        return hmt
    }()
    
    func append() {
        rareTeaCategories.append(milkTea)
        rareTeaCategories.append(hotMilkTea)
    }
    
}

class Category: NSObject {
    var categoryName = String()
    var iconName: String?
    var id: String?
}

