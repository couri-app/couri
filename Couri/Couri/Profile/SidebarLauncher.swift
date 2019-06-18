//
//  SidebarLauncher.swift
//  Couri
//
//  Created by David Chen on 6/11/19.
//  Copyright © 2019 Couri. All rights reserved.
//

import Foundation
import UIKit

protocol TransferSelectionDelegate: class {
    func goToNextScene()
}

class SidebarLauncher: UIView {
    let sidebarContainerView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let sb = UICollectionView(frame: .zero, collectionViewLayout: layout)
        sb.backgroundColor = UIColor.white
        return sb
    }()
    
    @IBOutlet var sidebarView: UIScrollView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        Bundle.main.loadNibNamed("Scrollview", owner: self, options: nil)
        self.addSubview(sidebarView)
        
    }
    
    // Outlets
    @IBOutlet weak var profileButton: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var balanceLabel: UILabel!
    @IBOutlet weak var transferButton: UIButton!
    @IBOutlet weak var cardLabel: UILabel!
    @IBOutlet weak var editCardButton: UIButton!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var editAddressButton: UIButton!
    @IBOutlet weak var specialCell: UIView!
    @IBOutlet weak var courierRating: UILabel!
    @IBOutlet weak var deliveryCount: UILabel!
    
    // Connections
    weak var delegate: TransferSelectionDelegate?
    @IBAction func transferWasTapped(_ sender: UIButton) {
        delegate?.goToNextScene()
        handleDismiss()
    }
    
    let blackView = UIView()
    
    func showSidebar() {
        if let window = UIApplication.shared.keyWindow {
            let barWidth = window.frame.width * 3/4
            
            blackView.backgroundColor = UIColor.init(white: 0, alpha: 0.5)
            
            window.addSubview(blackView)
            window.addSubview(sidebarContainerView)
            sidebarContainerView.addSubview(sidebarView)
            
            sidebarContainerView.frame = CGRect(x: 0, y: 0, width: 0, height: window.frame.height)
            sidebarContainerView.layer.cornerRadius = 40
            sidebarContainerView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner]
            sidebarView.frame = CGRect(x: 0, y: 0, width: barWidth, height: window.frame.height)
            
            blackView.frame = window.frame
            blackView.alpha = 0
            blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismiss)))
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.blackView.alpha = 1
                self.sidebarContainerView.frame = CGRect(x: 0, y: 0, width: barWidth, height: self.sidebarContainerView.frame.height)
            }, completion: nil)
        }
        
        let user = UserInfo().userInfo
        profileButton.setImage(user.image, for: .normal)
        nameLabel.text = user.userFullName
        balanceLabel.text = "Balance: $\(user.userBalance)"
        addressLabel.text = "Address: \(user.userHomeAddress ?? "Address:")"
        courierRating.text = String(user.courierRating)
        deliveryCount.text = String(user.deliveryCount)
        
        //Aesthetics
        profileButton.layer.borderWidth = 8
        profileButton.layer.cornerRadius = profileButton.frame.width/2
        profileButton.layer.borderColor = #colorLiteral(red: 1, green: 0.8901960784, blue: 0.5490196078, alpha: 1)
        profileButton.layer.masksToBounds = true
        
        specialCell.layer.cornerRadius = 4
        specialCell.layer.borderWidth = 2
        specialCell.layer.borderColor = #colorLiteral(red: 1, green: 0.8901960784, blue: 0.5490196078, alpha: 1)
        addShadowObject(object: specialCell)
    }
    
    var transferSelectionDelegate: TransferSelectionDelegate!
    
    @objc func handleDismiss() {
        UIView.animate(withDuration: 0.3) {
            self.blackView.alpha = 0
            if UIApplication.shared.keyWindow != nil {
                self.sidebarContainerView.frame = CGRect(x: 0, y: 0, width: 0, height: self.sidebarContainerView.frame.height)
            }
        }
    }
    
    func addShadowObject(object: UIView) {
        object.layer.shadowRadius = 8
        object.layer.shadowColor = #colorLiteral(red: 0.07881314767, green: 0.07881314767, blue: 0.07881314767, alpha: 1)
        object.layer.shadowOffset = CGSize(width: 0, height: 0)
        object.layer.shadowOpacity = 0.3
        object.layer.shadowRadius = 4
    }
}

