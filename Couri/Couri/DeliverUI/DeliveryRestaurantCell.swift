//
//  DeliveryRestaurantCell.swift
//  Couri
//
//  Created by David Chen on 6/29/19.
//  Copyright © 2019 Couri. All rights reserved.
//

import Foundation
import UIKit

class DeliveryRestaurantCell: UICollectionViewCell {
    
    var restaurant: Restaurant? {
        didSet {
            nameLabel.text = restaurant?.restaurantName
            addressLabel.text = restaurant?.address
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                backgroundColor = UIColor(named: "honeyYellow")
                selectedView.image = #imageLiteral(resourceName: "selectedDarkCircle")
                nameLabel.textColor = UIColor(named: "darkMode")
                addressLabel.textColor = UIColor(named: "darkMode")
            } else {
                backgroundColor = UIColor(named: "darkMode")
                selectedView.image = #imageLiteral(resourceName: "emptyCircle")
                nameLabel.textColor = UIColor.white
                addressLabel.textColor = UIColor.white
            }
        }
    }
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AvenirNext-Bold", size: 20)
        label.textColor = UIColor.white
        return label
    }()
    
    let addressLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AvenirNext-Regular", size: 12)
        label.textColor = UIColor.white
        return label
    }()
    
    let selectedView: UIImageView = {
        let view = UIImageView()
        view.image = #imageLiteral(resourceName: "emptyCircle")
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    func setupViews() {
        layer.borderColor = UIColor(named: "honeyYellow")?.cgColor
        layer.borderWidth = 1
        layer.cornerRadius = 5
        
        addSubview(nameLabel)
        addSubview(addressLabel)
        addSubview(selectedView)
        
        NSLayoutConstraint.useAndActivateConstraints(constraints: [
            nameLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 10),
            nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            
            addressLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            addressLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            
            selectedView.rightAnchor.constraint(equalTo: rightAnchor, constant: -10),
            selectedView.heightAnchor.constraint(equalToConstant: 35),
            selectedView.widthAnchor.constraint(equalToConstant: 35),
            selectedView.centerYAnchor.constraint(equalTo: centerYAnchor)
            ])
    }
}
