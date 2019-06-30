//
//  Order.swift
//  Couri
//
//  Created by David Chen on 6/29/19.
//  Copyright © 2019 Couri. All rights reserved.
//

import Foundation
import UIKit

class Order: NSObject {
    var orderTitle: String
    var orderPrice: Int
    var itemCount: Int
    var customized: String
    
    init(orderTitle: String, orderPrice: Int, itemCount: Int, customized: String) {
        self.orderTitle = orderTitle
        self.orderPrice = orderPrice
        self.itemCount = itemCount
        self.customized = customized
    }
}
