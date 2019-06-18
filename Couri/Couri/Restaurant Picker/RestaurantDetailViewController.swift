//
//  RestaurantDetailViewController.swift
//  Couri
//
//  Created by David Chen on 6/18/19.
//  Copyright © 2019 Couri. All rights reserved.
//

import UIKit

class RestaurantDetailViewController: UIViewController {
    
    var restaurant: Restaurant?
    
    @IBOutlet weak var restaurantNameLabel: UILabel!
    @IBOutlet weak var backButton: UIButton!
    @IBAction func backTapped(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        restaurantNameLabel.text = restaurant?.restaurantName

    }
}
