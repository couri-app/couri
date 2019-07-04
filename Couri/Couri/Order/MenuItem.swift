//
//  MenuItem.swift
//  Couri
//
//  Created by David Chen on 6/18/19.
//  Copyright © 2019 Couri. All rights reserved.
//

import Foundation
import UIKit

class MenuItem {
    var itemName = String()
    var itemPrice = Double()
    var itemImage: UIImage? = nil
    var itemCategory = String()
    var quantity = 0
    var itemDescription: String? = nil
    var customizables: [MasterCustomize] = []
}

struct MenuLibrary {
    let teLib = TemporaryMasterCustomizableLibrary()
    
    var tapiocaExpressPopular: [MenuItem] = []
    var tapiocaExpressMilkTea: [MenuItem] = []
    var tapiocaExpressSnacks: [MenuItem] = []
    var tapiocaExpressTea: [MenuItem] = []
    var tapiocaExpressSnowbubble: [MenuItem] = []
    var rareTeaMenu: [MenuItem] = []
    var sliverPopular: [MenuItem] = []
    var gongchaMenu: [MenuItem] = []
    
    var tapiocaCategories: [String: [MenuItem]] = [:]
    var gongchaCategories: [String: [MenuItem]] = [:]
    var rareTeaCategories: [String: [MenuItem]] = [:]
    var sliverCategories: [String: [MenuItem]] = [:]
    
    init() {
        generateLibrary()
    }
    
    mutating func generateLibrary() {
        let item1 = MenuItem()
        item1.itemName = "T.E. Crispy Chicken"
        item1.itemPrice = 5.35
        item1.itemImage = UIImage(named: "crispy chicken")
        item1.customizables = [teLib.spicy]
        
        let item2 = MenuItem()
        item2.itemName = "T.E. Crispy Chicken"
        item2.itemPrice = 8.25
        item2.itemImage = UIImage(named: "crispy chicken salad")
        item2.itemDescription = "Served with side salad. No combo drink substitutions."
        item2.customizables = [teLib.drink, teLib.sweet, teLib.spicy]
        
        let item3 = MenuItem()
        item3.itemName = "Thai Tea"
        item3.itemPrice = 3.50
        item3.itemImage = UIImage(named: "thai tea")
        item3.customizables = [teLib.addOn, teLib.temp, teLib.ice, teLib.sweet, teLib.sub, teLib.boba, teLib.jelly]
        
        let item4 = MenuItem()
        item4.itemName = "T.E. Fried Potstickers"
        item4.itemPrice = 4.35
        item4.itemImage = UIImage(named: "potstickers")
        item4.itemCategory = "Snacks"
        item4.customizables = [teLib.spicy]
        
        let item5 = MenuItem()
        item5.itemName = "Korean Short Ribs"
        item5.itemPrice = 9.95
        item5.itemDescription = "Served with side salad. No combo drink substitution"
        item5.customizables = [teLib.spicy]
        
        let item6 = MenuItem()
        item6.itemName = "Milk Tea"
        item6.itemPrice = 3.25
        item6.itemImage = UIImage(named: "Milk Tea-1")
        item6.customizables = [teLib.addOn, teLib.temp, teLib.ice, teLib.sweet, teLib.boba, teLib.jelly]
        
        let item7 = MenuItem()
        item7.itemName = "Almond Milk Tea"
        item7.itemPrice = 3.50
        item7.customizables = [teLib.addOn, teLib.temp, teLib.ice, teLib.sweet, teLib.boba, teLib.jelly]
        
        let item8 = MenuItem()
        item8.itemName = "Barley Tea"
        item8.itemPrice = 3.75
        item8.customizables = [teLib.addOn, teLib.temp, teLib.ice, teLib.sweet, teLib.boba, teLib.jelly]
        
        let item9 = MenuItem()
        item9.itemName = "Almond Snow Bubble"
        item9.itemPrice = 3.95
        item9.customizables = [teLib.addOn, teLib.sub, teLib.boba, teLib.jelly]
        
        let rareTea1 = MenuItem()
        rareTea1.itemName = "Thai Milk Tea"
        rareTea1.itemPrice = 4.50
        
        let rareTea2 = MenuItem()
        rareTea2.itemName = "Black Milk Tea"
        rareTea2.itemPrice = 4.50
        
        let rareTea3 = MenuItem()
        rareTea3.itemName = "Oolong Milk Tea"
        rareTea3.itemPrice = 4.50
        
        let rareTea4 = MenuItem()
        rareTea4.itemName = "Taro Milk Tea"
        rareTea4.itemPrice = 4.50
        
        let rareTea5 = MenuItem()
        rareTea5.itemName = "Wintermelon Tea"
        rareTea5.itemPrice = 4.50
        
        let sliver1 = MenuItem()
        sliver1.itemName = "Slice of Pepperoni"
        sliver1.itemPrice = 8.59
        
        let gc1 = MenuItem()
        gc1.itemName = "Mustache"
        gc1.itemCategory = "Mustache"
        gc1.itemImage = UIImage(named: "GC Mustache")
        gc1.itemPrice = 4.50
        
        let gc2 = MenuItem()
        gc2.itemName = "QQ Passion Foam Tea"
        gc2.itemImage = UIImage(named: "GC Creative Mix")
        gc2.itemPrice = 4.50
        
        let gc3 = MenuItem()
        gc3.itemName = "Pearl Milk Tea"
        gc3.itemImage = UIImage(named: "GC Milk Tea")
        gc3.itemPrice = 4.50
        
        let gc4 = MenuItem()
        gc4.itemName = "Earl Grey Fresh Milk tea"
        gc4.itemImage = UIImage(named: "GC Fresh Milk")
        gc4.itemDescription = "This one is so dank that when you drink it, you'll have dreams about it for the rest of your life"
        gc4.itemPrice = 4.50
        
        let gc5 = MenuItem()
        gc5.itemName = "Premium Brewed Tea"
        gc5.itemImage = UIImage(named: "GC Brewed Tea")
        gc5.itemPrice = 4.50
        
        let gc6 = MenuItem()
        gc6.itemName = "Coffee"
        gc6.itemImage = UIImage(named: "GC Coffee")
        gc6.itemPrice = 4.50
        
        let gc7 = MenuItem()
        gc7.itemName = "Matcha Smoothie"
        gc7.itemImage = UIImage(named: "GC Smoothie")
        gc7.itemPrice = 4.50
        
        let gc8 = MenuItem()
        gc8.itemName = "Sparkling Rainbow Lychee"
        gc8.itemImage = UIImage(named: "GC Sparkling")
        gc8.itemPrice = 4.50
        
        let pepperoniPizza = MenuItem()
        pepperoniPizza.itemName = "Pepperoni Pizza"
        pepperoniPizza.itemPrice = 3.50
        pepperoniPizza.itemDescription = "The best pepperoni you'll have ever."
        pepperoniPizza.customizables = [teLib.sliverSauceMaster]
        
        gongchaMenu = [gc1, gc2, gc3, gc4, gc5, gc6, gc7, gc8]
        
        sliverPopular = [sliver1, pepperoniPizza]
        
        tapiocaExpressPopular = [item3, item6, item7, item8, item1, item2, item4, item5]
        tapiocaExpressMilkTea = [item3, item6, item7]
        tapiocaExpressSnacks = [item1, item2, item4, item5]
        tapiocaExpressTea = [item8]
        tapiocaExpressSnowbubble = [item9]
        
        rareTeaMenu = [rareTea1, rareTea2, rareTea3, rareTea4, rareTea5]
        
        gongchaCategories = ["Popular" : gongchaMenu]
        tapiocaCategories = ["Popular" : tapiocaExpressPopular, "Milk Tea" : tapiocaExpressMilkTea, "Snacks" : tapiocaExpressSnacks, "Tea" : tapiocaExpressTea, "Snow Bubble" : tapiocaExpressSnowbubble]
        rareTeaCategories = ["Popular" : rareTeaMenu]
        sliverCategories = ["Popular" : sliverPopular]
    }
}

class MenuItemCell: UITableViewCell {
    
    var item: MenuItem! {
        didSet {
            itemDescription.text = item?.itemDescription
            if item.itemDescription != nil {
                itemDescription.text = item.itemDescription!
            } else {
                itemPrice.topAnchor.constraint(equalTo: itemName.bottomAnchor, constant: 5).isActive = true
            }
            
            // If there is an item image, set it. If there isn't, anchor the name label's left hand side to the left-most side of the cell.
            if item.itemImage != nil {
                itemImage.image = item.itemImage
                
                NSLayoutConstraint.useAndActivateConstraints(constraints: [
                    itemImage.widthAnchor.constraint(equalToConstant: 70),
                    itemImage.heightAnchor.constraint(equalToConstant: 70),
                    itemImage.leftAnchor.constraint(equalTo: self.leftAnchor),
                    itemImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
                    
                    itemName.leftAnchor.constraint(equalTo: itemImage.rightAnchor, constant: 10),
                    itemName.topAnchor.constraint(equalTo: itemImage.topAnchor)
                    ])
            } else {
                NSLayoutConstraint.useAndActivateConstraints(constraints: [
                    itemName.leftAnchor.constraint(equalTo: leftAnchor),
                    itemName.topAnchor.constraint(equalTo: topAnchor, constant: 20)
                    ])
            }
            
            // Since menu items require both names and prices, these don't need if statements to be set.
            itemName.text = item.itemName
            itemPrice.text = "$\(String(format: "%.2f", item.itemPrice))"
            }
        }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let itemImage: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 5
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    let itemName: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = UIFont(name: "AvenirNext-Demibold", size: 20)
        return label
    }()
    
    let itemDescription: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AvenirNext-Medium", size: 14)
        label.numberOfLines = 2
        label.textColor = UIColor.gray
        return label
    }()
    
    let itemPrice: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AvenirNext-Medium", size: 14)
        return label
    }()
        
    func setupViews() {
        addSubview(itemImage)
        addSubview(itemName)
        addSubview(itemDescription)
        addSubview(itemPrice)
        
        NSLayoutConstraint.useAndActivateConstraints(constraints: [
            itemName.leftAnchor.constraint(equalTo: itemImage.rightAnchor, constant: 10),
            itemName.topAnchor.constraint(equalTo: itemImage.topAnchor),
            itemName.rightAnchor.constraint(equalTo: rightAnchor, constant: -10),
            
            itemDescription.topAnchor.constraint(equalTo: itemName.bottomAnchor, constant: 5),
            itemDescription.leadingAnchor.constraint(equalTo: itemName.leadingAnchor),
            itemDescription.rightAnchor.constraint(equalTo: self.rightAnchor),
            
            itemPrice.topAnchor.constraint(equalTo: itemDescription.bottomAnchor, constant: 5),
            itemPrice.leadingAnchor.constraint(equalTo: itemName.leadingAnchor)
            ])
    }
}
