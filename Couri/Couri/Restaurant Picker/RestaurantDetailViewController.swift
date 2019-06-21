//
//  RestaurantDetailViewController.swift
//  Couri
//
//  Created by David Chen on 6/18/19.
//  Copyright © 2019 Couri. All rights reserved.
//

import UIKit

class RestaurantDetailViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UITableViewDelegate, UITableViewDataSource {
    
    private let cellID = "categoryCellID"
    var restaurant: Restaurant?
    let menuLibrary = MenuLibrary()

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
        return 7
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath)
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
        return menuLibrary.tapiocaExpressMenu.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = masterTableView.dequeueReusableCell(withIdentifier: "menuCell", for: indexPath) as! MenuItemCell

        if menuLibrary.tapiocaExpressMenu[indexPath.row].itemDescription != nil {
            cell.itemDescription.text = menuLibrary.tapiocaExpressMenu[indexPath.row].itemDescription!
        } else {
            cell.itemPrice.topAnchor.constraint(equalTo: cell.itemName.bottomAnchor, constant: 5).isActive = true
        }
        
        if menuLibrary.tapiocaExpressMenu[indexPath.row].itemImage != nil {
            cell.itemImage.image = UIImage(named: menuLibrary.tapiocaExpressMenu[indexPath.row].itemImage!)
        } else {
            cell.itemName.leftAnchor.constraint(equalTo: cell.leftAnchor).isActive = true
            cell.itemName.topAnchor.constraint(equalTo: cell.topAnchor, constant: 10).isActive = true
        }
        
        cell.itemName.text = menuLibrary.tapiocaExpressMenu[indexPath.row].itemName
        cell.itemPrice.text = "$\(menuLibrary.tapiocaExpressMenu[indexPath.row].itemPrice)"

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if menuLibrary.tapiocaExpressMenu[indexPath.row].itemImage != nil, menuLibrary.tapiocaExpressMenu[indexPath.row].itemDescription == nil {
            return 90
        } else if menuLibrary.tapiocaExpressMenu[indexPath.row].itemDescription != nil {
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
