//
//  Restaurants.swift
//  Couri Tests
//
//  Created by David Chen on 6/7/19.
//  Copyright © 2019 David Chen. All rights reserved.
//

import Foundation
import UIKit

//Our RestaurantView class that gets its information from our RestaurantView.xib

class Restaurant {
    var courierCount = 0
    var restaurantName: String
    var categoryDescription: String
    var description: String
    var imageName: UIImage
    var categories: [String]
    var menuItems: [MenuItem] = []
    
    init(restaurantName: String, categoryDescription: String, description: String, imageName: UIImage, categories: [String]) {
        self.restaurantName = restaurantName
        self.categoryDescription = categoryDescription
        self.description = description
        self.imageName = imageName
        self.categories = categories
    }
}

// Very simple struct for the array of Restaurant instances
struct RestaurantLibrary {
    let menuLibrary = MenuLibrary()
    var restaurants: [Restaurant] = []
    
    init() {
        generateRestaurantLibrary()
    }
}

// Extension of RestaurantLibrary struct that contains all of the relevant information.
extension RestaurantLibrary {
    mutating func generateRestaurantLibrary() {
        let rareTeaBancroft = Restaurant(restaurantName: "RareTea on Bancroft", categoryDescription: "Milk Tea, Smoothies, Snacks", description: "Authentic boba tea shop. Offers a variety of organic milk tea, fresh fruit tea and smoothies.", imageName: #imageLiteral(resourceName: "rareteaBancroft"), categories: ["Popular", "Milk Tea", "Tea"])
        let cupcakinBakeShop = Restaurant(restaurantName: "Cupcakin' Bake Shop", categoryDescription: "Cupcakes, Pastries", description: "Cupcakes in a range of creative flavors, toppings and sizes offered in a quaint, colorful bakeshop.", imageName: #imageLiteral(resourceName: "cupcakin"), categories: ["Popular"])
        let sliverPizzeria = Restaurant(restaurantName: "Sliver Pizzeria", categoryDescription: "Pizza, Salad", description: "Socially conscious pie parlor showcases specialty pizzas, a full bar, and live bands in a funky space.", imageName: #imageLiteral(resourceName: "sliver"), categories: ["Popular"])
        let gypsys = Restaurant(restaurantName: "Gypsy's", categoryDescription: "Italian, Pastas, Salads", description: "Fast food outfit with late hours provides Italian comfort dishes to student-heavy clientele", imageName: #imageLiteral(resourceName: "gypsys"), categories: ["Popular"])
        let tapiocaExpress = Restaurant(restaurantName: "Tapioca Express", categoryDescription: "Coffee & Tea, Juice Bars & Smoothies, Bubble Tea, Boba", description: "Tapioca Express harvests the finest ingredients from Taiwan and provides quality teas, boba, and snacks to our customers.", imageName: #imageLiteral(resourceName: "tapioca express"), categories: ["Popular", "Milk Tea", "Snacks", "Tea", "Snow Bubble"])
        let gongCha = Restaurant(restaurantName: "Gong Cha", categoryDescription: "Milk Tea, Fruit Teas, Smoothie blends", description: "At Gong Cha USA, we believe in serving quality bubble tea and boba tea. Our teas can be blended with a variety of fruits, toppings and creative mixes.", imageName: UIImage(named: "Gongcha Cover")!, categories: ["Popular", "Milk Tea", "Tea"])
        
        tapiocaExpress.menuItems = menuLibrary.tapiocaExpressMenu
        rareTeaBancroft.menuItems = menuLibrary.rareTeaMenu
        sliverPizzeria.menuItems = menuLibrary.sliverMenu
        gongCha.menuItems = menuLibrary.gongchaMenu
        
        restaurants = [tapiocaExpress, gongCha, rareTeaBancroft, cupcakinBakeShop, sliverPizzeria, gypsys]
    }
}
