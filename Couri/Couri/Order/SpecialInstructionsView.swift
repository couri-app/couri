//
//  SpecialInstructionsView.swift
//  Couri
//
//  Created by David Chen on 6/28/19.
//  Copyright © 2019 Couri. All rights reserved.
//

import Foundation
import UIKit

class SpecialInstructionsView: UIView, UITextFieldDelegate {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    let specialInstructionsView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.white
        return cv
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
    
    let blackView = UIView()
    
    func showSidebar() {
        if let window = UIApplication.shared.keyWindow {
            blackView.backgroundColor = UIColor.init(white: 0, alpha: 0.5)
            
            window.addSubview(blackView)
            window.addSubview(specialInstructionsView)
            
            let height: CGFloat = 200
            let yOrigin = window.frame.height - height
            
            specialInstructionsView.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: height)
            
            blackView.frame = window.frame
            blackView.alpha = 0
            blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismiss)))
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.blackView.alpha = 1
                self.specialInstructionsView.frame = CGRect(x: 0, y: yOrigin, width: self.specialInstructionsView.frame.width, height: self.specialInstructionsView.frame.height)
            }, completion: nil)
        }
        
        specialInstructionsView.addSubview(noteTextField)
        noteTextField.delegate = self
        
        NSLayoutConstraint.useAndActivateConstraints(constraints: [
            noteTextField.topAnchor.constraint(equalTo: specialInstructionsView.topAnchor),
            noteTextField.leftAnchor.constraint(equalTo: specialInstructionsView.leftAnchor, constant: 20),
            noteTextField.rightAnchor.constraint(equalTo: specialInstructionsView.rightAnchor, constant: -20),
            noteTextField.heightAnchor.constraint(equalToConstant: 100)
            ])
    }
    
    @objc func handleDismiss() {
        UIView.animate(withDuration: 0.3) {
            self.blackView.alpha = 0
            if let window = UIApplication.shared.keyWindow {
                self.specialInstructionsView.frame = CGRect(x: 0, y: window.frame.height, width: self.specialInstructionsView.frame.width, height: self.specialInstructionsView.frame.height)
            }
        }
    }
}
