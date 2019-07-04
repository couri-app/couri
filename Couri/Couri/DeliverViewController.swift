//
//  DeliverViewController.swift
//  Couri
//
//  Created by David Chen on 6/28/19.
//  Copyright © 2019 Couri. All rights reserved.
//

import UIKit

class DeliverViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    let restaurantLibrary = RestaurantLibrary()
    let cellID = "DeliverCellID"
    
    override func viewDidLoad() {
        setupViews()
    }
    
    let restaurantCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 10
        layout.estimatedItemSize = CGSize(width: 1, height: 1)
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor(named: "darkMode")
        return cv
    }()
    
    let contentView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "darkMode")
        view.layer.cornerRadius = 20
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AvenirNext-Demibold", size: 25)
        label.textColor = UIColor.white
        label.text = "DELIVER FROM"
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AvenirNext-Regular", size: 16)
        label.textColor = UIColor.white
        label.numberOfLines = 0
        label.text = "Choose up to three restaurants you’re able to deliver from."
        return label
    }()
    
    func addShadowToView(view: UIView, opacity: Double, radius: Int) {
        view.layer.shadowRadius = CGFloat(radius)
        view.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        view.layer.shadowOffset = CGSize(width: 0, height: 0)
        view.layer.shadowOpacity = Float(CGFloat(opacity))
    }
    
    func setupViews() {
        view.backgroundColor = UIColor(named: "darkMode")
        
        view.addSubview(contentView)
        view.addSubview(restaurantCollectionView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionLabel)
        
        restaurantCollectionView.register(DeliveryRestaurantCell.self, forCellWithReuseIdentifier: cellID)
        restaurantCollectionView.delegate = self
        restaurantCollectionView.dataSource = self
        restaurantCollectionView.allowsMultipleSelection = true
        
        addShadowToView(view: contentView, opacity: 0.4, radius: 10)
        
        NSLayoutConstraint.useAndActivateConstraints(constraints: [
            contentView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            contentView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
            contentView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10),
            contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            restaurantCollectionView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 10),
            restaurantCollectionView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10),
            restaurantCollectionView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10),
            restaurantCollectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: restaurantCollectionView.leadingAnchor),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            descriptionLabel.leadingAnchor.constraint(equalTo: restaurantCollectionView.leadingAnchor),
            descriptionLabel.rightAnchor.constraint(equalTo: restaurantCollectionView.rightAnchor, constant: -10)
            ])
    }
}

extension DeliverViewController {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return restaurantLibrary.restaurants.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 60)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! DeliveryRestaurantCell
        let currentRestaurant = restaurantLibrary.restaurants[indexPath.row]
        cell.restaurant = currentRestaurant
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectionFeedbackGenerator = UISelectionFeedbackGenerator()
        selectionFeedbackGenerator.selectionChanged()
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let selectionFeedbackGenerator = UISelectionFeedbackGenerator()
        selectionFeedbackGenerator.selectionChanged()
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        if restaurantCollectionView.indexPathsForSelectedItems?.count ?? 0 < 3 {
            return true
        } else {
            return false
        }
    }
}
