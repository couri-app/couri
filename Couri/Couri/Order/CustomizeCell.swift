//
//  CustomizeCell.swift
//  Couri
//
//  Created by David Chen on 6/26/19.
//  Copyright © 2019 Couri. All rights reserved.
//

import Foundation
import UIKit

class CustomizeCell: UICollectionViewCell {
    
    var customizable: CustomizableOptions? {
        didSet {
            if customizable?.isSingleSelection == true {
                if isSelected {
                    selectionView.image = UIImage(named: "selectedCircle")
                    addedPriceLabel.textColor = #colorLiteral(red: 0.9131088853, green: 0.6618924141, blue: 0, alpha: 1)
                    titleLabel.textColor = #colorLiteral(red: 0.9131088853, green: 0.6618924141, blue: 0, alpha: 1)
                } else {
                    selectionView.image = UIImage(named: "deselectedCircle")
                    addedPriceLabel.textColor = UIColor.gray
                    titleLabel.textColor = UIColor.black
                }
                
            } else if customizable?.isSingleSelection == false {
                if isSelected {
                    addedPriceLabel.textColor = #colorLiteral(red: 0.9131088853, green: 0.6618924141, blue: 0, alpha: 1)
                    titleLabel.textColor = #colorLiteral(red: 0.9131088853, green: 0.6618924141, blue: 0, alpha: 1)
                    selectionView.image = UIImage(named: "selectedSquare")
                } else {
                    selectionView.image = UIImage(named: "deselectedSquare")
                    addedPriceLabel.textColor = UIColor.gray
                    titleLabel.textColor = UIColor.black
                }
            }
            
            titleLabel.text = customizable?.title
            
            if customizable?.addedPrice != nil {
                if let addedPrice = customizable?.addedPrice {
                    addedPriceLabel.text = "+$\(String(format: "%.2f", addedPrice))"
                }
            } else {
                addedPriceLabel.text = ""
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var isSelected: Bool {
        didSet {
            if customizable?.isSingleSelection == true {
                self.selectionView.image = isSelected ? UIImage(named: "selectedCircle") : UIImage(named: "deselectedCircle")
            } else {
                self.selectionView.image = isSelected ? UIImage(named: "selectedSquare") : UIImage(named: "deselectedSquare")
            }
            if customizable?.addedPrice != nil {
                self.addedPriceLabel.textColor = isSelected ? #colorLiteral(red: 0.9131088853, green: 0.6618924141, blue: 0, alpha: 1) : UIColor.gray
            }
            self.titleLabel.textColor = isSelected ? #colorLiteral(red: 0.9131088853, green: 0.6618924141, blue: 0, alpha: 1) : UIColor.black
        }
    }
    
    let selectionView = UIImageView()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AvenirNext-Demibold", size: 16)
        return label
    }()
    
    let addedPriceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AvenirNext-Demibold", size: 16)
        //label.textColor = UIColor.gray
        return label
    }()
    
    let separatorBar: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.lightGray.withAlphaComponent(0.5)
        return view
    }()
    
    func setupViews() {
        addSubview(selectionView)
        addSubview(titleLabel)
        addSubview(addedPriceLabel)
        addSubview(separatorBar)
        
        NSLayoutConstraint.useAndActivateConstraints(constraints: [
            selectionView.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
            selectionView.widthAnchor.constraint(equalToConstant: 20),
            selectionView.heightAnchor.constraint(equalToConstant: 20),
            selectionView.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            titleLabel.leftAnchor.constraint(equalTo: selectionView.rightAnchor, constant: 10),
            
            addedPriceLabel.trailingAnchor.constraint(equalTo: separatorBar.trailingAnchor, constant: -10),
            addedPriceLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            separatorBar.heightAnchor.constraint(equalToConstant: 1),
            separatorBar.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            separatorBar.rightAnchor.constraint(equalTo: rightAnchor, constant: -20),
            separatorBar.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])
    }
}

class CustomizeCellHeader: UICollectionReusableView, ChangeHeaderDelegate {
    func changeTitle() {
        reqLabel.backgroundColor = UIColor.white
    }
    
    var masterCustomizable: MasterCustomize? {
        didSet {
            if let title = masterCustomizable?.title {
                headerTitle.text = title.uppercased()
            }
            if let requireBool = masterCustomizable?.isRequired {
                if requireBool == true {
                    reqLabel.text = " REQUIRED "
                    reqLabel.backgroundColor = UIColor(named: "honeyYellow")
                } else {
                    reqLabel.text = " OPTIONAL "
                    reqLabel.backgroundColor = UIColor.white
                }
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override class var layerClass: AnyClass {
        get { return CustomLayer.self }
    }
    
    let headerTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AvenirNext-Bold", size: 18)
        label.text = "CHOOSE YOUR TOPPING"
        label.numberOfLines = 2
        return label
    }()
    
    let reqLabel: UILabel = {
        let label = UILabel()
        label.text = " REQUIRED "
        label.font = UIFont(name: "AvenirNext-Bold", size: 12)
        label.backgroundColor = UIColor(named: "honeyYellow")
        return label
    }()
    
    func setupViews() {
        layer.shadowRadius = 10
        layer.shadowOffset = CGSize(width: 0, height: 5)
        layer.shadowOpacity = 0.1
        layer.shadowColor = UIColor.gray.cgColor
        
        addSubview(headerTitle)
        addSubview(reqLabel)
        
        backgroundColor = .white
        NSLayoutConstraint.useAndActivateConstraints(constraints: [
            headerTitle.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 15),
            headerTitle.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5),
            headerTitle.rightAnchor.constraint(equalTo: reqLabel.leftAnchor),
            
            reqLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -15),
            reqLabel.widthAnchor.constraint(equalToConstant: 70),
            reqLabel.centerYAnchor.constraint(equalTo: headerTitle.centerYAnchor)
            ])
    }
}

class CustomLayer: CALayer {
    override var zPosition: CGFloat {
        get { return 0 }
        set {}
    }
}
