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
            courierLabel.text = "\(String(restaurant.courierCount)) Couriers at \(restaurant.restaurantName)"
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
        imageView.layer.cornerRadius = 5
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    let restaurantName: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AvenirNext-Bold", size: 25)
        label.textColor = UIColor.white
        label.layer.shadowColor = UIColor.black.cgColor
        label.layer.shadowOffset = CGSize(width: 0, height: 0)
        label.layer.shadowOpacity = 0.5
        label.layer.shadowRadius = 5
        return label
    }()
    
    let restaurantDescription: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AvenirNext-Regular", size: 16)
        label.numberOfLines = 0
        return label
    }()
    
    let categoryDescription: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AvenirNext-Medium", size: 16)
        label.textColor = UIColor.white
        label.numberOfLines = 0
        return label
    }()
    
    let courierLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AvenirNext-Demibold", size: 16)
        return label
    }()
    
    let gradientView: UIView = {
        let view = UIView()
        return view
    }()
    
    func setupGradientLayer() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.black.withAlphaComponent(0.5).cgColor]
        gradientLayer.locations = [0, 1]
        
        gradientView.layer.addSublayer(gradientLayer)
        
        gradientLayer.frame = CGRect(x: 0, y: 0, width: 500, height: 100)
    }
    
    func setupViews() {
        
        addSubview(restaurantImage)
        addSubview(restaurantName)
        addSubview(restaurantDescription)
        addSubview(categoryDescription)
        addSubview(courierLabel)
        restaurantImage.addSubview(gradientView)
        
        restaurantImage.translatesAutoresizingMaskIntoConstraints = false
        restaurantName.translatesAutoresizingMaskIntoConstraints = false
        restaurantDescription.translatesAutoresizingMaskIntoConstraints = false
        categoryDescription.translatesAutoresizingMaskIntoConstraints = false
        courierLabel.translatesAutoresizingMaskIntoConstraints = false
        gradientView.translatesAutoresizingMaskIntoConstraints = false
        
        addConstraints([
            restaurantImage.leftAnchor.constraint(equalTo: leftAnchor),
            restaurantImage.rightAnchor.constraint(equalTo: rightAnchor),
            restaurantImage.heightAnchor.constraint(equalToConstant: 200),
            restaurantImage.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            
            restaurantName.bottomAnchor.constraint(equalTo: categoryDescription.topAnchor),
            restaurantName.leadingAnchor.constraint(equalTo: restaurantImage.leadingAnchor, constant: 10),
            
            categoryDescription.leadingAnchor.constraint(equalTo: restaurantName.leadingAnchor),
            categoryDescription.bottomAnchor.constraint(equalTo: restaurantImage.bottomAnchor, constant: -10),
            categoryDescription.rightAnchor.constraint(equalTo: rightAnchor),
            
            courierLabel.topAnchor.constraint(equalTo: restaurantImage.bottomAnchor, constant: 10),
            courierLabel.leadingAnchor.constraint(equalTo: restaurantImage.leadingAnchor),
            
            restaurantDescription.topAnchor.constraint(equalTo: courierLabel.bottomAnchor, constant: 5),
            restaurantDescription.leadingAnchor.constraint(equalTo: restaurantImage.leadingAnchor),
            restaurantDescription.rightAnchor.constraint(equalTo: rightAnchor),
            
            gradientView.leftAnchor.constraint(equalTo: leftAnchor),
            gradientView.rightAnchor.constraint(equalTo: rightAnchor),
            gradientView.topAnchor.constraint(equalTo: restaurantName.topAnchor, constant: -5),
            gradientView.bottomAnchor.constraint(equalTo: restaurantImage.bottomAnchor),
            ])
    }
}
