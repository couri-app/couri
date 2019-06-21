//
//  RestaurantDetailViewController.swift
//  Couri
//
//  Created by David Chen on 6/18/19.
//  Copyright © 2019 Couri. All rights reserved.
//

import Foundation
import UIKit

class RestaurantDetailViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UITableViewDelegate, UITableViewDataSource {
    
    private let cellID = "categoryCellID"
    var restaurant: Restaurant?
    
    @IBOutlet weak var restaurantNameLabel: UILabel!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var restaurantImage: UIImageView!
    @IBOutlet weak var restaurantCategories: UILabel!
    @IBOutlet weak var menuCategoryCV: UICollectionView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var masterTableView: SelfSizedTableView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBAction func backTapped(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        masterTableView.isScrollEnabled = false
        masterTableView.maxHeight = view.frame.height
        masterTableView.alwaysBounceVertical = false
        masterTableView.register(MenuItemCell.self, forCellReuseIdentifier: "menuCell")
        masterTableView.rowHeight = UITableView.automaticDimension
        masterTableView.estimatedRowHeight = 100
        masterTableView.delegate = self
        masterTableView.dataSource = self
    
        restaurantNameLabel.text = restaurant?.restaurantName
        restaurantImage.image = restaurant?.imageName
        restaurantCategories.text = restaurant?.categoryDescription
        restaurantCategories.numberOfLines = 0
        setupCV()
        
        //Aesthetics
        containerView.layer.cornerRadius = 20
        addShadowObject(object: containerView)

    }
    
    func setupCV() {
        menuCategoryCV.translatesAutoresizingMaskIntoConstraints = false
        menuCategoryCV.dataSource = self
        menuCategoryCV.delegate = self
        menuCategoryCV.register(CategoryCell.self, forCellWithReuseIdentifier: cellID)
        
        let collectionViewLayout = menuCategoryCV.collectionViewLayout as? UICollectionViewFlowLayout
        
        collectionViewLayout?.sectionInset = UIEdgeInsets(top: 0, left: 19, bottom: 0, right: 19)
        collectionViewLayout?.invalidateLayout()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let count = restaurant?.categories.count {
            return count
        } else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! CategoryCell
        cell.categoryLabel.text = restaurant?.categories[indexPath.row]
        if cell.categoryLabel.text == restaurant?.categories[0] {
            cell.selectCategory()
        }

        if UIImage(named: (restaurant?.categories[indexPath.row])!) != nil {
            cell.buttonView.image = UIImage(named: (restaurant?.categories[indexPath.row])!)
        }
        
        return cell
    }
    
    func addShadowObject(object: UIView) {
        object.layer.shadowRadius = 8
        object.layer.shadowColor = #colorLiteral(red: 0.07881314767, green: 0.07881314767, blue: 0.07881314767, alpha: 1)
        object.layer.shadowOffset = CGSize(width: 0, height: 0)
        object.layer.shadowOpacity = 0.1
        object.layer.shadowRadius = 4
    }
}

extension RestaurantDetailViewController {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count = restaurant?.menuItems.count {
            return count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = masterTableView.dequeueReusableCell(withIdentifier: "menuCell", for: indexPath) as! MenuItemCell

        if restaurant?.menuItems[indexPath.row].itemDescription != nil {
            cell.itemDescription.text = restaurant?.menuItems[indexPath.row].itemDescription
        } else {
            cell.itemPrice.topAnchor.constraint(equalTo: cell.itemName.bottomAnchor, constant: 5).isActive = true
        }
        
        if restaurant?.menuItems[indexPath.row].itemImage != nil {
            cell.itemImage.image = UIImage(named: (restaurant?.menuItems[indexPath.row].itemImage)!)
        } else {
            cell.itemName.leftAnchor.constraint(equalTo: cell.leftAnchor).isActive = true
            cell.itemName.topAnchor.constraint(equalTo: cell.topAnchor, constant: 10).isActive = true
        }
        
        cell.itemName.text = restaurant?.menuItems[indexPath.row].itemName
        cell.itemPrice.text = "$\(String(format: "%.2f", (restaurant?.menuItems[indexPath.row].itemPrice)!))"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if restaurant?.menuItems[indexPath.row].itemImage != nil, restaurant?.menuItems[indexPath.row].itemDescription == nil {
            return 90
        } else if restaurant?.menuItems[indexPath.row].itemDescription != nil {
            return 110
        } else {
            return 70
        }
    }
}

class SelfSizedTableView: UITableView {
    var maxHeight: CGFloat = UIScreen.main.bounds.size.height
    
    override func reloadData() {
        super.reloadData()
        self.invalidateIntrinsicContentSize()
        self.layoutIfNeeded()
    }
    
    override var intrinsicContentSize: CGSize {
        let height = min(contentSize.height, maxHeight)
        return CGSize(width: contentSize.width, height: height)
    }
}
