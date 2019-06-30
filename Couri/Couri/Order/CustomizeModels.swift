//
//  CustomizeModels.swift
//  Couri
//
//  Created by David Chen on 6/25/19.
//  Copyright © 2019 Couri. All rights reserved.
//

import Foundation
import UIKit

class MasterCustomize: NSObject {
    var title: String?
    var choices: [CustomizableOptions]?
    var isRequired = false
}

class CustomizableOptions {
    var isSingleSelection = Bool()
    var title = String()
    var addedPrice: Double?
}
