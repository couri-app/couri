//
//  DetailFooterView.swift
//  Couri
//
//  Created by David Chen on 6/26/19.
//  Copyright © 2019 Couri. All rights reserved.
//

import Foundation
import UIKit

//class DetailFooterView: UICollectionReusableView {
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        setupViews()
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    let addToOrderButton: UIView = {
//        let view = UIView()
//        let label = UILabel()
//        label.text = "Add to Order"
//        label.font = UIFont(name: "AvenirNext-Medium", size: 16)
//        view.backgroundColor = UIColor(named: "honeyYellow")
//        view.layer.cornerRadius = 5
//        view.addSubview(label)
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//        label.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
//        return view
//    }()
//
//    let cardView: UIView = {
//        let subview = UIView()
//        subview.backgroundColor = UIColor.white
//        subview.layer.cornerRadius = 20
//        return subview
//    }()
//
//    let masterCollectionView: UICollectionView = {
//        let layout = UICollectionViewFlowLayout()
//        layout.minimumLineSpacing = 20
//        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
//        return cv
//    }()
//
//    let counterView: UIView = {
//        let view = UIView()
//        let separatorBar = UIView()
//        let smallSeparator = UIView()
//        separatorBar.backgroundColor = UIColor.black.withAlphaComponent(0.4)
//        view.backgroundColor = UIColor.white
//        view.addSubview(separatorBar)
//        view.addSubview(smallSeparator)
//        smallSeparator.backgroundColor = UIColor.black.withAlphaComponent(0.4)
//        NSLayoutConstraint.useAndActivateConstraints(constraints: [
//            separatorBar.topAnchor.constraint(equalTo: view.topAnchor),
//            separatorBar.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            separatorBar.leftAnchor.constraint(equalTo: view.leftAnchor),
//            separatorBar.rightAnchor.constraint(equalTo: view.rightAnchor),
//            separatorBar.heightAnchor.constraint(equalToConstant: 1/4),
//
//            smallSeparator.topAnchor.constraint(equalTo: view.topAnchor, constant: 41),
//            smallSeparator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            smallSeparator.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
//            smallSeparator.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
//            smallSeparator.heightAnchor.constraint(equalToConstant: 1/4)
//            ])
//        return view
//    }()
//
//    let counterButtons: UIView = {
//        let view = UIView()
//        view.backgroundColor = UIColor.white
//        view.layer.cornerRadius = 10
//        view.clipsToBounds = true
//        return view
//    }()
//
//    let plusButton: UIButton = {
//        let button = UIButton()
//        button.backgroundColor = UIColor(named: "honeyYellow")
//        button.setTitle("+", for: .normal)
//        button.titleLabel?.font = UIFont(name: "AvenirNext-Regular", size: 30)
//        button.setTitleColor(UIColor.black, for: .normal)
//        button.layer.frame.size = CGSize(width: 50, height: 50)
//        return button
//    }()
//
//    let minusButton: UIButton = {
//        let button = UIButton()
//        button.backgroundColor = UIColor(named: "honeyYellow")
//        button.setTitle("—", for: .normal)
//        button.titleLabel?.font = UIFont(name: "AvenirNext-Regular", size: 30)
//        button.setTitleColor(UIColor.gray, for: .normal)
//        return button
//    }()
//
//    var itemCount = 1
//
//    let countLabel: UILabel = {
//        let label = UILabel()
//        label.font = UIFont(name: "AvenirNext-Medium", size: 20)
//        return label
//    }()
//
//    let specialInstructionsButton: UIButton = {
//        let button = UIButton()
//        button.backgroundColor = UIColor.white
//        button.setTitle("Add Special Instructions", for: .normal)
//        button.setTitleColor(UIColor.black, for: .normal)
//        button.titleLabel?.font = UIFont(name: "AvenirNext-Medium", size: 16)
//        button.contentHorizontalAlignment = .left
//        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 0)
//        return button
//    }()
//
//    let arrow: UIImageView = {
//        let imageView = UIImageView()
//        imageView.image = UIImage(named: "rightarrow")
//        imageView.contentMode = .scaleAspectFill
//        return imageView
//    }()
//
//    func addShadowButton(button: UIButton) {
//        button.layer.shadowRadius = 8
//        button.layer.shadowColor = #colorLiteral(red: 0.07881314767, green: 0.07881314767, blue: 0.07881314767, alpha: 1)
//        button.layer.shadowOffset = CGSize(width: 0, height: 0)
//        button.layer.shadowOpacity = 0.2
//        button.layer.shadowRadius = 10
//    }
//
//    func addShadowView(view: UIView, color: UIColor) {
//        view.layer.shadowColor = color.cgColor
//        view.layer.shadowOffset = CGSize(width: 0, height: 0)
//        view.layer.shadowOpacity = 0.2
//        view.layer.shadowRadius = 10
//    }
//
//    var orderPrice = Double()
//    var updatedOrderPrice = Double()
//
//    let menuDetailVC = MenuDetailVC()
//
//    @objc func increaseCount() {
//        itemCount += 1
//        countLabel.text = String(itemCount)
//        updatedOrderPrice = Double(itemCount)*orderPrice
//        minusButton.setTitleColor(UIColor.black, for: .normal)
//        menuDetailVC.increaseCount()
//    }
//
//    @objc func decreaseCount() {
//        menuDetailVC.decreaseCount()
//        if itemCount > 2 {
//            itemCount -= 1
//            countLabel.text = String(itemCount)
//            menuDetailVC.multipliedOrderPrice = orderPrice*Double(itemCount)
//        } else {
//            itemCount = 1
//            menuDetailVC.multipliedOrderPrice = orderPrice
//            menuDetailVC.checkoutPriceLabel.text = "$\(String(format: "%.2f", (updatedOrderPrice)))"
//            countLabel.text = String(itemCount)
//            minusButton.setTitleColor(UIColor.gray, for: .normal)
//        }
//    }
//
//    func setupViews() {
//        addSubview(counterView)
//        counterView.addSubview(counterButtons)
//        counterView.addSubview(specialInstructionsButton)
//        counterView.addSubview(arrow)
//
//        counterButtons.addSubview(plusButton)
//        counterButtons.addSubview(minusButton)
//        counterButtons.addSubview(countLabel)
//
//        plusButton.addTarget(self, action: #selector(increaseCount), for: .touchUpInside)
//        minusButton.addTarget(self, action: #selector(decreaseCount), for: .touchUpInside)
//
//        countLabel.text = String(itemCount)
//
//        NSLayoutConstraint.useAndActivateConstraints(constraints: [
//            counterView.bottomAnchor.constraint(equalTo: bottomAnchor),
//            counterView.topAnchor.constraint(equalTo: topAnchor),
//            counterView.leadingAnchor.constraint(equalTo: leadingAnchor),
//            counterView.trailingAnchor.constraint(equalTo: trailingAnchor),
//
//            specialInstructionsButton.topAnchor.constraint(equalTo: counterView.topAnchor, constant: 1),
//            specialInstructionsButton.heightAnchor.constraint(equalToConstant: 40),
//            specialInstructionsButton.leftAnchor.constraint(equalTo: counterView.leftAnchor),
//            specialInstructionsButton.rightAnchor.constraint(equalTo: counterView.rightAnchor),
//            specialInstructionsButton.bottomAnchor.constraint(equalTo: counterButtons.topAnchor, constant: -10),
//
//            arrow.rightAnchor.constraint(equalTo: counterView.rightAnchor, constant: -30),
//            arrow.centerYAnchor.constraint(equalTo: specialInstructionsButton.centerYAnchor),
//            arrow.heightAnchor.constraint(equalToConstant: 15),
//            arrow.widthAnchor.constraint(equalToConstant: 15),
//
//            counterButtons.heightAnchor.constraint(equalToConstant: 50),
//            counterButtons.widthAnchor.constraint(equalToConstant: frame.width/2),
//            counterButtons.centerXAnchor.constraint(equalTo: counterView.centerXAnchor),
//            counterButtons.bottomAnchor.constraint(equalTo: counterView.bottomAnchor, constant: -10),
//
//            plusButton.rightAnchor.constraint(equalTo: counterButtons.rightAnchor),
//            plusButton.topAnchor.constraint(equalTo: counterButtons.topAnchor),
//            plusButton.bottomAnchor.constraint(equalTo: counterButtons.bottomAnchor),
//            plusButton.widthAnchor.constraint(equalToConstant: 50),
//            plusButton.heightAnchor.constraint(equalToConstant: 50),
//
//            minusButton.leftAnchor.constraint(equalTo: counterButtons.leftAnchor),
//            minusButton.topAnchor.constraint(equalTo: counterButtons.topAnchor),
//            minusButton.bottomAnchor.constraint(equalTo: counterButtons.bottomAnchor),
//            minusButton.widthAnchor.constraint(equalToConstant: 50),
//            minusButton.heightAnchor.constraint(equalToConstant: 50),
//
//            countLabel.centerXAnchor.constraint(equalTo: counterButtons.centerXAnchor),
//            countLabel.centerYAnchor.constraint(equalTo: counterButtons.centerYAnchor),
//            ])
//    }
//}
