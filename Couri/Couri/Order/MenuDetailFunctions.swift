//
//  MenuDetailFunctions.swift
//  Couri
//
//  Created by David Chen on 7/3/19.
//  Copyright © 2019 Couri. All rights reserved.
//

import Foundation
import UIKit
import CoreData

extension MenuDetailVC {
    
    // Function that does the math to update your order price. Makes a new array based on the optional added price of each customizable, and is called every time a user selects or deselects a customizable. Sums the array to create the base order price, which is then multiplied by the item count to produce the multiplied order price.
    func updateOrderInfo() {
        let selectedIndexPath = masterCollectionView.indexPathsForSelectedItems
        var pricesArray: [Double] = []
        var choiceArray: [String] = []
        var sumPrices = Double()
        for indexPath in selectedIndexPath ?? [] {
            if let selectedChoices = masterCustomizables?[indexPath.section].choices?[indexPath.row] {
                let price = selectedChoices.addedPrice ?? 0.0
                pricesArray.append(price)
                let choice = selectedChoices.title
                choiceArray.append(choice)
            }
        }
        
        for price in pricesArray {
            sumPrices += price
        }
        
        baseOrderPrice = immutableOrderPrice + sumPrices
        multipliedOrderPrice = baseOrderPrice * Double(itemCount)
        checkoutPriceLabel.text = "$\(String(format: "%.2f", (multipliedOrderPrice)))"
        listOfChoices = choiceArray
        
        let selectionFeedbackGenerator = UISelectionFeedbackGenerator()
        selectionFeedbackGenerator.selectionChanged()
    }
    
    @objc func handleMore() {
        specialInstructionsView.showSidebar()
    }
    
    // Called exclusively by the plus button. Adds 1 to item count each time it's called, and updates the count label accordingly. It also changes the multiplied order price to the count * base order price (which may or may not have been mutated by the added prices).
    @objc func increaseCount() {
        itemCount += 1
        countLabel.text = String(itemCount)
        multipliedOrderPrice = Double(itemCount)*baseOrderPrice
        minusButton.setTitleColor(UIColor.black, for: .normal)
        checkoutPriceLabel.text = "$\(String(format: "%.2f", (multipliedOrderPrice)))"
        let selectionFeedbackGenerator = UISelectionFeedbackGenerator()
        selectionFeedbackGenerator.selectionChanged()
    }
    
    // Called exclusively by the minus button. Subtracts 1 from item count each time it's called, unless the item count is 1. If the item count is greater than 2, the item simply does the reverse of the plus button.
    @objc func decreaseCount() {
        if itemCount > 2 {
            itemCount -= 1
            countLabel.text = String(itemCount)
            multipliedOrderPrice = baseOrderPrice*Double(itemCount)
            checkoutPriceLabel.text = "$\(String(format: "%.2f", (multipliedOrderPrice)))"
        } else {
            itemCount = 1
            multipliedOrderPrice = baseOrderPrice
            checkoutPriceLabel.text = "$\(String(format: "%.2f", (multipliedOrderPrice)))"
            countLabel.text = String(itemCount)
            minusButton.setTitleColor(UIColor.white, for: .normal)
        }
        let selectionFeedbackGenerator = UISelectionFeedbackGenerator()
        selectionFeedbackGenerator.selectionChanged()
    }
    
    // Determines whether or not the order is complete (returns a Bool) by comparing the number of "is single selection" customizable cells selected with the number of "is required" master customizables.
    func isOrderComplete() -> Bool {
        var requiredCount = 0
        for masterCustomizable in masterCustomizables ?? [] {
            if masterCustomizable.isRequired {
                requiredCount += 1
            }
        }
        
        let selectedIndexPath = masterCollectionView.indexPathsForSelectedItems
        var requiredSelectedCount = 0
        for indexPath in selectedIndexPath ?? [] {
            if let selectedChoices = masterCustomizables?[indexPath.section].choices?[indexPath.row] {
                if selectedChoices.isSingleSelection {
                    requiredSelectedCount += 1
                }
            }
        }
        
        if requiredSelectedCount < requiredCount {
            return false
        }
        else {
            return true
        }
    }
    
    // Sets Menu Detail View Controller's item order array variable to the persisted item order array.
    func setupFetchRequest() {
        let fetchRequest: NSFetchRequest<ItemOrder> = ItemOrder.fetchRequest()
        do {
            let itemOrderArray = try PersistenceService.context.fetch(fetchRequest)
            self.itemOrderArray = itemOrderArray
        } catch {}
    }
    
    
    // Purges all data in the ItemOrder entity, and performs the segue (which calls the add new order function directly below)
    func clearCartAddNew(action: UIAlertAction) {
        let fetchRequest: NSFetchRequest<ItemOrder> = ItemOrder.fetchRequest()
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest as! NSFetchRequest<NSFetchRequestResult>)
        do {
            try PersistenceService.context.execute(deleteRequest)
        } catch {}
        performSegue(withIdentifier: "checkoutSegue", sender: self)
    }
    
    // All of the data included with each order: Name, quantity, price, customizables (the customizables array joined into a string), indexPath for selected items, and restaurant address (stored as a string).
    func addNewOrder() {
        let itemOrder = ItemOrder(context: PersistenceService.context)
        itemOrder.name = item?.itemName
        itemOrder.quantity = Int16(itemCount)
        itemOrder.price = multipliedOrderPrice
        itemOrder.customizables = listOfChoices.joined(separator: ", ")
        itemOrder.indexPath = masterCollectionView.indexPathsForSelectedItems ?? []
        itemOrder.restaurant = restaurant?.address
        PersistenceService.saveContext()
    }
    
    // Function that is made up mostly of alerts. If the user does not have an ongoing order from another restaurant, and her order is complete, the app will segue into the checkout view controller. If either of these (or both) are not true, the app will give an alert informing her of such.
    @objc func addToOrder() {
        if (itemOrderArray?.count)! > 0, itemOrderArray?[0].restaurant != restaurant?.address {
            if isOrderComplete() {
                let alert = UIAlertController(title: "Whoops!", message: "Looks like you already have an item from another menu in your cart. Would you like to clear your exiting order cart and start a new one?", preferredStyle: .actionSheet)
                alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: clearCartAddNew))
                self.present(alert, animated: true)
            } else {
                let alert = UIAlertController(title: "Whoops!", message: "Looks like you haven't completed your order. Make sure all of the required options are selected before adding to your order.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Back", style: .cancel, handler: nil))
                self.present(alert, animated: true)
            }
        } else {
            if isOrderComplete() {
                performSegue(withIdentifier: "checkoutSegue", sender: self)
            } else {
                let alert = UIAlertController(title: "Why were you even born?", message: "The next time you try to add to order without completing, I will spank you.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "SORRY :(", style: .cancel, handler: nil))
                self.present(alert, animated: true)
            }
        }
    }
    
    // Calls the add new order function, if the segue destination is checkout view controller.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is CheckoutViewController {
            addNewOrder()
        }
    }
    
    // Puts everything on the view controller.
    func setupViews() {
        contentView.backgroundColor = UIColor.white
        checkoutButtonView.backgroundColor = UIColor.white
        
        addShadowButton(button: backwardsButton)
        cardView.layer.cornerRadius = 20
        cardView.clipsToBounds = true
        
        contentView.addSubview(itemImage)
        contentView.addSubview(backwardsButton)
        contentView.addSubview(masterCollectionView)
        contentView.addSubview(cardView)
        contentView.addSubview(counterButtonView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(priceLabel)
        
        contentView.addSubview(addToOrderView)
        
        addToOrderView.addSubview(specialInstructionsButton)
        addToOrderView.addSubview(arrow)
        
        counterButtonView.addSubview(plusButton)
        counterButtonView.addSubview(minusButton)
        counterButtonView.addSubview(countLabel)
        
        checkoutButtonView.addSubview(addToOrderButton)
        addToOrderButton.addSubview(checkoutPriceLabel)
        
        addToOrderButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(addToOrder)))
        specialInstructionsButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleMore)))
        
        backwardsButton.addTarget(self, action: #selector(backTapped), for: .touchUpInside)
        plusButton.addTarget(self, action: #selector(increaseCount), for: .touchUpInside)
        minusButton.addTarget(self, action: #selector(decreaseCount), for: .touchUpInside)
        
        nameLabel.text = item?.itemName
        descriptionLabel.text = item?.itemDescription
        immutableOrderPrice = item!.itemPrice
        baseOrderPrice = item!.itemPrice
        multipliedOrderPrice = item!.itemPrice
        priceLabel.text = " $\(String(format: "%.2f", (item?.itemPrice)!)) "
        checkoutPriceLabel.text = "$\(String(format: "%.2f", (multipliedOrderPrice)))"
        countLabel.text = String(itemCount)
        
        if item?.itemImage != nil {
            itemImage.image = item?.itemImage
            cardView.topAnchor.constraint(equalTo: itemImage.bottomAnchor, constant: -60).isActive = true
        } else {
            cardView.topAnchor.constraint(equalTo: backwardsButton.bottomAnchor, constant: 20).isActive = true
        }
        
        if item?.itemDescription != nil {
            priceLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 5).isActive = true
            descriptionLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor).isActive = true
            descriptionLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor).isActive = true
            descriptionLabel.rightAnchor.constraint(equalTo: cardView.rightAnchor, constant: -10).isActive = true
        } else {
            priceLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor).isActive = true
        }
        
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.useAndActivateConstraints(constraints: [
            backwardsButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 40),
            backwardsButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            
            cardView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            cardView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            cardView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            cardView.bottomAnchor.constraint(equalTo: counterButtonView.bottomAnchor, constant: 20),
            
            itemImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: -50),
            itemImage.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            itemImage.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            itemImage.heightAnchor.constraint(equalToConstant: contentView.frame.height * 1/3),
            
            nameLabel.leftAnchor.constraint(equalTo: cardView.leftAnchor, constant: 20),
            nameLabel.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 10),
            nameLabel.rightAnchor.constraint(equalTo: cardView.rightAnchor, constant: -20),
            
            priceLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            
            masterCollectionView.topAnchor.constraint(equalTo: cardView.bottomAnchor),
            masterCollectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -41),
            masterCollectionView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            masterCollectionView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            
            addToOrderView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            addToOrderView.heightAnchor.constraint(equalToConstant: 42),
            addToOrderView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            addToOrderView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            specialInstructionsButton.topAnchor.constraint(equalTo: addToOrderView.topAnchor, constant: 1),
            specialInstructionsButton.heightAnchor.constraint(equalToConstant: 40),
            specialInstructionsButton.leftAnchor.constraint(equalTo: addToOrderView.leftAnchor),
            specialInstructionsButton.rightAnchor.constraint(equalTo: addToOrderView.rightAnchor),
            
            arrow.rightAnchor.constraint(equalTo: addToOrderView.rightAnchor, constant: -30),
            arrow.centerYAnchor.constraint(equalTo: specialInstructionsButton.centerYAnchor),
            arrow.heightAnchor.constraint(equalToConstant: 15),
            arrow.widthAnchor.constraint(equalToConstant: 15),
            
            counterButtonView.heightAnchor.constraint(equalToConstant: 30),
            counterButtonView.widthAnchor.constraint(equalToConstant: 100),
            counterButtonView.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 10),
            counterButtonView.leadingAnchor.constraint(equalTo: priceLabel.leadingAnchor),
            
            plusButton.rightAnchor.constraint(equalTo: counterButtonView.rightAnchor),
            plusButton.topAnchor.constraint(equalTo: counterButtonView.topAnchor),
            plusButton.bottomAnchor.constraint(equalTo: counterButtonView.bottomAnchor),
            plusButton.widthAnchor.constraint(equalToConstant: 30),
            plusButton.heightAnchor.constraint(equalToConstant: 30),
            
            minusButton.leftAnchor.constraint(equalTo: counterButtonView.leftAnchor),
            minusButton.topAnchor.constraint(equalTo: counterButtonView.topAnchor),
            minusButton.bottomAnchor.constraint(equalTo: counterButtonView.bottomAnchor),
            minusButton.widthAnchor.constraint(equalToConstant: 30),
            minusButton.heightAnchor.constraint(equalToConstant: 30),
            
            countLabel.centerXAnchor.constraint(equalTo: counterButtonView.centerXAnchor),
            countLabel.centerYAnchor.constraint(equalTo: counterButtonView.centerYAnchor),
            
            addToOrderButton.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20),
            addToOrderButton.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -20),
            addToOrderButton.heightAnchor.constraint(equalToConstant: 40),
            addToOrderButton.topAnchor.constraint(equalTo: checkoutButtonView.topAnchor, constant: 10),
            
            checkoutPriceLabel.rightAnchor.constraint(equalTo: addToOrderButton.rightAnchor, constant: -20),
            checkoutPriceLabel.centerYAnchor.constraint(equalTo: addToOrderButton.centerYAnchor)
            ])
    }
    
    // Sets up the Collection View of customizables, and its header.
    func setupCV() {
        masterCollectionView.dataSource = self
        masterCollectionView.delegate = self
        masterCollectionView.register(CustomizeCellHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerID")
        masterCollectionView.register(CustomizeCell.self, forCellWithReuseIdentifier: cvCellID)
        masterCollectionView.backgroundColor = UIColor.white
        masterCollectionView.allowsMultipleSelection = true
        
        //Layout things. Sets margins
        let collectionViewLayout = masterCollectionView.collectionViewLayout as? UICollectionViewFlowLayout
        collectionViewLayout?.invalidateLayout()
    }
    
    // Aesthetic gradient layer.
    func setupGradientLayer() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.white.cgColor, UIColor.white.withAlphaComponent(0).cgColor]
        gradientLayer.locations = [0, 1]
        gradientLayer.frame = CGRect(x: 0, y: -50, width: 500, height: 120)
        contentView.layer.addSublayer(gradientLayer)
    }
}

