//
//  CheckoutVCFunctions.swift
//  Couri
//
//  Created by David Chen on 7/1/19.
//  Copyright © 2019 Couri. All rights reserved.
//

import Foundation
import UIKit

extension CheckoutViewController {
    
    func handlePricing() {
        for itemOrder in itemOrderArray ?? [] {
            subtotal += itemOrder.price
            quantity += Int(itemOrder.quantity)
        }
    }
    
    func addShadowToView(view: UIView, opacity: Double, radius: Int) {
        view.layer.shadowRadius = CGFloat(radius)
        view.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        view.layer.shadowOffset = CGSize(width: 0, height: 0)
        view.layer.shadowOpacity = Float(CGFloat(opacity))
    }
    
    @objc func backwards() {
        performSegue(withIdentifier: "unwindToRestaurant", sender: self)
        //self.dismiss(animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    
    func setupViews() {
        let guide = view.safeAreaLayoutGuide
        
        view.addSubview(contentView)
        view.addSubview(backwardsButton)
        view.addSubview(clearAllDataButton)
        
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
        
        checkoutButtonLabel.text = "Checkout"
        
        backwardsButton.addTarget(self, action: #selector(backwards), for: .touchUpInside)
        clearAllDataButton.addTarget(self, action: #selector(purgeAllData), for: .touchUpInside)
        
        addShadowToView(view: backwardsButton, opacity: 0.2, radius: 10)
        addShadowToView(view: contentView, opacity: 0.1, radius: 10)
        
        NSLayoutConstraint.useAndActivateConstraints(constraints: [
            backwardsButton.topAnchor.constraint(equalTo: guide.topAnchor, constant: 10),
            backwardsButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
            
            clearAllDataButton.bottomAnchor.constraint(equalTo: contentView.topAnchor, constant: -10),
            clearAllDataButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            
            contentView.topAnchor.constraint(equalTo: guide.topAnchor, constant: 200),
            contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            contentView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
            contentView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10),
            
            checkoutLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            checkoutLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10),
            
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
            subtotalLabel.leftAnchor.constraint(equalTo: subtotalView.leftAnchor),
            
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
