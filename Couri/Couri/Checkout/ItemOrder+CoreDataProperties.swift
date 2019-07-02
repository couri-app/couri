//
//  ItemOrder+CoreDataProperties.swift
//  Couri
//
//  Created by David Chen on 6/29/19.
//  Copyright © 2019 Couri. All rights reserved.
//
//

import Foundation
import CoreData

extension ItemOrder {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ItemOrder> {
        return NSFetchRequest<ItemOrder>(entityName: "ItemOrder")
    }

    @NSManaged public var name: String?
    @NSManaged public var price: Double
    @NSManaged public var customizables: String?
    @NSManaged public var quantity: Int16
    @NSManaged public var indexPath: [Any]
    @NSManaged public var restaurant: String?
}
