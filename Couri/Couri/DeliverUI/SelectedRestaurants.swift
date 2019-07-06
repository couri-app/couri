//
//  SelectedRestaurants.swift
//  Couri
//
//  Created by David Chen on 7/5/19.
//  Copyright © 2019 Couri. All rights reserved.
//

import Foundation
import UIKit

class SelectedRestaurants: UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    let cellID = "DeliverCellID"
    var restaurantArray: [Restaurant]?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionHeadersPinToVisibleBounds = true
        layout.minimumLineSpacing = 0
        layout.estimatedItemSize = CGSize(width: 1, height: 1)
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return cv
    }()
    
    func setupViews() {
        collectionView.register(DeliveryRestaurantCell.self, forCellWithReuseIdentifier: cellID)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.allowsSelection = false
        collectionView.frame = self.frame
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return restaurantArray?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! DeliveryRestaurantCell
        let currentRestaurant = restaurantArray?[indexPath.row]
        cell.restaurant = currentRestaurant
        cell.isSelected = true
        
        return cell
    }
}
