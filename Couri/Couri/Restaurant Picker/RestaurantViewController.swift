//
//  ViewController.swift
//  Couri Tests
//
//  Created by David Chen on 6/7/19.
//  Copyright © 2019 David Chen. All rights reserved.
//

import UIKit

// Unique class for the restaurant cell in the tableview

class RestaurantUIViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
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
        addShadowToButton(button: backButton, opacity: 0.1, radius: 8)
        tableView.register(RestaurantDisplay.self, forCellReuseIdentifier: "restaurantdisplay")
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension RestaurantUIViewController {
    // Must have the below two functions. The first one returns and sets the number of rows in the tableview, and the second adds content to your cell in order of how they're indexed in the library
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return restaurantLibrary.restaurants.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "restaurantdisplay", for: indexPath) as! RestaurantDisplay
        let currentRestaurant = restaurantLibrary.restaurants[indexPath.row]
        cell.restaurant = currentRestaurant
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "ShowRestaurantDetail", sender: self)
    }
    
    // Simply sets the height of each cell
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 350
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? RestaurantDetailViewController {
            destination.restaurant = restaurantLibrary.restaurants[(tableView.indexPathForSelectedRow?.row)!]
        }
    }
    
    // Aesthetic function for adding shadows to buttons
    func addShadowToButton(button: UIButton, opacity: Double, radius: Int) {
        button.layer.shadowRadius = CGFloat(radius)
        button.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        button.layer.shadowOffset = CGSize(width: 0, height: 0)
        button.layer.shadowOpacity = Float(CGFloat(opacity))
    }
}
