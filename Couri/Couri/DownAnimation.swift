//
//  DownAnimation.swift
//  Couri
//
//  Created by Jai Bansal on 5/31/19.
//  Copyright © 2019 Couri. All rights reserved.
//

import UIKit

extension UIButton {
    
    @objc func down() {
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: [], animations: {
                self.transform = CGAffineTransform(translationX: 0, y: 105)
        })
    }
}
