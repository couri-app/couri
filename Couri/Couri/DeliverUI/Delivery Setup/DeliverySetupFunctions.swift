//
//  DeliverySetupFunctions.swift
//  Couri
//
//  Created by David Chen on 7/5/19.
//  Copyright © 2019 Couri. All rights reserved.
//

import Foundation
import UIKit

extension DeliverSetupViewController {
    @objc func addMinutes() {
        if minutesCount >= 60 {
            minutesCount += 15
        } else {
            minutesCount += 5
        }
        minuteCountLabel.text = String(minutesCount)
    }
    
    @objc func subtractMinutes() {
        if minutesCount > 10, minutesCount <= 60 {
            minutesCount -= 5
        } else if minutesCount > 60 {
            minutesCount -= 15
        } else if minutesCount == 10 {
            minutesCount = 5
        }
        minuteCountLabel.text = String(minutesCount)
    }
    
    @objc func addDeliveries() {
        if deliveriesCount == 3 {
            deliveriesCount = 3
        } else {
            deliveriesCount += 1
        }
        deliveryCountLabel.text = String(deliveriesCount)
    }
    
    @objc func subtractDeliveries() {
        if deliveriesCount > 2 {
            deliveriesCount -= 1
        } else {
            deliveriesCount = 1
        }
        deliveryCountLabel.text = String(deliveriesCount)
    }
    
    func setupViews() {
        let guide = view.safeAreaLayoutGuide
        
        view.backgroundColor = UIColor(named: "darkMode")
        view.addSubview(hamburgerButton)
        view.addSubview(selectedRestaurantsView)
        view.addSubview(backwardsButton)
        view.addSubview(contentView)
        
        let subviewArray = [nextButton, durationLabel, durationLabel, durationDescriptionLabel, deliveryLabel, deliveryDescriptionLabel, durationMinusButton, durationPlusButton, minuteCountLabel, minutesLabel, deliveryPlusButton, deliveryMinusButton, deliveryCountLabel, deliveriesLabel]
        for subview in subviewArray {
            contentView.addSubview(subview)
        }
        
        var height = 140
        
        if restaurants?.count == 1 {
            height = 70
        }
        
        durationPlusButton.addTarget(self, action: #selector(addMinutes), for: .touchUpInside)
        durationMinusButton.addTarget(self, action: #selector(subtractMinutes), for: .touchUpInside)
        deliveryPlusButton.addTarget(self, action: #selector(addDeliveries), for: .touchUpInside)
        deliveryMinusButton.addTarget(self, action: #selector(subtractDeliveries), for: .touchUpInside)
        
        minuteCountLabel.text = String(minutesCount)
        deliveryCountLabel.text = String(deliveriesCount)
        
        backwardsButton.addTarget(self, action: #selector(backTapped), for: .touchUpInside)
        nextButton.addTarget(self, action: #selector(forwardTapped), for: .touchUpInside)
        
        NSLayoutConstraint.useAndActivateConstraints(constraints: [
            hamburgerButton.topAnchor.constraint(equalTo: guide.topAnchor, constant: 10),
            hamburgerButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            
            selectedRestaurantsView.topAnchor.constraint(equalTo: hamburgerButton.bottomAnchor, constant: 20),
            selectedRestaurantsView.heightAnchor.constraint(equalToConstant: CGFloat(height)),
            selectedRestaurantsView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
            selectedRestaurantsView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10),
            
            backwardsButton.topAnchor.constraint(equalTo: selectedRestaurantsView.bottomAnchor, constant: 10),
            backwardsButton.leftAnchor.constraint(equalTo: guide.leftAnchor, constant: 10),
            backwardsButton.widthAnchor.constraint(equalToConstant: 60),
            backwardsButton.heightAnchor.constraint(equalToConstant: 30),
            
            contentView.topAnchor.constraint(equalTo: backwardsButton.bottomAnchor, constant: 10),
            contentView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
            contentView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10),
            contentView.bottomAnchor.constraint(equalTo: guide.bottomAnchor),
            
            durationLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            durationLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            
            durationDescriptionLabel.topAnchor.constraint(equalTo: durationLabel.bottomAnchor),
            durationDescriptionLabel.leadingAnchor.constraint(equalTo: durationLabel.leadingAnchor),
            durationDescriptionLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10),
            
            durationMinusButton.heightAnchor.constraint(equalToConstant: 40),
            durationMinusButton.widthAnchor.constraint(equalToConstant: 40),
            durationMinusButton.topAnchor.constraint(equalTo: durationDescriptionLabel.bottomAnchor, constant: 20),
            durationMinusButton.leadingAnchor.constraint(equalTo: durationLabel.leadingAnchor),
            
            minuteCountLabel.leftAnchor.constraint(equalTo: durationMinusButton.rightAnchor, constant: 20),
            minuteCountLabel.centerYAnchor.constraint(equalTo: durationMinusButton.centerYAnchor),
            
            minutesLabel.leftAnchor.constraint(equalTo: minuteCountLabel.rightAnchor, constant: 5),
            minutesLabel.bottomAnchor.constraint(equalTo: minuteCountLabel.bottomAnchor, constant: -4),
            
            durationPlusButton.heightAnchor.constraint(equalToConstant: 40),
            durationPlusButton.widthAnchor.constraint(equalToConstant: 40),
            durationPlusButton.centerYAnchor.constraint(equalTo: durationMinusButton.centerYAnchor),
            durationPlusButton.leadingAnchor.constraint(equalTo: durationLabel.leadingAnchor, constant: 200),
            
            deliveryLabel.topAnchor.constraint(equalTo: durationMinusButton.bottomAnchor, constant: 20),
            deliveryLabel.leadingAnchor.constraint(equalTo: durationLabel.leadingAnchor),
            
            deliveryDescriptionLabel.topAnchor.constraint(equalTo: deliveryLabel.bottomAnchor),
            deliveryDescriptionLabel.leadingAnchor.constraint(equalTo: durationLabel.leadingAnchor),
            deliveryDescriptionLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10),
            
            deliveryMinusButton.heightAnchor.constraint(equalToConstant: 40),
            deliveryMinusButton.widthAnchor.constraint(equalToConstant: 40),
            deliveryMinusButton.topAnchor.constraint(equalTo: deliveryDescriptionLabel.bottomAnchor, constant: 20),
            deliveryMinusButton.leadingAnchor.constraint(equalTo: durationLabel.leadingAnchor),
            
            deliveryCountLabel.leftAnchor.constraint(equalTo: minuteCountLabel.leftAnchor),
            deliveryCountLabel.centerYAnchor.constraint(equalTo: deliveryMinusButton.centerYAnchor),
            
            deliveriesLabel.leftAnchor.constraint(equalTo: deliveryCountLabel.rightAnchor, constant: 5),
            deliveriesLabel.bottomAnchor.constraint(equalTo: deliveryCountLabel.bottomAnchor, constant: -4),
            
            deliveryPlusButton.heightAnchor.constraint(equalToConstant: 40),
            deliveryPlusButton.widthAnchor.constraint(equalToConstant: 40),
            deliveryPlusButton.centerYAnchor.constraint(equalTo: deliveryMinusButton.centerYAnchor),
            deliveryPlusButton.leadingAnchor.constraint(equalTo: durationPlusButton.leadingAnchor),
            
            nextButton.heightAnchor.constraint(equalToConstant: 80),
            nextButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            nextButton.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            nextButton.rightAnchor.constraint(equalTo: contentView.rightAnchor)
            ])
    }
}
