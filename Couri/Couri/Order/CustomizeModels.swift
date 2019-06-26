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
    var isRequired: Bool?
    
    static func sampleChoicesLibrary() -> [MasterCustomize] {
        let bobaChoice1 = CustomizableOptions()
        bobaChoice1.addedPrice = 0.50
        bobaChoice1.isSingleSelection = true
        bobaChoice1.title = "Big Boba"
        
        let bobaChoice2 = CustomizableOptions()
        bobaChoice2.addedPrice = 0.50
        bobaChoice2.isSingleSelection = true
        bobaChoice2.title = "Double Big Boba"
        
        let bobaChoice3 = CustomizableOptions()
        bobaChoice3.addedPrice = 0.50
        bobaChoice3.isSingleSelection = true
        bobaChoice3.title = "Double Mixed Boba"
        
        let bobaChoice4 = CustomizableOptions()
        bobaChoice4.addedPrice = 0.25
        bobaChoice4.isSingleSelection = true
        bobaChoice4.title = "Double Small Boba"
        
        let bobaChoice5 = CustomizableOptions()
        bobaChoice5.addedPrice = 0.25
        bobaChoice5.isSingleSelection = true
        bobaChoice5.title = "Mixed Boba"
        
        let bobaChoice6 = CustomizableOptions()
        bobaChoice6.addedPrice = 0.25
        bobaChoice6.isSingleSelection = true
        bobaChoice6.title = "No Boba"
        
        let bobaChoice7 = CustomizableOptions()
        bobaChoice7.addedPrice = 0.25
        bobaChoice7.isSingleSelection = true
        bobaChoice7.title = "Small Boba"
        
        let jellyChoice1 = CustomizableOptions()
        jellyChoice1.title = "Aloe"
        jellyChoice1.isSingleSelection = false
        jellyChoice1.addedPrice = 0.75
        
        let jellyChoice2 = CustomizableOptions()
        jellyChoice2.title = "Coffee Jelly"
        jellyChoice2.isSingleSelection = false
        jellyChoice2.addedPrice = 0.75
        
        let jellyChoice3 = CustomizableOptions()
        jellyChoice3.title = "Grass Jelly"
        jellyChoice3.isSingleSelection = false
        jellyChoice3.addedPrice = 0.75
        
        let jellyChoice4 = CustomizableOptions()
        jellyChoice4.title = "Green Apple"
        jellyChoice4.isSingleSelection = false
        jellyChoice4.addedPrice = 0.75
        
        let jellyChoice5 = CustomizableOptions()
        jellyChoice5.title = "Lemon"
        jellyChoice5.isSingleSelection = false
        jellyChoice5.addedPrice = 0.75
        
        let jellyChoice6 = CustomizableOptions()
        jellyChoice6.title = "Lychee"
        jellyChoice6.isSingleSelection = false
        jellyChoice6.addedPrice = 0.75
        
        let jellyChoice7 = CustomizableOptions()
        jellyChoice7.title = "Mango"
        jellyChoice7.isSingleSelection = false
        jellyChoice7.addedPrice = 0.75
        
        let jellyChoice8 = CustomizableOptions()
        jellyChoice8.title = "Pineapple Coconut"
        jellyChoice8.isSingleSelection = false
        jellyChoice8.addedPrice = 0.75
        
        let jellyChoice9 = CustomizableOptions()
        jellyChoice9.title = "Popping Boba"
        jellyChoice9.isSingleSelection = false
        jellyChoice9.addedPrice = 0.75
        
        let jellyChoice10 = CustomizableOptions()
        jellyChoice10.title = "Rainbow"
        jellyChoice10.isSingleSelection = false
        jellyChoice10.addedPrice = 0.75
        
        let addOn1 = CustomizableOptions()
        addOn1.title = "Barley"
        addOn1.isSingleSelection = false
        addOn1.addedPrice = 0.75
        
        let addOn2 = CustomizableOptions()
        addOn2.title = "Pudding"
        addOn2.isSingleSelection = false
        addOn2.addedPrice = 0.75
        
        let addOn3 = CustomizableOptions()
        addOn3.title = "Red Bean"
        addOn3.isSingleSelection = false
        addOn3.addedPrice = 0.75
        
        let addOn4 = CustomizableOptions()
        addOn4.title = "Sesame"
        addOn4.isSingleSelection = false
        addOn4.addedPrice = 0.75
        
        let temp1 = CustomizableOptions()
        temp1.title = "Cold"
        temp1.isSingleSelection = true
        
        let temp2 = CustomizableOptions()
        temp2.title = "Hot"
        temp2.isSingleSelection = true
        temp2.addedPrice = 0.25
        
        let ice1 = CustomizableOptions()
        ice1.title = "Light Ice"
        ice1.isSingleSelection = true

        let ice2 = CustomizableOptions()
        ice2.title = "No Ice"
        ice2.isSingleSelection = true

        let ice3 = CustomizableOptions()
        ice3.title = "Regular Ice"
        ice3.isSingleSelection = true
        
        //MARK: MasterCustomize Instances
        let teBoba = MasterCustomize()
        teBoba.title = "CHOICE OF BOBA"
        teBoba.isRequired = true
        
        let teJelly = MasterCustomize()
        teJelly.isRequired = false
        teJelly.title = "CHOICE OF JELLY"
        
        let teAddOn = MasterCustomize()
        teAddOn.title = "CHOICE OF ADD-ONS"
        teAddOn.isRequired = false
        
        let teTemp = MasterCustomize()
        teTemp.title = "Choice of Temperature"
        teTemp.isRequired = true
        
        let teIce = MasterCustomize()
        teIce.title = "Choice of ice level"
        teIce.isRequired = true
        teIce.choices = [ice1, ice2, ice3]
        
        teBoba.choices = [bobaChoice1, bobaChoice2, bobaChoice3, bobaChoice4, bobaChoice5, bobaChoice6, bobaChoice7]
        teJelly.choices = [jellyChoice1, jellyChoice2, jellyChoice3, jellyChoice4, jellyChoice5, jellyChoice6, jellyChoice7, jellyChoice8, jellyChoice9, jellyChoice10]
        teAddOn.choices = [addOn1, addOn2, addOn3, addOn4]
        teTemp.choices = [temp1, temp2]
        
        return [teBoba, teJelly, teAddOn, teTemp, teIce]
    }
}

class CustomizableOptions {
    var isSingleSelection = Bool()
    var title = String()
    var addedPrice: Double?
}
