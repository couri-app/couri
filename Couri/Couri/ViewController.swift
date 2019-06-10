//
//  ViewController.swift
//  Couri
//
//  Created by Jai Bansal on 5/28/19.
//  Copyright © 2019 Couri. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    weak var tableView: UITableView!
    
    var restaurantLibrary = RestaurantLibrary()
    
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 350
    }
    

    //Top layer buttons
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var shopView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var balanceLabel: UILabel!
    
    //Breadcrumb trail outlets
    @IBOutlet weak var restaurantBreadcrumb: UIView!
    @IBOutlet weak var orderBreadcrumb: UIView!
    @IBOutlet weak var registerBreadcrumb: UIView!
    @IBOutlet weak var courierBreadcrumb: UIView!
    
    //Restaurant UIView containing Restaurant Table View
    @IBOutlet weak var restaurantUIView: UIView!
    @IBOutlet weak var restaurantLabel: UILabel!
    @IBAction func nextPage(_ sender: UIButton) {
        performSegue(withIdentifier: "<#T##String#>", sender: <#T##Any?#>)
    }
    
    public var isOn = false
    
    //Created a function that adds shadows the UIViews for my own ease of use
    func addShadowToView(view: UIView, opacity: Double, radius: Int) {
        view.layer.shadowRadius = CGFloat(radius)
        view.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        view.layer.shadowOffset = CGSize(width: 0, height: 0)
        view.layer.shadowOpacity = Float(CGFloat(opacity))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Button to expaned Restaurant View
        
        //Restaurant UIView Aesthetics
        restaurantUIView.layer.cornerRadius = 20
        addShadowToView(view: restaurantUIView, opacity: 0.1, radius: 10)
        restaurantLabel.numberOfLines = 0
        
        //Breadcrumb trail images (giving all of them a shadow)
        addShadowToView(view: restaurantBreadcrumb, opacity: 0.1, radius: 8)
        addShadowToView(view: orderBreadcrumb, opacity: 0.1, radius: 8)
        addShadowToView(view: registerBreadcrumb, opacity: 0.1, radius: 8)
        addShadowToView(view: courierBreadcrumb, opacity: 0.1, radius: 8)
        
        //Breadcrumb trail images (giving all of them a circular frame)
        let breadcrumbArray = [restaurantBreadcrumb, orderBreadcrumb, registerBreadcrumb, courierBreadcrumb]
        for view in breadcrumbArray {
            view?.layer.cornerRadius = (view?.frame.width)!/2
        }

        
        //Aesthetic settings upon start for various buttons
        button.layer.shadowColor = #colorLiteral(red: 0.07881314767, green: 0.07881314767, blue: 0.07881314767, alpha: 1)
        button.layer.shadowRadius = 3
        button.layer.shadowOpacity = 0.1
        button.layer.shadowOffset = CGSize(width: 0, height: 0)
        
        //Aesthetics for shop upon initialization
        shopView.layer.cornerRadius = 20
        addShadowToView(view: shopView, opacity: 0.1, radius: 10)
        descriptionLabel.text = "Enjoy deliveries from nearby Couriers"
        descriptionLabel.font = UIFont(name: "AvenirNext-medium", size: 16)
        
        //Aesthetics for balance label
        balanceLabel.font = UIFont(name: "AvenirNext-medium", size: 16)
        balanceLabel.layer.backgroundColor = #colorLiteral(red: 1, green: 0.8901960784, blue: 0.5490196078, alpha: 1)
        balanceLabel.layer.cornerRadius = 4
        
    }
    
    
    @IBAction func down(_ sender: UIButton) {
        if isOn {
            UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 3, initialSpringVelocity: 1, options: [], animations: {
                self.button.transform = CGAffineTransform(translationX: 0, y: 90)
            })
            view.backgroundColor = #colorLiteral(red: 0.1764705882, green: 0.1921568627, blue: 0.2549019608, alpha: 1)
            titleLabel.text = "DELIVER"
            titleLabel.textColor = #colorLiteral(red: 1, green: 0.8901960784, blue: 0.5490196078, alpha: 1)
            shopView.backgroundColor = #colorLiteral(red: 0.1764705882, green: 0.1921568627, blue: 0.2549019608, alpha: 1)
            descriptionLabel.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            descriptionLabel.text = "Deliver to your dankest friends"
            shopView.layer.shadowOpacity = 0.3
            isOn = !isOn
        } else {
            UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 3, initialSpringVelocity: 1, options: [], animations: {
                self.button.transform = CGAffineTransform(translationX: 0, y: 0)
            })
            titleLabel.text = "SHOP"
            titleLabel.textColor = #colorLiteral(red: 0.07881314767, green: 0.07881314767, blue: 0.07881314767, alpha: 1)
            shopView.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            descriptionLabel.textColor = #colorLiteral(red: 0.07881314767, green: 0.07881314767, blue: 0.07881314767, alpha: 1)
            descriptionLabel.text = "Enjoy deliveries from nearby Couriers"
            shopView.layer.shadowOpacity = 0.1
            isOn = !isOn
        }
    }


}

