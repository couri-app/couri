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
                addedPriceLabel.text = "+$\(String(format: "%.2f", (customizable?.addedPrice!)!))"
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
        backgroundColor = UIColor.white
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
            
            addedPriceLabel.trailingAnchor.constraint(equalTo: separatorBar.trailingAnchor, constant: -20),
            addedPriceLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            separatorBar.heightAnchor.constraint(equalToConstant: 1),
            separatorBar.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            separatorBar.rightAnchor.constraint(equalTo: rightAnchor, constant: -20),
            separatorBar.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])
    }
}
