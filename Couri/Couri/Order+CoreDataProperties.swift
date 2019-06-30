//
//  Order+CoreDataProperties.swift
//  Couri
//
//  Created by David Chen on 6/29/19.
//  Copyright © 2019 Couri. All rights reserved.
//
//

import Foundation
import CoreData


extension Order {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Order> {
        return NSFetchRequest<Order>(entityName: "Order")
    }

    @NSManaged public var name: String?
    @NSManaged public var price: Double
    @NSManaged public var customizations: String?
    @NSManaged public var count: Int16

}
