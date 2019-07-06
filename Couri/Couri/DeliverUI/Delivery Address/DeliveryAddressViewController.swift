//
//  DeliveryAddressViewController.swift
//  Couri
//
//  Created by David Chen on 7/6/19.
//  Copyright © 2019 Couri. All rights reserved.
//

import UIKit

class DeliveryAddressViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
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
    
    func setupViews() {
        
    }
}
