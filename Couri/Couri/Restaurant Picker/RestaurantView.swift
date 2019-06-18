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

class RestaurantView: UIView {
    @IBOutlet var restaurantView: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        Bundle.main.loadNibNamed("RestaurantView", owner: self, options: nil)
        restaurantView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(restaurantView)
        restaurantView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        restaurantView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        restaurantView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        restaurantView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        restaurantView.heightAnchor.constraint(equalToConstant: 319)
        
    }

    // Relevant variables connected to our .xib file
    @IBOutlet weak var restaurantImage: UIImageView!
    @IBOutlet weak var restaurantName: UILabel!
    @IBOutlet weak var restaurantCategories: UILabel!
    @IBOutlet weak var restaurantDescription: UILabel!
    @IBOutlet weak var numberCouriers: UILabel!
    @IBOutlet weak var numberBackground: UIView!
    
    //All of the variables become connected to what is actually in our Restaurant class (.xib file is connected to Restaurant class)
    var restaurant: Restaurant! {
        didSet {
            restaurantImage.image = restaurant.imageName
            restaurantName.text = restaurant.restaurantName
            restaurantCategories.text = restaurant.categories
            restaurantDescription.text = restaurant.description
            numberCouriers.text = String(restaurant.courierCount)
            
            //Aesthetic touch-ups
            restaurantDescription.numberOfLines = 0
            addCornerRadius()
            addShadow()
            addShadowObject(object: numberBackground)
            numberBackground.layer.cornerRadius = numberBackground.frame.width/2
            //highly frustrated at the bottom not working
            //addWhiteGradientLayerInForeground(frame: restaurantImage.frame, colors: [#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)])
        }
    }
}


// Extension entirely made up of aesthetic touch-up methods
extension RestaurantView {
    
    //Puts white gradient on top of image
    func addWhiteGradientLayerInForeground(frame: CGRect, colors:[UIColor]){
        let gradient = CAGradientLayer()
        gradient.frame = frame
        gradient.colors = colors.map{$0.cgColor}
        restaurantImage.layer.addSublayer(gradient)
    }
    
    // Gives shadow to argument: button
    func addShadowButton(button: UIButton) {
        button.layer.shadowRadius = 8
        button.layer.shadowColor = #colorLiteral(red: 0.07881314767, green: 0.07881314767, blue: 0.07881314767, alpha: 1)
        button.layer.shadowOffset = CGSize(width: 0, height: 0)
        button.layer.shadowOpacity = 0.1
        button.layer.shadowRadius = 10
    }
    
    // Gives shadow to argument: UIView
    func addShadowObject(object: UIView) {
        object.layer.shadowRadius = 8
        object.layer.shadowColor = #colorLiteral(red: 0.07881314767, green: 0.07881314767, blue: 0.07881314767, alpha: 1)
        object.layer.shadowOffset = CGSize(width: 0, height: 0)
        object.layer.shadowOpacity = 0.1
        object.layer.shadowRadius = 4
    }
    
    // Gives shadow to instance of the RestaurantView class
    func addShadow() {
        layer.shadowRadius = 6
        layer.shadowColor = #colorLiteral(red: 0.07881314767, green: 0.07881314767, blue: 0.07881314767, alpha: 1)
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowOpacity = 0.1
        layer.shadowRadius = 10
        }
    
    // Hypothetically gives a corner radius to each restaurant view. It doesn't actually work, and I never call it.
    func addCornerRadius() {
        layer.cornerRadius = 25
    }
}

// Restaurant class with the following parameters: number of couriers, name of restaurant, restaurant's categories, restaurant's description, front-page image for restaurant

class Restaurant {
    var courierCount: Int
    var restaurantName: String
    var categories: String
    var description: String
    var imageName: UIImage
    
    init(courierCount: Int, restaurantName: String, categories: String, description: String, imageName: UIImage) {
        self.courierCount = courierCount
        self.restaurantName = restaurantName
        self.categories = categories
        self.description = description
        self.imageName = imageName
    }
}

// Very simple struct for the array of Restaurant instances
struct RestaurantLibrary {
    var restaurants: [Restaurant] = []
    
    init() {
        generateRestaurantLibrary()
    }
}

// Extension of RestaurantLibrary struct that contains all of the relevant information.
extension RestaurantLibrary {
    mutating func generateRestaurantLibrary() {
        let rareTeaBancroft = Restaurant(courierCount: 0, restaurantName: "RareTea on Bancroft", categories: "Milk Tea, Smoothies, Snacks", description: "Authentic boba tea shop. Offers a variety of organic milk tea, fresh fruit tea and smoothies.", imageName: #imageLiteral(resourceName: "rareteaBancroft"))
        let cupcakinBakeShop = Restaurant(courierCount: 0, restaurantName: "Cupcakin' Bake Shop", categories: "Cupcakes, Pastries", description: "Cupcakes in a range of creative flavors, toppings and sizes offered in a quaint, colorful bakeshop.", imageName: #imageLiteral(resourceName: "cupcakin"))
        let sliverPizzeria = Restaurant(courierCount: 0, restaurantName: "Sliver Pizzeria", categories: "Pizza, Salad", description: "Socially conscious pie parlor showcases specialty pizzas, a full bar, and live bands in a funky space.", imageName: #imageLiteral(resourceName: "sliver"))
        let gypsys = Restaurant(courierCount: 0, restaurantName: "Gypsy's", categories: "Italian, Pastas, Salads", description: "Fast food outfit with late hours provides Italian comfort dishes to student-heavy clientele", imageName: #imageLiteral(resourceName: "gypsys"))
        
        restaurants = [rareTeaBancroft, cupcakinBakeShop, sliverPizzeria, gypsys]
    }
}
