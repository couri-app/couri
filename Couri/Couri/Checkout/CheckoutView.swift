//
//  CheckoutView.swift
//  Couri
//
//  Created by David Chen on 6/30/19.
//  Copyright © 2019 Couri. All rights reserved.
//

import Foundation
import UIKit

class CheckoutView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    let view: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.white
        return cv
    }()
    
    let buttonView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.lightGray
        return view
    }()
    
    let noteTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = UIColor.lightGray
        textField.placeholder = "Leave a note for the kitchen"
        textField.font = UIFont(name: "AvenirNext-Regular", size: 16)
        textField.keyboardType = UIKeyboardType.default
        textField.returnKeyType = UIReturnKeyType.done
        textField.layer.cornerRadius = 4
        return textField
    }()
    
    func show() {
        if let window = UIApplication.shared.keyWindow {
            window.addSubview(view)
            
            let height: CGFloat = 70
            let yOrigin = window.frame.height - height
            
            view.frame = CGRect(x: 0, y: yOrigin, width: window.frame.width, height: height)
        }
        
        view.addSubview(buttonView)
        
        NSLayoutConstraint.useAndActivateConstraints(constraints: [
            buttonView.topAnchor.constraint(equalTo: view.topAnchor),
            buttonView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            buttonView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            buttonView.heightAnchor.constraint(equalToConstant: 100)
            ])
    }
    
    func hide() {
        if let window = UIApplication.shared.keyWindow {
            view.removeFromSuperview()
            self.view.frame = CGRect(x: 0, y: window.frame.height, width: self.view.frame.width, height: self.view.frame.height)
        }
    }
}
