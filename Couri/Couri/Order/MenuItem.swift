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
    var itemImage: String? = nil
    var itemCategory = String()
    var quantity = 0
    var itemDescription: String? = nil
}

struct MenuLibrary {
    var tapiocaExpressMenu: [MenuItem] = []
    init() {
        generateLibrary()
    }
    
    mutating func generateLibrary() {
        let item1 = MenuItem()
        item1.itemName = "T.E. Crispy Chicken"
        item1.itemPrice = 5.35
        item1.itemImage = "crispy chicken"
        item1.itemCategory = "Snacks"
        
        let item2 = MenuItem()
        item2.itemName = "T.E. Crispy Chicken"
        item2.itemPrice = 8.25
        item2.itemImage = "crispy chicken salad"
        item2.itemCategory = "Snacks"
        item2.itemDescription = "Served with side salad. No combo drink substitutions."
        
        let item3 = MenuItem()
        item3.itemName = "Thai Tea"
        item3.itemPrice = 3.50
        item3.itemImage = "thai tea"
        item3.itemCategory = "Milk Tea"
        
        let item4 = MenuItem()
        item4.itemName = "T.E. Fried Potstickers"
        item4.itemPrice = 4.35
        item4.itemImage = "potstickers"
        item4.itemCategory = "Snacks"
        
        let item5 = MenuItem()
        item5.itemName = "Korean Short Ribs"
        item5.itemPrice = 9.95
        item5.itemCategory = "Snacks"
        item5.itemDescription = "Served with side salad. No combo drink substitution"

        tapiocaExpressMenu = [item1, item2, item3, item4, item5]
    }
}

class MenuItemCell: UITableViewCell {
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
        label.font = UIFont(name: "AvenirNext-Demibold", size: 20)
        return label
    }()
    
    let itemDescription: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AvenirNext-Medium", size: 14)
        label.numberOfLines = 0
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
        
        itemImage.translatesAutoresizingMaskIntoConstraints = false
        itemName.translatesAutoresizingMaskIntoConstraints = false
        itemDescription.translatesAutoresizingMaskIntoConstraints = false
        itemPrice.translatesAutoresizingMaskIntoConstraints = false

        addConstraints([
            itemImage.widthAnchor.constraint(equalToConstant: 70),
            itemImage.heightAnchor.constraint(equalToConstant: 70),
            itemImage.leftAnchor.constraint(equalTo: self.leftAnchor),
            itemImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            
            itemName.leftAnchor.constraint(equalTo: itemImage.rightAnchor, constant: 10),
            itemName.topAnchor.constraint(equalTo: itemImage.topAnchor),
            
            itemDescription.topAnchor.constraint(equalTo: itemName.bottomAnchor, constant: 5),
            itemDescription.leadingAnchor.constraint(equalTo: itemName.leadingAnchor),
            itemDescription.rightAnchor.constraint(equalTo: self.rightAnchor),
            
            itemPrice.topAnchor.constraint(equalTo: itemDescription.bottomAnchor, constant: 5),
            itemPrice.leadingAnchor.constraint(equalTo: itemName.leadingAnchor)
            ])
    }
}
