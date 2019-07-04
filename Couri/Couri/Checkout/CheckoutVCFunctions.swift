//
//  CheckoutVCFunctions.swift
//  Couri
//
//  Created by David Chen on 7/1/19.
//  Copyright © 2019 Couri. All rights reserved.
//

import Foundation
import UIKit
import MapKit

extension CheckoutViewController {
    
    func handlePricing() {
        for itemOrder in itemOrderArray ?? [] {
            subtotal += itemOrder.price
            quantity += Int(itemOrder.quantity)
        }
    }
    
    func calculateETA() {
        let userAddress = defaults.object(forKey: "address") as! String
        //let itemOrder = itemOrderArray?[0]
        //let restaurantAddress = itemOrder?.restaurant
        
        getLocation(from: userAddress) { location in
            print("User Location is:", location!)
        }
//
//        getLocation(from: restaurantAddress!) { location in
//            print("Restaurant Location is:", location!)
//        }
    }
    
    func getLocation(from address: String, completion: @escaping (_ location: CLLocationCoordinate2D?) -> Void) {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(address) { (placemarks, error) in
            guard let placemarks = placemarks,
                let location = placemarks.first?.location?.coordinate else {
                    return
            }
            completion(location)
        }
    }
    
    func handlePriceEdits() {
        subtotal = 0.0
        quantity = 0
        for itemOrder in itemOrderArray ?? [] {
            subtotal += itemOrder.price
            quantity += Int(itemOrder.quantity)
        }
        calculateOrder(price: subtotal, quantity: quantity, time: time)
    }
    
    @objc func showCheckout() {
        checkoutView.show()
    }
    
    func addShadowToView(view: UIView, opacity: Double, radius: Int) {
        view.layer.shadowRadius = CGFloat(radius)
        view.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        view.layer.shadowOffset = CGSize(width: 0, height: 0)
        view.layer.shadowOpacity = Float(CGFloat(opacity))
    }
    
    @objc func backwards() {
        performSegue(withIdentifier: "unwindToRestaurant", sender: self)
    }
    
    @objc func segueToCourier() {
        performSegue(withIdentifier: "toCourierSelection", sender: self)
    }
    
    func setupViews() {
        let guide = view.safeAreaLayoutGuide
        
        view.addSubview(backwardsButton)
        view.addSubview(cardView)
        view.addSubview(contentView)
        view.addSubview(clearAllDataButton)
        
        cardView.addSubview(deliveringToLabel)
        cardView.addSubview(addressLabel)
        
        contentView.addSubview(checkoutTableView)
        contentView.addSubview(subtotalView)
        contentView.addSubview(checkoutLabel)
        contentView.addSubview(checkoutStrip)
        contentView.addSubview(checkoutButton)
        
        checkoutButton.addSubview(checkoutButtonLabel)
        checkoutButton.addSubview(checkoutPriceLabel)
        
        subtotalView.addSubview(subtotalLabel)
        subtotalView.addSubview(subtotalPriceLabel)
        subtotalView.addSubview(taxLabel)
        subtotalView.addSubview(taxPriceLabel)
        subtotalView.addSubview(deliveryLabel)
        subtotalView.addSubview(deliveryPriceLabel)
        
        checkoutTableView.delegate = self
        checkoutTableView.dataSource = self
        checkoutTableView.register(OrderCell.self, forCellReuseIdentifier: cellID)
        checkoutTableView.separatorStyle = .none
        
        checkoutButtonLabel.text = "Checkout"
        addressLabel.text = defaults.object(forKey: "address") as? String ?? ""
        addressLabel.numberOfLines = 0
        
        backwardsButton.addTarget(self, action: #selector(backwards), for: .touchUpInside)
        clearAllDataButton.addTarget(self, action: #selector(purgeAllData), for: .touchUpInside)
        checkoutButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(segueToCourier)))
        
        addShadowToView(view: backwardsButton, opacity: 0.2, radius: 10)
        addShadowToView(view: contentView, opacity: 0.1, radius: 10)
        addShadowToView(view: cardView, opacity: 0.1, radius: 10)
        
        NSLayoutConstraint.useAndActivateConstraints(constraints: [
            backwardsButton.topAnchor.constraint(equalTo: guide.topAnchor, constant: 10),
            backwardsButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
            
            clearAllDataButton.bottomAnchor.constraint(equalTo: checkoutLabel.bottomAnchor),
            clearAllDataButton.trailingAnchor.constraint(equalTo: subtotalPriceLabel.trailingAnchor),
            
            cardView.topAnchor.constraint(equalTo: backwardsButton.bottomAnchor, constant: 10),
            cardView.heightAnchor.constraint(equalToConstant: 150),
            cardView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
            cardView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10),
            
            deliveringToLabel.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 30),
            deliveringToLabel.leftAnchor.constraint(equalTo: cardView.leftAnchor, constant: 20),
            
            addressLabel.topAnchor.constraint(equalTo: deliveringToLabel.bottomAnchor, constant: 10),
            addressLabel.leadingAnchor.constraint(equalTo: deliveringToLabel.leadingAnchor),
            addressLabel.widthAnchor.constraint(equalToConstant: 130),
            
            contentView.topAnchor.constraint(equalTo: cardView.bottomAnchor, constant: 30),
            contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            contentView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
            contentView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10),
            
            checkoutLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            checkoutLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20),
            
            checkoutStrip.topAnchor.constraint(equalTo: checkoutLabel.bottomAnchor, constant: -3),
            checkoutStrip.heightAnchor.constraint(equalToConstant: 3),
            checkoutStrip.leadingAnchor.constraint(equalTo: checkoutLabel.leadingAnchor),
            checkoutStrip.widthAnchor.constraint(equalToConstant: 100),
            
            checkoutTableView.topAnchor.constraint(equalTo: checkoutLabel.bottomAnchor, constant: 10),
            checkoutTableView.bottomAnchor.constraint(equalTo: subtotalView.topAnchor, constant: -10),
            checkoutTableView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10),
            checkoutTableView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10),
            
            subtotalView.heightAnchor.constraint(equalToConstant: 120),
            subtotalView.leadingAnchor.constraint(equalTo: checkoutTableView.leadingAnchor, constant: 70),
            subtotalView.trailingAnchor.constraint(equalTo: checkoutTableView.trailingAnchor),
            subtotalView.bottomAnchor.constraint(equalTo: checkoutButton.topAnchor),
            
            subtotalLabel.topAnchor.constraint(equalTo: subtotalView.topAnchor, constant: 10),
            subtotalLabel.leadingAnchor.constraint(equalTo: checkoutButtonLabel.leadingAnchor),
            
            subtotalPriceLabel.topAnchor.constraint(equalTo: subtotalLabel.topAnchor),
            subtotalPriceLabel.rightAnchor.constraint(equalTo: subtotalView.rightAnchor, constant: -10),
            
            taxLabel.topAnchor.constraint(equalTo: subtotalLabel.bottomAnchor, constant: 5),
            taxLabel.leadingAnchor.constraint(equalTo: subtotalLabel.leadingAnchor),
            
            taxPriceLabel.topAnchor.constraint(equalTo: taxLabel.topAnchor),
            taxPriceLabel.trailingAnchor.constraint(equalTo: subtotalPriceLabel.trailingAnchor),
            
            deliveryLabel.topAnchor.constraint(equalTo: taxLabel.bottomAnchor, constant: 5),
            deliveryLabel.leadingAnchor.constraint(equalTo: subtotalLabel.leadingAnchor),
            
            deliveryPriceLabel.topAnchor.constraint(equalTo: deliveryLabel.topAnchor),
            deliveryPriceLabel.trailingAnchor.constraint(equalTo: subtotalPriceLabel.trailingAnchor),
            
            checkoutButton.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10),
            checkoutButton.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10),
            checkoutButton.heightAnchor.constraint(equalToConstant: 40),
            checkoutButton.bottomAnchor.constraint(equalTo: guide.bottomAnchor, constant: -10),
            
            checkoutButtonLabel.centerXAnchor.constraint(equalTo: checkoutButton.centerXAnchor),
            checkoutButtonLabel.centerYAnchor.constraint(equalTo: checkoutButton.centerYAnchor),
            
            checkoutPriceLabel.rightAnchor.constraint(equalTo: checkoutButton.rightAnchor, constant: -10),
            checkoutPriceLabel.centerYAnchor.constraint(equalTo: checkoutButton.centerYAnchor),
            ])
    }
}
