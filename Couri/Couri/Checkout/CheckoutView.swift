//
//  CheckoutView.swift
//  Couri
//
//  Created by David Chen on 6/30/19.
//  Copyright © 2019 Couri. All rights reserved.
//

import Foundation
import UIKit

protocol CheckoutDelegate: class {
    func goToCheckout()
}

class CheckoutView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    weak var delegate: CheckoutDelegate?
    
    let checkoutView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.clear
        return cv
    }()
    
    let view: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.frame = CGRect(x: 10, y: 10, width: 300, height: 50)
        return view
    }()
    
    let checkoutButton: UIButton = {
        let button = UIButton()
        button.setTitle("View Cart", for: .normal)
        button.backgroundColor = UIColor(named: "honeyYellow")
        button.setTitleColor(UIColor.black, for: .normal)
        button.titleLabel?.font = UIFont(name: "AvenirNext-Medium", size: 16)
        button.layer.cornerRadius = 10
        return button
    }()
    
    func show() {
        if let window = UIApplication.shared.keyWindow {
            window.addSubview(checkoutView)
            
            let height: CGFloat = 70
            let yOrigin = window.frame.height - height
            
            checkoutView.frame = CGRect(x: 0, y: yOrigin, width: window.frame.width, height: height)
            
            checkoutView.addSubview(checkoutButton)
            checkoutButton.addTarget(self, action: #selector(hide), for: .touchUpInside)
            
            NSLayoutConstraint.useAndActivateConstraints(constraints: [
                checkoutButton.topAnchor.constraint(equalTo: checkoutView.topAnchor),
                checkoutButton.leftAnchor.constraint(equalTo: window.leftAnchor, constant: 20),
                checkoutButton.rightAnchor.constraint(equalTo: window.rightAnchor, constant: -20),
                checkoutButton.heightAnchor.constraint(equalToConstant: 50)
                ])
        }
    }
    
    @objc func hide() {
        delegate?.goToCheckout()
        if let window = UIApplication.shared.keyWindow {
            checkoutView.removeFromSuperview()
            self.checkoutView.frame = CGRect(x: 0, y: window.frame.height, width: self.checkoutView.frame.width, height: self.checkoutView.frame.height)
        }
    }
}
