//
//  ShopViewController.swift
//  Couri
//
//  Created by David Chen on 6/28/19.
//  Copyright © 2019 Couri. All rights reserved.
//

import UIKit

protocol RestaurantSegueDelegate: class {
    func segue(index: Int)
}

class ShopViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var restaurantLibrary = RestaurantLibrary()
    weak var restaurantSegueDelegate: RestaurantSegueDelegate?
    var userAddress = String()
    
    override func viewDidLoad() {
        setupDefaults()
        setupViews()
    }
    
    let contentView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.layer.cornerRadius = 20
        return view
    }()
    
    let restaurantsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AvenirNext-Bold", size: 25)
        label.text = "NEARBY RESTAURANTS"
        return label
    }()
    
    let restaurantStrip: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "honeyYellow")
        view.layer.cornerRadius = 1
        return view
    }()
    
    let deliveringToLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AvenirNext-Medium", size: 16)
        return label
    }()
    
    let restaurantsTableView = UITableView()
    
    func addShadowToView(view: UIView, opacity: Double, radius: Int) {
        view.layer.shadowRadius = CGFloat(radius)
        view.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        view.layer.shadowOffset = CGSize(width: 0, height: 0)
        view.layer.shadowOpacity = Float(CGFloat(opacity))
    }
    
    let defaults = UserDefaults.standard
    
    func setupDefaults() {
        let address = "2401 Durant, Room 613"
        defaults.set(address, forKey: "address")
    }
    
    func setupViews() {
        userAddress = defaults.object(forKey: "address") as? String ?? ""
        deliveringToLabel.text = "Delivering To: \(userAddress)"
        
        view.backgroundColor = UIColor.white
        view.addSubview(contentView)
        view.addSubview(restaurantsTableView)
        
        contentView.addSubview(restaurantsLabel)
        contentView.addSubview(restaurantStrip)
        contentView.addSubview(deliveringToLabel)
        
        addShadowToView(view: contentView, opacity: 0.1, radius: 10)
        
        restaurantsTableView.register(RestaurantDisplay.self, forCellReuseIdentifier: "restaurantdisplay")
        restaurantsTableView.dataSource = self
        restaurantsTableView.delegate = self
        
        NSLayoutConstraint.useAndActivateConstraints(constraints: [
            contentView.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
            contentView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
            contentView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10),
            contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            restaurantsLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            restaurantsLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10),
            
            restaurantStrip.topAnchor.constraint(equalTo: restaurantsLabel.bottomAnchor, constant: -3),
            restaurantStrip.heightAnchor.constraint(equalToConstant: 3),
            restaurantStrip.leadingAnchor.constraint(equalTo: restaurantsLabel.leadingAnchor),
            restaurantStrip.widthAnchor.constraint(equalToConstant: 200),
            
            deliveringToLabel.topAnchor.constraint(equalTo: restaurantStrip.bottomAnchor, constant: 10),
            deliveringToLabel.leadingAnchor.constraint(equalTo: restaurantsLabel.leadingAnchor),
            
            restaurantsTableView.topAnchor.constraint(equalTo: deliveringToLabel.bottomAnchor, constant: 10),
            restaurantsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            restaurantsTableView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10),
            restaurantsTableView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10),
            ])
    }
}

extension ShopViewController {
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
        print(indexPath)
        self.restaurantSegueDelegate?.segue(index: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 350
    }
}
