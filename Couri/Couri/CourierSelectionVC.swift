//
//  CourierSelectionVC.swift
//  Couri
//
//  Created by David Chen on 6/10/19.
//  Copyright © 2019 Couri. All rights reserved.
//

import UIKit

// Unique class for courier selection cell in tableview
class CourierCell: UITableViewCell {
    @IBOutlet weak var courierView: CourierView!
}

class CourierSelectionViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.numberOfLines = 0
        //Aesthetics
        addShadowToViews(views: [restaurantCircle, orderCircle, registerCircle, courierCircle, fillerView, outerView], opacity: 0.1, radius: 8)
        courierTable.layer.cornerRadius = 20
        addRadiusView(views: [restaurantCircle, orderCircle, registerCircle, courierCircle], circle: true, radius: 0)
        addRadiusView(views: [fillerView, outerView], circle: false, radius: 20)
        addShadowTableview(views: [courierTable], opacity: 0.1, radius: 10)
        
        func setupTableView() {
            //IMPORTANT: registering tableview and adding Reuse Identifier
            tableView.register(CourierCell.self, forCellReuseIdentifier: "CourierCell")
        }
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var restaurantCircle: UIView!
    @IBOutlet weak var orderCircle: UIView!
    @IBOutlet weak var registerCircle: UIView!
    @IBOutlet weak var courierCircle: UIView!
    @IBOutlet weak var fillerView: UIView!
    @IBOutlet weak var courierTable: UITableView!
    @IBOutlet weak var outerView: UIView!
    
    weak var tableView: UITableView!
    var courierLibrary = CourierLibrary()
    
}

extension CourierSelectionViewController {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return courierLibrary.couriers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CourierCell", for: indexPath) as! CourierCell
        let currentCourier = courierLibrary.couriers[indexPath.row]
        cell.courierView.courier = currentCourier
        cell.layer.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    // Aesthetic function for adding shadows to buttons
    func addShadowToButton(button: UIButton, opacity: Double, radius: Int) {
        button.layer.shadowRadius = CGFloat(radius)
        button.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        button.layer.shadowOffset = CGSize(width: 0, height: 0)
        button.layer.shadowOpacity = Float(CGFloat(opacity))
    }
    
    // Aesthetic function for adding shadows to views
    func addShadowToViews(views: [UIView], opacity: Double, radius: Int) {
        for item in views {
            item.layer.shadowRadius = CGFloat(radius)
            item.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            item.layer.shadowOffset = CGSize(width: 0, height: 0)
            item.layer.shadowOpacity = Float(CGFloat(opacity))
        }
    }
    
    // Aesthetic function for adding shadows to table views
    func addShadowTableview(views: [UITableView], opacity: Double, radius: Int) {
        for item in views {
            item.layer.shadowRadius = CGFloat(radius)
            item.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            item.layer.shadowOffset = CGSize(width: 0, height: 0)
            item.layer.shadowOpacity = Float(CGFloat(opacity))
        }
    }
    
    // Rather complicated method to make round corners
    func addRadiusView(views: [UIView], circle: Bool, radius: Int) {
        for item in views {
            if circle == true {
                item.layer.cornerRadius = item.frame.width/2
            } else {
                item.layer.cornerRadius = CGFloat(radius)
            }
        }
    }
}
