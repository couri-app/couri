//
//  OrderCell.swift
//  Couri
//
//  Created by David Chen on 6/29/19.
//  Copyright © 2019 Couri. All rights reserved.
//

import Foundation
import UIKit

class OrderCell: UITableViewCell {
    var itemOrder: ItemOrder! {
        didSet {
            nameLabel.text = itemOrder.name
            quantityLabel.text = String(itemOrder.quantity)
            priceLabel.text = "$\(String(format: "%.2f", (itemOrder.price)))"
            customizeLabel.text = itemOrder.customizables
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AvenirNext-Medium", size: 16)
        return label
    }()
    
    let customizeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AvenirNext-Medium", size: 12)
        return label
    }()
    
    let quantityLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AvenirNext-Medium", size: 16)
        return label
    }()
    
    let priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AvenirNext-Medium", size: 16)
        return label
    }()
    
    func setupViews() {
        addSubview(nameLabel)
        addSubview(customizeLabel)
        addSubview(quantityLabel)
        addSubview(priceLabel)
        
        NSLayoutConstraint.useAndActivateConstraints(constraints: [
            quantityLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 10),
            quantityLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            
            nameLabel.leftAnchor.constraint(equalTo: quantityLabel.leftAnchor, constant: 25),
            nameLabel.topAnchor.constraint(equalTo: quantityLabel.topAnchor),
            
            priceLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -10),
            priceLabel.topAnchor.constraint(equalTo: quantityLabel.topAnchor),
            
            customizeLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            customizeLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor),
            customizeLabel.trailingAnchor.constraint(equalTo: priceLabel.trailingAnchor)
            ])
    }
}
