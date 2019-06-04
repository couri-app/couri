//
//  ViewController.swift
//  Couri
//
//  Created by Jai Bansal on 5/28/19.
//  Copyright © 2019 Couri. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var shopView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var balanceLabel: UILabel!
    @IBOutlet weak var balanceView: UIView!
    private var isOn = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        button.layer.shadowColor = #colorLiteral(red: 0.07881314767, green: 0.07881314767, blue: 0.07881314767, alpha: 1)
        button.layer.shadowRadius = 3
        button.layer.shadowOpacity = 0.1
        button.layer.shadowOffset = CGSize(width: 0, height: 0)
        
        shopView.layer.cornerRadius = 21
        shopView.layer.shadowColor = #colorLiteral(red: 0.07881314767, green: 0.07881314767, blue: 0.07881314767, alpha: 1)
        shopView.layer.shadowRadius = 10
        shopView.layer.shadowOpacity = 0.1
        shopView.layer.shadowOffset = CGSize(width: 0, height: 0)
        descriptionLabel.text = "Enjoy deliveries from nearby Couriers"
        descriptionLabel.font = UIFont(name: "AvenirNext-medium", size: 16)
        descriptionLabel.textColor = #colorLiteral(red: 0.07881314767, green: 0.07881314767, blue: 0.07881314767, alpha: 1)
        balanceView.backgroundColor = #colorLiteral(red: 1, green: 0.8901960784, blue: 0.5490196078, alpha: 1)
        balanceView.layer.cornerRadius = 3
        balanceLabel.font = UIFont(name: "AvenirNext-medium", size: 16)
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

