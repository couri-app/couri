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
    
    // TEMPORARY backwards nav button
    let backwardsButton: UIButton = {
        let button = UIButton()
        button.frame.size = CGSize(width: 50, height: 50)
        button.setImage(UIImage(named: "backwards"), for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        print(restaurants!)
    }
    
    @objc func backTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    func setupViews() {
        let guide = view.safeAreaLayoutGuide
        
        view.backgroundColor = UIColor(named: "darkMode")
        view.addSubview(selectedRestaurantsView)
        view.addSubview(backwardsButton)
        
        selectedRestaurantsView.restaurantArray = self.restaurants
        
        backwardsButton.addTarget(self, action: #selector(backTapped), for: .touchUpInside)
        
        NSLayoutConstraint.useAndActivateConstraints(constraints: [
            backwardsButton.topAnchor.constraint(equalTo: guide.topAnchor),
            backwardsButton.leftAnchor.constraint(equalTo: guide.leftAnchor, constant: 10),
            
            selectedRestaurantsView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            selectedRestaurantsView.heightAnchor.constraint(equalToConstant: 300),
            selectedRestaurantsView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            selectedRestaurantsView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20)
            ])
    }
}
