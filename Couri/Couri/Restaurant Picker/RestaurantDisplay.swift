//
//  RestaurantDisplay.swift
//  Couri
//
//  Created by David Chen on 6/23/19.
//  Copyright © 2019 Couri. All rights reserved.
//

import Foundation
import UIKit

class RestaurantDisplay: UITableViewCell {
    var restaurant: Restaurant! {
        didSet {
            restaurantImage.image = restaurant.imageName
            restaurantName.text = restaurant.restaurantName
            categoryDescription.text = restaurant.categoryDescription
            restaurantDescription.text = restaurant.description
            courierCountLabel.text = String(restaurant.courierCount)
            if restaurant.courierCount == 1 {
                courierLabel.text = "Courier"
            } else {
                courierLabel.text = "Couriers"
            }
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupGradientLayer()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let restaurantImage: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 20
        imageView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    let restaurantName: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AvenirNext-Bold", size: 25)
        label.textColor = UIColor.black
        return label
    }()
    
    let restaurantDescription: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AvenirNext-Regular", size: 14)
        label.numberOfLines = 0
        return label
    }()
    
    let categoryDescription: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AvenirNext-Regular", size: 14)
        label.textColor = UIColor.black
        return label
    }()
    
    let courierLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AvenirNext-Bold", size: 14)
        return label
    }()
    
    let courierCountLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AvenirNext-Bold", size: 25)
        return label
    }()
    
    let courierCountView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.frame = CGRect(x: 20, y: 20, width: 50, height: 50)
        view.layer.cornerRadius = view.frame.width / 2
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 3)
        view.layer.shadowOpacity = 0.2
        view.layer.shadowRadius = 5
        return view
    }()
    
    let cardView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.layer.cornerRadius = 20
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 0)
        view.layer.shadowOpacity = 0.1
        view.layer.shadowRadius = 7
        return view
    }()
    
    let gradientView = UIView()
    
    func setupGradientLayer() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.white.cgColor, UIColor.white.withAlphaComponent(0).cgColor]
        gradientLayer.locations = [0, 1]
        
        gradientView.layer.addSublayer(gradientLayer)
        
        gradientLayer.frame = CGRect(x: 0, y: 0, width: 500, height: 100)
    }
    
    func setupViews() {
        addSubview(cardView)
        
        cardView.addSubview(restaurantImage)
        cardView.addSubview(courierCountView)
        courierCountView.addSubview(courierCountLabel)
        cardView.addSubview(courierLabel)
        cardView.addSubview(restaurantName)
        cardView.addSubview(restaurantDescription)
        cardView.addSubview(categoryDescription)
        
        restaurantImage.addSubview(gradientView)
        
        NSLayoutConstraint.useAndActivateConstraints(constraints: [
            cardView.leftAnchor.constraint(equalTo: leftAnchor, constant: 10),
            cardView.rightAnchor.constraint(equalTo: rightAnchor, constant: -10),
            cardView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            cardView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            
            restaurantImage.leadingAnchor.constraint(equalTo: cardView.leadingAnchor),
            restaurantImage.trailingAnchor.constraint(equalTo: cardView.trailingAnchor),
            restaurantImage.bottomAnchor.constraint(equalTo: cardView.bottomAnchor),
            restaurantImage.topAnchor.constraint(equalTo: cardView.centerYAnchor, constant: -30),
            
            restaurantName.topAnchor.constraint(equalTo: courierCountView.topAnchor),
            restaurantName.leadingAnchor.constraint(equalTo: courierCountView.trailingAnchor, constant: 20),
            
            categoryDescription.topAnchor.constraint(equalTo: restaurantName.bottomAnchor),
            categoryDescription.leadingAnchor.constraint(equalTo: restaurantName.leadingAnchor),
            categoryDescription.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -20),
            
            courierCountLabel.centerXAnchor.constraint(equalTo: courierCountView.centerXAnchor),
            courierCountLabel.centerYAnchor.constraint(equalTo: courierCountView.centerYAnchor, constant: 2),
            
            courierLabel.centerXAnchor.constraint(equalTo: courierCountView.centerXAnchor),
            courierLabel.topAnchor.constraint(equalTo: courierCountView.bottomAnchor, constant: 10),
            
            restaurantDescription.topAnchor.constraint(equalTo: courierLabel.topAnchor),
            restaurantDescription.leadingAnchor.constraint(equalTo: categoryDescription.leadingAnchor),
            restaurantDescription.rightAnchor.constraint(equalTo: cardView.rightAnchor, constant: -20)
            ])
    }
}
