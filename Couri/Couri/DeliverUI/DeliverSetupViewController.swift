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
    
    let deliveryMinusButton: UIButton = {
        let button = UIButton()
        button.setTitle("—", for: .normal)
        button.setTitleColor(UIColor(named: "honeyYellow"), for: .normal)
        button.titleLabel?.font = UIFont(name: "AvenirNext-Regular", size: 30)
        button.layer.borderColor = UIColor(named: "honeyYellow")?.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 25
        return button
    }()
    
    let deliveryPlusButton: UIButton = {
        let button = UIButton()
        button.setTitle("—", for: .normal)
        button.setTitleColor(UIColor(named: "honeyYellow"), for: .normal)
        button.titleLabel?.font = UIFont(name: "AvenirNext-Regular", size: 30)
        button.layer.borderColor = UIColor(named: "honeyYellow")?.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 25
        return button
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        selectedRestaurantsView.restaurantArray = self.restaurants
        setupViews()
    }
    
    @objc func backTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    func setupViews() {
        let guide = view.safeAreaLayoutGuide
        
        view.backgroundColor = UIColor(named: "darkMode")
        view.addSubview(hamburgerButton)
        view.addSubview(selectedRestaurantsView)
        view.addSubview(backwardsButton)
        view.addSubview(contentView)
        
        contentView.addSubview(nextButton)
        contentView.addSubview(durationLabel)
        contentView.addSubview(durationDescriptionLabel)
        contentView.addSubview(deliveryLabel)
        contentView.addSubview(deliveryDescriptionLabel)
        contentView.addSubview(deliveryMinusButton)
        contentView.addSubview(deliveryPlusButton)
        
        backwardsButton.addTarget(self, action: #selector(backTapped), for: .touchUpInside)
        
        NSLayoutConstraint.useAndActivateConstraints(constraints: [
            hamburgerButton.topAnchor.constraint(equalTo: guide.topAnchor, constant: 10),
            hamburgerButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            
            selectedRestaurantsView.topAnchor.constraint(equalTo: hamburgerButton.bottomAnchor, constant: 10),
            selectedRestaurantsView.heightAnchor.constraint(equalToConstant: 140),
            selectedRestaurantsView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
            selectedRestaurantsView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10),
            
            backwardsButton.topAnchor.constraint(equalTo: selectedRestaurantsView.bottomAnchor, constant: 10),
            backwardsButton.leftAnchor.constraint(equalTo: guide.leftAnchor, constant: 10),
            backwardsButton.widthAnchor.constraint(equalToConstant: 60),
            backwardsButton.heightAnchor.constraint(equalToConstant: 30),
            
            contentView.topAnchor.constraint(equalTo: backwardsButton.bottomAnchor, constant: 10),
            contentView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
            contentView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10),
            contentView.bottomAnchor.constraint(equalTo: guide.bottomAnchor),
            
            durationLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            durationLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            
            durationDescriptionLabel.topAnchor.constraint(equalTo: durationLabel.bottomAnchor),
            durationDescriptionLabel.leadingAnchor.constraint(equalTo: durationLabel.leadingAnchor),
            durationDescriptionLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10),
            
            deliveryMinusButton.heightAnchor.constraint(equalToConstant: 50),
            deliveryMinusButton.widthAnchor.constraint(equalToConstant: 50),
            deliveryMinusButton.topAnchor.constraint(equalTo: durationDescriptionLabel.bottomAnchor, constant: 20),
            deliveryMinusButton.leadingAnchor.constraint(equalTo: durationLabel.leadingAnchor),
            
            deliveryLabel.topAnchor.constraint(equalTo: deliveryMinusButton.bottomAnchor, constant: 20),
            deliveryLabel.leadingAnchor.constraint(equalTo: durationLabel.leadingAnchor),
            
            deliveryDescriptionLabel.topAnchor.constraint(equalTo: deliveryLabel.bottomAnchor),
            deliveryDescriptionLabel.leadingAnchor.constraint(equalTo: durationLabel.leadingAnchor),
            deliveryDescriptionLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10),
            
            nextButton.heightAnchor.constraint(equalToConstant: 80),
            nextButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            nextButton.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            nextButton.rightAnchor.constraint(equalTo: contentView.rightAnchor)
            ])
    }
}
