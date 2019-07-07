//
//  DeliverSetupViewController.swift
//  Couri
//
//  Created by David Chen on 7/5/19.
//  Copyright © 2019 Couri. All rights reserved.
//

import UIKit

class DeliverSetupViewController: UIViewController {

    let selectedRestaurantsView = SelectedRestaurants()
    var restaurants: [Restaurant]?
    var minutesCount = 30
    var deliveriesCount = 1
    
    let hamburgerButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "hamburgerMenu"), for: .normal)
        button.frame.size = CGSize(width: 50, height: 50)
        return button
    }()
    
    let backwardsButton: UIButton = {
        let button = UIButton()
        button.setTitle("Back", for: .normal)
        button.layer.borderColor = UIColor(named: "honeyYellow")?.cgColor
        button.layer.borderWidth = 1
        button.backgroundColor = UIColor(named: "darkMode")
        button.setTitleColor(UIColor(named: "honeyYellow"), for: .normal)
        button.titleLabel?.font = UIFont(name: "AvenirNext-Regular", size: 16)
        button.layer.cornerRadius = 15
        return button
    }()
    
    let nextButton: UIButton = {
        let button = UIButton()
        button.setTitle("Next", for: .normal)
        button.layer.borderWidth = 1
        button.backgroundColor = UIColor(named: "honeyYellow")
        button.setTitleColor(UIColor(named: "darkMode"), for: .normal)
        button.titleLabel?.font = UIFont(name: "AvenirNext-Demibold", size: 25)
        button.layer.cornerRadius = 20
        button.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        return button
    }()
    
    let contentView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "darkMode")
        view.layer.cornerRadius = 20
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.4
        view.layer.shadowOffset = CGSize(width: 0, height: 0)
        view.layer.shadowRadius = 10
        return view
    }()
    
    let durationLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AvenirNext-Demibold", size: 25)
        label.textColor = UIColor.white
        label.text = "DURATION"
        return label
    }()
    
    let durationDescriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AvenirNext-Regular", size: 16)
        label.textColor = UIColor.white
        label.numberOfLines = 0
        label.text = "How long will you be staying near these restaurants?"
        label.numberOfLines = 2
        return label
    }()
    
    let durationMinusButton: UIButton = {
        let button = UIButton()
        button.setTitle("—", for: .normal)
        button.setTitleColor(UIColor(named: "honeyYellow"), for: .normal)
        button.titleLabel?.font = UIFont(name: "AvenirNext-Regular", size: 30)
        button.layer.borderColor = UIColor(named: "honeyYellow")?.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 20
        return button
    }()
    
    let durationPlusButton: UIButton = {
        let button = UIButton()
        button.setTitle("+", for: .normal)
        button.setTitleColor(UIColor(named: "honeyYellow"), for: .normal)
        button.titleLabel?.font = UIFont(name: "AvenirNext-Regular", size: 30)
        button.layer.borderColor = UIColor(named: "honeyYellow")?.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 20
        return button
    }()
    
    let minuteCountLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AvenirNext-Demibold", size: 30)
        label.textColor = UIColor.white
        return label
    }()
    
    let minutesLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AvenirNext-Regular", size: 20)
        label.textColor = UIColor.white
        label.text = "minutes"
        return label
    }()
    
    let deliveryLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AvenirNext-Demibold", size: 25)
        label.textColor = UIColor.white
        label.text = "NUMBER OF DELIVERIES"
        return label
    }()
    
    let deliveryDescriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AvenirNext-Regular", size: 16)
        label.textColor = UIColor.white
        label.numberOfLines = 0
        label.text = "Choose how many deliveries you'd like to make."
        label.numberOfLines = 2
        return label
    }()
    
    let deliveryMinusButton: UIButton = {
        let button = UIButton()
        button.setTitle("—", for: .normal)
        button.setTitleColor(UIColor(named: "honeyYellow"), for: .normal)
        button.titleLabel?.font = UIFont(name: "AvenirNext-Regular", size: 30)
        button.layer.borderColor = UIColor(named: "honeyYellow")?.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 20
        return button
    }()
    
    let deliveryPlusButton: UIButton = {
        let button = UIButton()
        button.setTitle("+", for: .normal)
        button.setTitleColor(UIColor(named: "honeyYellow"), for: .normal)
        button.titleLabel?.font = UIFont(name: "AvenirNext-Regular", size: 30)
        button.layer.borderColor = UIColor(named: "honeyYellow")?.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 20
        return button
    }()
    
    let deliveryCountLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AvenirNext-Demibold", size: 30)
        label.textColor = UIColor.white
        return label
    }()
    
    let deliveriesLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AvenirNext-Regular", size: 20)
        label.textColor = UIColor.white
        label.text = "deliveries"
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        selectedRestaurantsView.restaurantArray = self.restaurants
        setupViews()
    }
    
    @objc func backTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func forwardTapped() {
        performSegue(withIdentifier: "toDeliveryAddress", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? DeliveryAddressViewController {
            destination.restaurants = self.restaurants
        }
    }
}
