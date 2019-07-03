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
    
    var restaurant: Restaurant?
    var item: MenuItem?
    var cvCellID = "collectionviewid"
    var masterCustomizables: [MasterCustomize]?
    let checkoutView = CheckoutView()
    var itemOrderArray: [ItemOrder]?
    let checkoutVC = CheckoutViewController()
    
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
        setupFetchRequest()
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
