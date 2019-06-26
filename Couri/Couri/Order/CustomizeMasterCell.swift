//
//  CustomizeMasterCell.swift
//  Couri
//
//  Created by David Chen on 6/26/19.
//  Copyright © 2019 Couri. All rights reserved.
//

import Foundation

import Foundation
import UIKit

class CustomizeMasterCell: UICollectionViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    private let masterCellID = "masterCellID123"
    
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
    
    override func prepareForReuse() {
        super.prepareForReuse()
        reloadCollectionViewData(collectionView: choicesCollectionView)
    }
    
    let customizeCell = CustomizableOptions()
    
    func reloadCollectionViewData(collectionView: UICollectionView) {
        let indexPaths = collectionView.indexPathsForSelectedItems
        //print(collectionView.indexPathsForSelectedItems!)
        collectionView.reloadData()
        for indexpath in indexPaths ?? [] {
            collectionView.selectItem(at: indexpath, animated: false, scrollPosition: [])
            //print(collectionView.indexPathsForSelectedItems!)
            print(collectionView.numberOfItems(inSection: 0))
        }
    }
    
    let choicesCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.white
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()
    
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
        backgroundColor = UIColor.black
        addSubview(choicesCollectionView)
        
        addSubview(headerTitle)
        addSubview(reqLabel)
        
        choicesCollectionView.isScrollEnabled = false
        choicesCollectionView.isSpringLoaded = false
        choicesCollectionView.delegate = self
        choicesCollectionView.dataSource = self
        choicesCollectionView.register(CustomizeCell.self, forCellWithReuseIdentifier: masterCellID)
        
        NSLayoutConstraint.useAndActivateConstraints(constraints: [
            choicesCollectionView.topAnchor.constraint(equalTo: topAnchor),
            choicesCollectionView.rightAnchor.constraint(equalTo: rightAnchor),
            choicesCollectionView.leftAnchor.constraint(equalTo: leftAnchor),
            choicesCollectionView.heightAnchor.constraint(equalTo: heightAnchor),
            
            headerTitle.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
            headerTitle.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            
            reqLabel.centerYAnchor.constraint(equalTo: headerTitle.centerYAnchor),
            reqLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -40)
            ])
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let count = masterCustomizable?.choices?.count {
            return count
        } else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: masterCellID, for: indexPath) as! CustomizeCell
        let customizable = masterCustomizable?.choices?[indexPath.item]
        if customizable?.isSingleSelection == true {
            choicesCollectionView.allowsMultipleSelection = false
        } else {
            choicesCollectionView.allowsMultipleSelection = true
        }
        
        cell.customizable = customizable
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width, height: 50)
    }
}
