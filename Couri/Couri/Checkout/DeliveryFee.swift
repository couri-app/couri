//
//  DeliveryFee.swift
//  Couri
//
//  Created by David Chen on 6/30/19.
//  Copyright © 2019 Couri. All rights reserved.
//

import Foundation
import UIKit

extension CheckoutViewController {
    func calculateOrder(price: Double, quantity: Int, time: Int) {
        var deliveryFee = Double()
        let taxedItem = 1.095*price
        var total = Double()
        let additionalItems = quantity - 1
        var toCourier = Double()
        let orderInputs = (price, time)
        
        switch orderInputs {
        case (...5, ...5):
            deliveryFee = 2
        case (...5, 5..<10):
            deliveryFee = 2.50
        case (...5, 10...15):
            deliveryFee = 3
        case (5..., ...5):
            deliveryFee = 3
        case (5..., 5..<10):
            deliveryFee = 3.50
        case (5..., 10...15):
            deliveryFee = 4.50
        default:
            deliveryFee = 5
        }
        if deliveryFee < 2.22 {
            deliveryFee = 2.22
        }
        
        deliveryFee = deliveryFee + Double(additionalItems) * 0.25
        toCourier = deliveryFee * 0.9
        total = deliveryFee + taxedItem
        
        subtotalPriceLabel.text = "$\(String(format: "%.2f", price))"
        taxPriceLabel.text = "$\(String(format: "%.2f",price*0.095))"
        deliveryPriceLabel.text = "$\(String(format: "%.2f", deliveryFee))"
        checkoutPriceLabel.text = "$\(String(format: "%.2f",total))"
        
        print("Subtotal: $\(price)")
        print("Tax: $\(String(format: "%.2f",price*0.095))")
        print("Customer's Delivery Fee: $\(String(format: "%.2f", deliveryFee))")
        print("Transferred to Courier's balance: $\(String(format: "%.2f",toCourier))")
        print("Goes to Couri: $\(String(format: "%.2f", deliveryFee*0.1))")
        print("Total: $\(String(format: "%.2f",total))")
    }
}
