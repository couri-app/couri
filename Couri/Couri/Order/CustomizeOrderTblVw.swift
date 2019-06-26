//
//  CustomizeOrderTblVw.swift
//  Couri
//
//  Created by David Chen on 6/21/19.
//  Copyright © 2019 Couri. All rights reserved.
//

import Foundation
import UIKit

class CollectionHeader: UICollectionReusableView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let headerTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AvenirNext-Bold", size: 18)
        label.text = "CHOOSE YOUR TOPPING"
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
        backgroundColor = .white
        
        addSubview(headerTitle)
        addSubview(reqLabel)
        
        NSLayoutConstraint.useAndActivateConstraints(constraints: [
            headerTitle.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
            headerTitle.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
            
            reqLabel.centerYAnchor.constraint(equalTo: headerTitle.centerYAnchor),
            reqLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -40)
            ])
    }
}

class CustomizeChoice {
    var isSingleSelection = Bool()
    var title = String()
    var addedPrice: Double?
}

struct ChoicesLibrary {
    var teBoba: [CustomizeChoice] = []
    
    init() {
        generateLibrary()
    }
}

extension ChoicesLibrary {
    mutating func generateLibrary() {
        let bobaChoice1 = CustomizeChoice()
        bobaChoice1.addedPrice = 0.50
        bobaChoice1.isSingleSelection = true
        bobaChoice1.title = "Large Pearl"
        
        let bobaChoice2 = CustomizeChoice()
        bobaChoice2.addedPrice = 0.50
        bobaChoice2.isSingleSelection = true
        bobaChoice2.title = "Grass Jelly"
        
        let bobaChoice3 = CustomizeChoice()
        bobaChoice3.addedPrice = 0.50
        bobaChoice3.isSingleSelection = true
        bobaChoice3.title = "Ice Jelly"
        
        let bobaChoice4 = CustomizeChoice()
        bobaChoice4.addedPrice = 0.25
        bobaChoice4.isSingleSelection = true
        bobaChoice4.title = "Red Bean"
        
        let bobaChoice5 = CustomizeChoice()
        bobaChoice5.addedPrice = 0.25
        bobaChoice5.isSingleSelection = true
        bobaChoice5.title = "Marshmallow"
        
        teBoba = [bobaChoice1, bobaChoice2, bobaChoice3, bobaChoice4, bobaChoice5]
    }
}

class CustomizeMasterCell: UICollectionViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var choicesLibrary = ChoicesLibrary()
    private let cellID = "masterCellID"
    private let headerID = "collectionHeaderID"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let choicesCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.lightGray
        cv.translatesAutoresizingMaskIntoConstraints = false
        
        return cv
    }()
    
    func setupViews() {
        backgroundColor = UIColor.black
        addSubview(choicesCollectionView)
        choicesCollectionView.delegate = self
        choicesCollectionView.dataSource = self
        choicesCollectionView.isScrollEnabled = false
        choicesCollectionView.register(CollectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerID)
        choicesCollectionView.register(CustomizeCell.self, forCellWithReuseIdentifier: cellID)
        
        NSLayoutConstraint.useAndActivateConstraints(constraints: [
            choicesCollectionView.topAnchor.constraint(equalTo: topAnchor),
            choicesCollectionView.widthAnchor.constraint(equalTo: widthAnchor),
            choicesCollectionView.leftAnchor.constraint(equalTo: leftAnchor),
            choicesCollectionView.heightAnchor.constraint(equalTo: heightAnchor)
            ])
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return choicesLibrary.teBoba.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! CustomizeCell
        let currentCustomizable = choicesLibrary.teBoba[indexPath.row]
        cell.customizable = currentCustomizable
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: frame.width, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let collectionHeader = self.choicesCollectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerID, for: indexPath) as! CollectionHeader
        return collectionHeader
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width, height: 50)
    }
}

class CustomizeCell: UICollectionViewCell {
    var customizable: CustomizeChoice! {
        didSet {
            if customizable.isSingleSelection == true {
                selectionView.image = UIImage(named: "deselectedCircle")
            }
            
            titleLabel.text = customizable.title
            
            if customizable.addedPrice != nil {
                addedPriceLabel.text = "+$\(String(format: "%.2f", customizable.addedPrice!))"
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
            self.selectionView.image = isSelected ? UIImage(named: "selectedCircle") : UIImage(named: "deselectedCircle")
            self.titleLabel.textColor = isSelected ? #colorLiteral(red: 0.9131088853, green: 0.6618924141, blue: 0, alpha: 1) : UIColor.black
            self.addedPriceLabel.textColor = isSelected ? #colorLiteral(red: 0.9131088853, green: 0.6618924141, blue: 0, alpha: 1) : UIColor.gray
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
        label.textColor = UIColor.gray
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
            separatorBar.rightAnchor.constraint(equalTo: rightAnchor, constant: -35),
            separatorBar.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -1)
            ])
    }
}

