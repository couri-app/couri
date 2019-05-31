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
    private var isOn = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func down(_ sender: UIButton) {
        if isOn {
            UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.5, options: [], animations: {
                self.button.transform = CGAffineTransform(translationX: 0, y: 90)
            })
            view.backgroundColor = UIColor(named: "darkMode")
            isOn = !isOn
        } else {
            UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.5, options: [], animations: {
                self.button.transform = CGAffineTransform(translationX: 0, y: 0)
            })
            view.backgroundColor = UIColor.white
            isOn = !isOn
        }
    }


}

