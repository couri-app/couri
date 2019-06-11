//
//  ViewController.swift
//  Couri Tests
//
//  Created by David Chen on 6/7/19.
//  Copyright © 2019 David Chen. All rights reserved.
//

import UIKit

// Unique class for the restaurant cell in the tableview
class RestaurantCell: UITableViewCell {
    @IBOutlet weak var restaurantView: RestaurantView!
}

class RestaurantUIViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    weak var tableView: UITableView!
    var restaurantLibrary = RestaurantLibrary()
    
    // Outlet connections for our UIView
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var backButton: UIButton!
    @IBAction func backPage(_ sender: Any) {
        navigationController?.popToRootViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.numberOfLines = 0
        
        // Necessary additions to set up the tableView
        func setupTableView() {
            
            //IMPORTANT: registering tableview and adding Reuse Identifier
            tableView.register(RestaurantCell.self, forCellReuseIdentifier: "RestaurantCell")
            
            //Aesthetics
            addShadowToButton(button: backButton, opacity: 0.1, radius: 8)
            tableView.backgroundView = nil
            tableView.backgroundColor = #colorLiteral(red: 1, green: 0.8901960784, blue: 0.5490196078, alpha: 1)
        }
    }
}


extension RestaurantUIViewController {
    
    // Must have the below two functions. The first one returns and sets the number of rows in the tableview, and the second adds content to your cell in order of how they're indexed in the library
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return restaurantLibrary.restaurants.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RestaurantCell", for: indexPath) as! RestaurantCell
        let currentRestaurant = restaurantLibrary.restaurants[indexPath.row]
        cell.restaurantView.restaurant = currentRestaurant
        cell.layer.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
        
        return cell
    }
    
    // Simply sets the height of each cell
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 400
    }
    
    // Aesthetic function for adding shadows to buttons
    func addShadowToButton(button: UIButton, opacity: Double, radius: Int) {
        button.layer.shadowRadius = CGFloat(radius)
        button.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        button.layer.shadowOffset = CGSize(width: 0, height: 0)
        button.layer.shadowOpacity = Float(CGFloat(opacity))
    }
}
