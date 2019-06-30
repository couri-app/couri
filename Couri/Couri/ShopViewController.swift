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
    
    override func viewDidLoad() {
        setupViews()
    }
    
    let restaurantBreadcrumb: UIView = {
        let view = UIView()
        view.frame.size = CGSize(width: 50, height: 10)
        view.backgroundColor = UIColor(named: "honeyYellow")
        return view
    }()
    
    let orderBreadcrumb: UIView = {
        let view = UIView()
        view.frame.size = CGSize(width: 50, height: 10)
        view.backgroundColor = UIColor(named: "honeyYellow")
        return view
    }()
    
    let checkoutBreadcrumb: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "honeyYellow")
        view.frame.size = CGSize(width: 50, height: 10)
        return view
    }()
    
    let courierBreadcrumb: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "honeyYellow")
        view.frame.size = CGSize(width: 50, height: 10)
        return view
    }()
    
    let contentView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.layer.cornerRadius = 20
        return view
    }()
    
    let restaurantsTableView = UITableView()
    
    let breadcrumbStackView = UIStackView()
    
    func addShadowToView(view: UIView, opacity: Double, radius: Int) {
        view.layer.shadowRadius = CGFloat(radius)
        view.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        view.layer.shadowOffset = CGSize(width: 0, height: 0)
        view.layer.shadowOpacity = Float(CGFloat(opacity))
    }
    
    func setupViews() {
        view.backgroundColor = UIColor.white
        view.addSubview(breadcrumbStackView)
        view.addSubview(contentView)
        view.addSubview(restaurantsTableView)
        
        addShadowToView(view: contentView, opacity: 0.1, radius: 10)
        
        restaurantsTableView.register(RestaurantDisplay.self, forCellReuseIdentifier: "restaurantdisplay")
        restaurantsTableView.dataSource = self
        restaurantsTableView.delegate = self
        
        breadcrumbStackView.axis = .horizontal
        breadcrumbStackView.distribution = .equalSpacing
        breadcrumbStackView.isLayoutMarginsRelativeArrangement = true
        
        breadcrumbStackView.addArrangedSubview(restaurantBreadcrumb)
        breadcrumbStackView.addArrangedSubview(orderBreadcrumb)
        breadcrumbStackView.addArrangedSubview(checkoutBreadcrumb)
        breadcrumbStackView.addArrangedSubview(courierBreadcrumb)
        
        NSLayoutConstraint.useAndActivateConstraints(constraints: [
            contentView.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            contentView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
            contentView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10),
            contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            breadcrumbStackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 30),
            breadcrumbStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            breadcrumbStackView.widthAnchor.constraint(equalToConstant: view.frame.width),
            
            restaurantsTableView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 50),
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
