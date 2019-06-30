//
//  TemporaryCategoryLibraries.swift
//  Couri
//
//  Created by David Chen on 6/26/19.
//  Copyright © 2019 Couri. All rights reserved.
//

import Foundation
import UIKit

struct TemporaryCustomizableLibrary {
    var boba: [CustomizableOptions] = []
    var jelly: [CustomizableOptions] = []
    var addOn: [CustomizableOptions] = []
    var temp: [CustomizableOptions] = []
    var ice: [CustomizableOptions] = []
    var drink: [CustomizableOptions] = []
    var sweet: [CustomizableOptions] = []
    var spicy: [CustomizableOptions] = []
    var size: [CustomizableOptions] = []
    var sub: [CustomizableOptions] = []
    
    init() {
        generateLibrary()
    }
    mutating func generateLibrary() {
        let bobaChoice1 = CustomizableOptions()
        bobaChoice1.addedPrice = 0.50
        bobaChoice1.isSingleSelection = true
        bobaChoice1.title = "Big Boba"
        
        let bobaChoice2 = CustomizableOptions()
        bobaChoice2.addedPrice = 1.00
        bobaChoice2.isSingleSelection = true
        bobaChoice2.title = "Double Big Boba"
        
        let bobaChoice3 = CustomizableOptions()
        bobaChoice3.addedPrice = 1.00
        bobaChoice3.isSingleSelection = true
        bobaChoice3.title = "Double Mixed Boba"
        
        let bobaChoice4 = CustomizableOptions()
        bobaChoice4.addedPrice = 1.00
        bobaChoice4.isSingleSelection = true
        bobaChoice4.title = "Double Small Boba"
        
        let bobaChoice5 = CustomizableOptions()
        bobaChoice5.addedPrice = 0.50
        bobaChoice5.isSingleSelection = true
        bobaChoice5.title = "Mixed Boba"
        
        let bobaChoice6 = CustomizableOptions()
        bobaChoice6.isSingleSelection = true
        bobaChoice6.title = "No Boba"
        
        let bobaChoice7 = CustomizableOptions()
        bobaChoice7.addedPrice = 0.50
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
        
        let drink1 = CustomizableOptions()
        drink1.title = "Black Tea"
        drink1.isSingleSelection = true
        
        let drink2 = CustomizableOptions()
        drink2.title = "Bottled Water"
        drink2.isSingleSelection = true
        
        let drink3 = CustomizableOptions()
        drink3.title = "Coke"
        drink3.isSingleSelection = true
        
        let drink4 = CustomizableOptions()
        drink4.title = "Diet Coke"
        drink4.isSingleSelection = true
        
        let drink5 = CustomizableOptions()
        drink5.title = "Green Tea"
        drink5.isSingleSelection = true
        
        let drink6 = CustomizableOptions()
        drink6.title = "Milk Tea"
        drink6.isSingleSelection = true
        
        let drink7 = CustomizableOptions()
        drink7.title = "Black Tea with Boba"
        drink7.isSingleSelection = true
        
        let drink8 = CustomizableOptions()
        drink8.title = "Sprite"
        drink8.isSingleSelection = true
        
        let sweet1 = CustomizableOptions()
        sweet1.title = "1/2 Sugar"
        sweet1.isSingleSelection = true
        
        let sweet2 = CustomizableOptions()
        sweet2.title = "1/4 Sugar"
        sweet2.isSingleSelection = true
        
        let sweet3 = CustomizableOptions()
        sweet3.title = "3/4 Sugar"
        sweet3.isSingleSelection = true
        
        let sweet4 = CustomizableOptions()
        sweet4.title = "No Sugar"
        sweet4.isSingleSelection = true
        
        let sweet5 = CustomizableOptions()
        sweet5.title = "Regular Sugar"
        sweet5.isSingleSelection = true
        
        let spicy1 = CustomizableOptions()
        spicy1.title = "Extra Spicy"
        spicy1.isSingleSelection = true
        
        let spicy2 = CustomizableOptions()
        spicy2.title = "Medium"
        spicy2.isSingleSelection = true
        
        let spicy3 = CustomizableOptions()
        spicy3.title = "Mild"
        spicy3.isSingleSelection = true
        
        let spicy4 = CustomizableOptions()
        spicy4.title = "No Spice"
        spicy4.isSingleSelection = true
        
        let size1 = CustomizableOptions()
        size1.title = "Large"
        size1.addedPrice = 0.75
        size1.isSingleSelection = true
        
        let size2 = CustomizableOptions()
        size2.title = "Regular"
        size2.isSingleSelection = true
        
        let sub1 = CustomizableOptions()
        sub1.title = "Soymilk"
        sub1.isSingleSelection = false
        sub1.addedPrice = 0.5
        
        boba = [bobaChoice1, bobaChoice2, bobaChoice3, bobaChoice4, bobaChoice5, bobaChoice6, bobaChoice7]
        jelly = [jellyChoice1, jellyChoice2, jellyChoice3, jellyChoice4, jellyChoice5, jellyChoice6, jellyChoice7, jellyChoice8, jellyChoice9, jellyChoice10]
        addOn = [addOn1, addOn2, addOn3, addOn4]
        temp = [temp1, temp2]
        ice = [ice1, ice2, ice3]
        drink = [drink1, drink2, drink3, drink4, drink5, drink6, drink7, drink8]
        sweet = [sweet1, sweet2, sweet3, sweet4, sweet5]
        spicy = [spicy1, spicy2, spicy3, spicy4]
        size = [size1, size2]
        sub = [sub1]
    }
}

struct TemporaryMasterCustomizableLibrary {
    let temporaryCustomizableLibrary = TemporaryCustomizableLibrary()
    var boba = MasterCustomize()
    var jelly = MasterCustomize()
    var addOn = MasterCustomize()
    var temp = MasterCustomize()
    var ice = MasterCustomize()
    var drink = MasterCustomize()
    var sweet = MasterCustomize()
    var spicy = MasterCustomize()
    var size = MasterCustomize()
    var sub = MasterCustomize()
    
    init() {
        generateLibrary()
    }
    
    mutating func generateLibrary() {
        boba.title = "CHOICE OF BOBA"
        boba.isRequired = true
        boba.choices = temporaryCustomizableLibrary.boba
        
        jelly.isRequired = false
        jelly.title = "CHOICE OF JELLY"
        jelly.choices = temporaryCustomizableLibrary.jelly
        
        addOn.title = "CHOICE OF ADD-ONS"
        addOn.isRequired = false
        addOn.choices = temporaryCustomizableLibrary.addOn
        
        temp.title = "Choice of Temperature"
        temp.isRequired = true
        temp.choices = temporaryCustomizableLibrary.temp
        
        ice.title = "Choice of ice level"
        ice.isRequired = true
        ice.choices = temporaryCustomizableLibrary.ice
        
        drink.title = "Choice of combo drink"
        drink.isRequired = true
        drink.choices = temporaryCustomizableLibrary.drink
        
        sweet.title = "Choice of Sweetness Level"
        sweet.isRequired = true
        sweet.choices = temporaryCustomizableLibrary.sweet
        
        spicy.title = "Choice of Spiciness Level"
        spicy.isRequired = true
        spicy.choices = temporaryCustomizableLibrary.spicy
        
        size.title = "Choice of Size"
        size.isRequired = true
        size.choices = temporaryCustomizableLibrary.size
        
        sub.title = "Choice of Substitution"
        sub.isRequired = false
        sub.choices = temporaryCustomizableLibrary.sub
    }
}
