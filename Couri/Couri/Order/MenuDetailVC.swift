//
//  MenuDetailVC.swift
//  Couri
//
//  Created by David Chen on 6/21/19.
//  Copyright © 2019 Couri. All rights reserved.
//

import UIKit

class MenuDetailVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    // Item gives this view controller access to the MenuItem class. masterCustomizables does the same thing, but returns an array of MasterCustomize class. Remember, MasterCustomize is akin to each section in the collectionview. Its instance variables are: .isRequired -> Bool, choices -> [CustomizableChoices], and .title -> String
    var item: MenuItem?
    var cvCellID = "collectionviewid"
    var masterCustomizables: [MasterCustomize]?
    let checkoutView = CheckoutView()
    
    // Interface Builder Outlets
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var checkoutButtonView: UIView!
    @IBOutlet weak var scrollview: UIScrollView!
    
    // Segues back to previous view controller
    @objc func backTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupViews()
        setupCV()
        setupGradientLayer()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        masterCustomizables = item?.customizables
        checkoutView.hide()
        contentView.topAnchor.constraint(equalTo: scrollview.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo:scrollview.bottomAnchor).isActive = true
    }
    
    // Variables that mutate depending on action called. Base order price is only mutated when a customization with an added price is selected. Multiplied order price is only mutated when the counter buttons are tapped. Item count is also mutated when the counter buttons are tapped.
    var immutableOrderPrice = Double()
    var baseOrderPrice = Double()
    var multipliedOrderPrice = Double()
    var itemCount = 1
    
    // Every visual element in our view controller. In order, they are: backwards button, name label, description label, item image, price label (static), checkout price label (mutable), add to order button, card view, master collection view, counter view, add to order view, counter button view, plus button, minus button, count label, special instructions button, and arrow.
    let backwardsButton: UIButton = {
        let button = UIButton()
        button.frame.size = CGSize(width: 50, height: 50)
        button.setImage(UIImage(named: "backwards"), for: .normal)
        return button
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AvenirNext-Bold", size: 25)
        label.numberOfLines = 0
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AvenirNext-Regular", size: 14)
        label.numberOfLines = 0
        return label
    }()
    
    let itemImage: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    let priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AvenirNext-Bold", size: 14)
        label.backgroundColor = #colorLiteral(red: 0.06274510175, green: 0, blue: 0.1921568662, alpha: 1)
        label.textColor = UIColor.white
        label.layer.cornerRadius = 3
        label.layer.masksToBounds = true
        return label
    }()
    
    let checkoutPriceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AvenirNext-Medium", size: 16)
        return label
    }()
    
    let addToOrderButton: UIView = {
        let view = UIView()
        let label = UILabel()
        label.text = "Add to Order"
        label.font = UIFont(name: "AvenirNext-Medium", size: 16)
        view.backgroundColor = UIColor(named: "honeyYellow")
        view.layer.cornerRadius = 5
        view.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        return view
    }()
    
    let cardView: UIVisualEffectView = {
        let subview = UIVisualEffectView()
        subview.effect = UIBlurEffect(style: .extraLight)
        subview.backgroundColor = UIColor.white.withAlphaComponent(0.2)
        return subview
    }()
    
    let masterCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionHeadersPinToVisibleBounds = true
        layout.minimumLineSpacing = 0
        layout.estimatedItemSize = CGSize(width: 1, height: 1)
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return cv
    }()

    // UIView that acts as a button due to an added tap gesture recognizer which calls @objc func addToOrder()
    let addToOrderView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        let separatorBar = UIView()
        let smallSeparator = UIView()
        separatorBar.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        view.backgroundColor = UIColor.white
        view.addSubview(separatorBar)
        view.addSubview(smallSeparator)
        smallSeparator.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        NSLayoutConstraint.useAndActivateConstraints(constraints: [
            separatorBar.topAnchor.constraint(equalTo: view.topAnchor),
            separatorBar.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            separatorBar.leftAnchor.constraint(equalTo: view.leftAnchor),
            separatorBar.rightAnchor.constraint(equalTo: view.rightAnchor),
            separatorBar.heightAnchor.constraint(equalToConstant: 1/4),
            
            smallSeparator.topAnchor.constraint(equalTo: view.topAnchor, constant: 41),
            smallSeparator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            smallSeparator.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            smallSeparator.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            smallSeparator.heightAnchor.constraint(equalToConstant: 1/4)
            ])
        return view
    }()
    
    let counterButtonView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white.withAlphaComponent(0)
        view.layer.cornerRadius = 4
        view.clipsToBounds = true
        return view
    }()
    
    let plusButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(named: "honeyYellow")
        button.setTitle("+", for: .normal)
        button.titleLabel?.font = UIFont(name: "AvenirNext-Regular", size: 20)
        button.setTitleColor(UIColor.black, for: .normal)
        button.layer.frame.size = CGSize(width: 50, height: 50)
        return button
    }()
    
    let minusButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(named: "honeyYellow")
        button.setTitle("—", for: .normal)
        button.titleLabel?.font = UIFont(name: "AvenirNext-Regular", size: 20)
        button.setTitleColor(UIColor.white, for: .normal)
        return button
    }()
    
    let countLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AvenirNext-Regular", size: 16)
        return label
    }()
    
    let specialInstructionsView = SpecialInstructionsView()
    
    let specialInstructionsButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.white
        button.setTitle("Add Special Instructions", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.titleLabel?.font = UIFont(name: "AvenirNext-Medium", size: 16)
        button.contentHorizontalAlignment = .left
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 0)
        return button
    }()
    
    let arrow: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "rightarrow")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    func addShadowButton(button: UIButton) {
        button.layer.shadowRadius = 8
        button.layer.shadowColor = #colorLiteral(red: 0.07881314767, green: 0.07881314767, blue: 0.07881314767, alpha: 1)
        button.layer.shadowOffset = CGSize(width: 0, height: 0)
        button.layer.shadowOpacity = 0.2
        button.layer.shadowRadius = 10
    }
    
    func addShadowView(view: UIView, color: UIColor) {
        view.layer.shadowColor = color.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 0)
        view.layer.shadowOpacity = 0.2
        view.layer.shadowRadius = 10
    }
    
    var listOfChoices = [String]()
    
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
    }
    
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
    
    // Segues into same restaurant detail view controller as before, with a new view at the bottom of the screen with the order count
    @objc func addToOrder() {
        if isOrderComplete() {
            if let name = item?.itemName, let selections = masterCollectionView.indexPathsForSelectedItems {
                print("Phantom added to Order: Item: \(name), Quantity: \(itemCount) Price: $\(multipliedOrderPrice), Choices: \(listOfChoices), indexPathSelected: \(selections)")
            }
            performSegue(withIdentifier: "checkoutSegue", sender: self)
        } else {
            let alert = UIAlertController(title: "Why were you even born?", message: "The next time you try to add to order without completing, I will spank you.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "SORRY :(", style: .cancel, handler: nil))
            self.present(alert, animated: true)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is CheckoutViewController {
            let itemOrder = ItemOrder(context: PersistenceService.context)
            itemOrder.name = item?.itemName
            itemOrder.quantity = Int16(itemCount)
            itemOrder.price = multipliedOrderPrice
            itemOrder.customizables = listOfChoices.joined(separator: ", ")
            itemOrder.indexPath = masterCollectionView.indexPathsForSelectedItems ?? []
            PersistenceService.saveContext()
        }
    }
    
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
    
    func setupGradientLayer() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.white.cgColor, UIColor.white.withAlphaComponent(0).cgColor]
        gradientLayer.locations = [0, 1]
        gradientLayer.frame = CGRect(x: 0, y: -50, width: 500, height: 120)
        contentView.layer.addSublayer(gradientLayer)
    }
}

// Extension exclusively made for collection view
extension MenuDetailVC {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cvCellID, for: indexPath) as! CustomizeCell
        cell.customizable = masterCustomizables?[indexPath.section].choices?[indexPath.row]
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if let count = masterCustomizables?.count {
            return count
        } else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let count = masterCustomizables?[section].choices?.count {
            return count
        } else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: masterCollectionView.frame.width, height: 44)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        updateOrderInfo()
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        updateOrderInfo()
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        if (masterCustomizables ?? [])[indexPath.section].isRequired,
            let existingSelectedIndex = collectionView.indexPathsForSelectedItems?.first(where: { $0.section == indexPath.section }) {
            collectionView.deselectItem(at: existingSelectedIndex, animated: true)
        }
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldDeselectItemAt indexPath: IndexPath) -> Bool {
        if (masterCustomizables ?? [])[indexPath.section].isRequired {
            return collectionView.indexPathsForSelectedItems?.filter { $0.section == indexPath.section }.count == 0
        } else {
            return true
        }
    }
    
    //HeaderSection
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: masterCollectionView.frame.width, height: 55)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "headerID", for: indexPath) as! CustomizeCellHeader
        header.masterCustomizable = masterCustomizables?[indexPath.section]
        return header
    }
}

extension NSLayoutConstraint {
    
    public class func useAndActivateConstraints(constraints: [NSLayoutConstraint]) {
        for constraint in constraints {
            if let view = constraint.firstItem as? UIView {
                view.translatesAutoresizingMaskIntoConstraints = false
            }
        }
        activate(constraints)
    }
}
