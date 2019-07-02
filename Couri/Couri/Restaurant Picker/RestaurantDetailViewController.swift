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
    var categoryCellSelected = 0
    
    @IBOutlet weak var restaurantNameLabel: UILabel!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var restaurantImage: UIImageView!
    @IBOutlet weak var restaurantCategories: UILabel!
    @IBOutlet weak var menuCategoryCV: UICollectionView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var masterTableView: SelfSizedTableView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet var contentView: UIView!
    
    @IBAction func backTapped(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func unwindSegueToRestaurant(segue: UIStoryboardSegue) {}

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupTableView()
        setupCV()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        menuCategoryCV.selectItem(at: IndexPath(row: categoryCellSelected, section: 0), animated: false, scrollPosition: [])
    }
    
    // MARK: Setup Category CollectionView
    func setupCV() {
        menuCategoryCV.translatesAutoresizingMaskIntoConstraints = false
        menuCategoryCV.dataSource = self
        menuCategoryCV.delegate = self
        menuCategoryCV.register(CategoryCell.self, forCellWithReuseIdentifier: cellID)
        
        //Layout things. Sets margins
        let collectionViewLayout = menuCategoryCV.collectionViewLayout as? UICollectionViewFlowLayout
        collectionViewLayout?.sectionInset = UIEdgeInsets(top: 0, left: 19, bottom: 0, right: 19)
        collectionViewLayout?.invalidateLayout()
    }
    
    func setupViews() {
        restaurantNameLabel.text = restaurant?.restaurantName
        restaurantImage.image = restaurant?.imageName
        restaurantCategories.text = restaurant?.categoryDescription
        restaurantCategories.numberOfLines = 0
        
        //Aesthetics
        containerView.layer.cornerRadius = 20
        addShadowObject(object: containerView)
        addShadowButton(button: backButton)
        restaurantImage.layer.cornerRadius = 10
        restaurantImage.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        addGradientLayerInForeground(frame: restaurantImage.frame, colors: [UIColor.white.withAlphaComponent(0), UIColor.white])
    }
    
    func setupTableView() {
        masterTableView.isScrollEnabled = false
        masterTableView.maxHeight = view.frame.height
        masterTableView.alwaysBounceVertical = false
        masterTableView.register(MenuItemCell.self, forCellReuseIdentifier: "menuCell")
        masterTableView.rowHeight = UITableView.automaticDimension
        masterTableView.estimatedRowHeight = 100
        masterTableView.delegate = self
        masterTableView.dataSource = self
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
        
        // Sets label text and images for each category
        cell.categoryLabel.text = restaurant?.categories[indexPath.row]
        if UIImage(named: (restaurant?.categories[indexPath.row])!) != nil {
            cell.buttonView.image = UIImage(named: (restaurant?.categories[indexPath.row])!)
        }

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        categoryCellSelected = indexPath.item
        masterTableView.reloadData()
    }

    func addGradientLayerInForeground(frame: CGRect, colors:[UIColor]) {
        let gradient = CAGradientLayer()
        gradient.frame = frame
        gradient.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradient.endPoint = CGPoint(x: 0.0, y: 1.0)
        gradient.colors = colors.map{$0.cgColor}
        restaurantImage.layer.addSublayer(gradient)
    }
    
    func addShadowObject(object: UIView) {
        object.layer.shadowRadius = 8
        object.layer.shadowColor = #colorLiteral(red: 0.07881314767, green: 0.07881314767, blue: 0.07881314767, alpha: 1)
        object.layer.shadowOffset = CGSize(width: 0, height: 0)
        object.layer.shadowOpacity = 0.3
        object.layer.shadowRadius = 6
    }
    
    func addShadowButton(button: UIButton) {
        button.layer.shadowRadius = 8
        button.layer.shadowColor = #colorLiteral(red: 0.07881314767, green: 0.07881314767, blue: 0.07881314767, alpha: 1)
        button.layer.shadowOffset = CGSize(width: 0, height: 0)
        button.layer.shadowOpacity = 0.2
        button.layer.shadowRadius = 10
    }
}

//MARK: Setup Menu TableView
extension RestaurantDetailViewController {
    // returns the number of menu items in category
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let currentCategory = restaurant?.categories[categoryCellSelected]
        if let currentItems = restaurant?.menuItems[currentCategory!] {
            let count = currentItems.count
            return count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = masterTableView.dequeueReusableCell(withIdentifier: "menuCell", for: indexPath) as! MenuItemCell
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        
        let currentCategory = restaurant?.categories[categoryCellSelected]
        let currentItem = restaurant?.menuItems[currentCategory!]?[indexPath.row]
        
        cell.item = currentItem
        return cell
    }
    
    // Different cell heights depending on whether or not there is an image and/or description
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? MenuDetailVC {
            let currentCategory = restaurant?.categories[categoryCellSelected]
            if let currentItems = restaurant?.menuItems[currentCategory!] {
                destination.item = currentItems[masterTableView.indexPathForSelectedRow!.row]
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "orderDetail", sender: self)
    }
}

// This allows the UITableView to stretch to the complete length of its contents. Scrolling is disabled for this page's TableView.
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
