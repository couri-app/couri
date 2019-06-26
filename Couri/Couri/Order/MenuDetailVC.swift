//
//  MenuDetailVC.swift
//  Couri
//
//  Created by David Chen on 6/21/19.
//  Copyright © 2019 Couri. All rights reserved.
//

import UIKit

class MenuDetailVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var item: MenuItem?
    var cvCellID = "collectionviewid"
    
    // Interface Builder Outlets
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var checkoutButtonView: UIView!
    @IBOutlet weak var scrollview: UIScrollView!
    
    @objc func backTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contentView.topAnchor.constraint(equalTo: scrollview.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo:scrollview.bottomAnchor).isActive = true
        setupViews()
        setupCV()
        setupGradientLayer()
    }
    
    let backwardsButton: UIButton = {
        let button = UIButton()
        button.frame.size = CGSize(width: 50, height: 50)
        button.setImage(UIImage(named: "backwards"), for: .normal)
        return button
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AvenirNext-Bold", size: 30)
        label.numberOfLines = 0
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AvenirNext-Regular", size: 16)
        label.numberOfLines = 0
        
        return label
    }()
    
    let itemImage: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    let priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AvenirNext-Bold", size: 16)
        label.backgroundColor = #colorLiteral(red: 0.06274510175, green: 0, blue: 0.1921568662, alpha: 1)
        label.textColor = UIColor.white
        label.layer.cornerRadius = 3
        label.layer.masksToBounds = true
        return label
    }()
    
    var orderPrice = Double()
    var updatedOrderPrice = Double()
    
    let priceLabelSimple: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AvenirNext-Medium", size: 16)
        return label
    }()
    
    let addToOrderButton: UIView = {
        let view = UIView()
        let label = UILabel()
        label.text = "Add to Order"
        label.font = UIFont(name: "AvenirNext-Medium", size: 16)
        view.backgroundColor = UIColor(named: "honeyYellow")
        view.layer.cornerRadius = 5
        view.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        return view
    }()
    
    let cardView: UIView = {
        let subview = UIView()
        subview.backgroundColor = UIColor.white
        subview.layer.cornerRadius = 20
        return subview
    }()
    
    let masterCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 30
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return cv
    }()
    
    let microCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return cv
    }()
    
    let counterView: UIView = {
        let view = UIView()
        let separatorBar = UIView()
        let smallSeparator = UIView()
        separatorBar.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        view.backgroundColor = UIColor.white
        view.addSubview(separatorBar)
        view.addSubview(smallSeparator)
        smallSeparator.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        NSLayoutConstraint.useAndActivateConstraints(constraints: [separatorBar.topAnchor.constraint(equalTo: view.topAnchor),
             separatorBar.centerXAnchor.constraint(equalTo: view.centerXAnchor),
             separatorBar.leftAnchor.constraint(equalTo: view.leftAnchor),
             separatorBar.rightAnchor.constraint(equalTo: view.rightAnchor),
             separatorBar.heightAnchor.constraint(equalToConstant: 1/4),
             
             smallSeparator.topAnchor.constraint(equalTo: view.topAnchor, constant: 41),
             smallSeparator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
             smallSeparator.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
             smallSeparator.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
             smallSeparator.heightAnchor.constraint(equalToConstant: 1/4)
            ])
        return view
    }()
    
    let counterButtons: UIView = {
       let view = UIView()
        view.backgroundColor = UIColor.white
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        return view
    }()
    
    let plusButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(named: "honeyYellow")
        button.setTitle("+", for: .normal)
        button.titleLabel?.font = UIFont(name: "AvenirNext-Regular", size: 30)
        button.setTitleColor(UIColor.black, for: .normal)
        button.layer.frame.size = CGSize(width: 50, height: 50)
        return button
    }()
    
    let minusButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(named: "honeyYellow")
        button.setTitle("—", for: .normal)
        button.titleLabel?.font = UIFont(name: "AvenirNext-Regular", size: 30)
        button.setTitleColor(UIColor.gray, for: .normal)
        return button
    }()
    
    var itemCount = 1
    
    let countLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AvenirNext-Medium", size: 20)
        return label
    }()
    
    let specialInstructionsButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.white
        button.setTitle("Add Special Instructions", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.titleLabel?.font = UIFont(name: "AvenirNext-Medium", size: 16)
        button.contentHorizontalAlignment = .left
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 0)
        return button
    }()
    
    let arrow: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "rightarrow")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    func addShadowButton(button: UIButton) {
        button.layer.shadowRadius = 8
        button.layer.shadowColor = #colorLiteral(red: 0.07881314767, green: 0.07881314767, blue: 0.07881314767, alpha: 1)
        button.layer.shadowOffset = CGSize(width: 0, height: 0)
        button.layer.shadowOpacity = 0.2
        button.layer.shadowRadius = 10
    }
    
    func addShadowView(view: UIView, color: UIColor) {
        view.layer.shadowColor = color.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 0)
        view.layer.shadowOpacity = 0.2
        view.layer.shadowRadius = 10
    }
    
    @objc func increaseCount() {
        itemCount += 1
        countLabel.text = String(itemCount)
        updatedOrderPrice = Double(itemCount)*orderPrice
        priceLabelSimple.text = "$\(String(format: "%.2f", (updatedOrderPrice)))"
        minusButton.setTitleColor(UIColor.black, for: .normal)
    }
    
    @objc func decreaseCount() {
        if itemCount > 2 {
            itemCount -= 1
            countLabel.text = String(itemCount)
            updatedOrderPrice = orderPrice*Double(itemCount)
            priceLabelSimple.text = "$\(String(format: "%.2f", (updatedOrderPrice)))"
        } else {
            itemCount = 1
            updatedOrderPrice = orderPrice
            priceLabelSimple.text = "$\(String(format: "%.2f", (updatedOrderPrice)))"
            countLabel.text = String(itemCount)
            minusButton.setTitleColor(UIColor.gray, for: .normal)
        }
    }
    
    func setupViews() {
        contentView.backgroundColor = UIColor.white
        checkoutButtonView.backgroundColor = UIColor.white
        
        addShadowButton(button: backwardsButton)
        addShadowView(view: cardView, color: UIColor.black)
        addShadowView(view: checkoutButtonView, color: UIColor.black)
        
        contentView.addSubview(itemImage)
        contentView.addSubview(backwardsButton)
        contentView.addSubview(counterView)
        contentView.addSubview(masterCollectionView)
        contentView.addSubview(cardView)
        
        cardView.addSubview(nameLabel)
        cardView.addSubview(descriptionLabel)
        cardView.addSubview(priceLabel)
        
        counterView.addSubview(counterButtons)
        counterView.addSubview(specialInstructionsButton)
        counterView.addSubview(arrow)
        
        counterButtons.addSubview(plusButton)
        counterButtons.addSubview(minusButton)
        counterButtons.addSubview(countLabel)
        
        checkoutButtonView.addSubview(addToOrderButton)
        addToOrderButton.addSubview(priceLabelSimple)
        
        backwardsButton.addTarget(self, action: #selector(backTapped), for: .touchUpInside)
        plusButton.addTarget(self, action: #selector(increaseCount), for: .touchUpInside)
        minusButton.addTarget(self, action: #selector(decreaseCount), for: .touchUpInside)
        
        nameLabel.text = item?.itemName
        descriptionLabel.text = item?.itemDescription
        orderPrice = item!.itemPrice
        priceLabel.text = " $\(String(format: "%.2f", (item?.itemPrice)!)) "
        priceLabelSimple.text = "$\(String(format: "%.2f", (orderPrice)))"
        countLabel.text = String(itemCount)
        
        if item?.itemImage != nil {
            itemImage.image = item?.itemImage
            cardView.topAnchor.constraint(equalTo: itemImage.bottomAnchor, constant: -50).isActive = true
            
        } else {
            cardView.topAnchor.constraint(equalTo: backwardsButton.bottomAnchor, constant: 20).isActive = true
        }
        
        if item?.itemDescription != nil {
            priceLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 5).isActive = true
            descriptionLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5).isActive = true
            descriptionLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor).isActive = true
            descriptionLabel.rightAnchor.constraint(equalTo: cardView.rightAnchor, constant: -10).isActive = true
            
        } else {
            priceLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5).isActive = true
        }
        
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.useAndActivateConstraints(constraints: [
            backwardsButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 40),
            backwardsButton.leadingAnchor.constraint(equalTo: cardView.leadingAnchor),
            
            cardView.widthAnchor.constraint(equalToConstant: contentView.frame.width - 20),
            cardView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            cardView.bottomAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 20),
            
            itemImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: -50),
            itemImage.widthAnchor.constraint(equalToConstant: contentView.frame.width),
            itemImage.heightAnchor.constraint(equalToConstant: 200),
            
            nameLabel.leftAnchor.constraint(equalTo: cardView.leftAnchor, constant: 20),
            nameLabel.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 10),
            nameLabel.rightAnchor.constraint(equalTo: cardView.rightAnchor, constant: -20),
            
            priceLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            
            masterCollectionView.topAnchor.constraint(equalTo: cardView.bottomAnchor),
            masterCollectionView.bottomAnchor.constraint(equalTo: counterView.topAnchor),
            masterCollectionView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            masterCollectionView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            
            counterView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            counterView.widthAnchor.constraint(equalToConstant: contentView.frame.width),
            
            specialInstructionsButton.topAnchor.constraint(equalTo: counterView.topAnchor, constant: 1),
            specialInstructionsButton.heightAnchor.constraint(equalToConstant: 40),
            specialInstructionsButton.leftAnchor.constraint(equalTo: counterView.leftAnchor),
            specialInstructionsButton.rightAnchor.constraint(equalTo: counterView.rightAnchor),
            specialInstructionsButton.bottomAnchor.constraint(equalTo: counterButtons.topAnchor, constant: -10),
            
            arrow.rightAnchor.constraint(equalTo: counterView.rightAnchor, constant: -30),
            arrow.centerYAnchor.constraint(equalTo: specialInstructionsButton.centerYAnchor),
            arrow.heightAnchor.constraint(equalToConstant: 15),
            arrow.widthAnchor.constraint(equalToConstant: 15),
            
            counterButtons.heightAnchor.constraint(equalToConstant: 50),
            counterButtons.widthAnchor.constraint(equalToConstant: contentView.frame.width/2),
            counterButtons.centerXAnchor.constraint(equalTo: counterView.centerXAnchor),
            counterButtons.bottomAnchor.constraint(equalTo: counterView.bottomAnchor, constant: -10),
            
            plusButton.rightAnchor.constraint(equalTo: counterButtons.rightAnchor),
            plusButton.topAnchor.constraint(equalTo: counterButtons.topAnchor),
            plusButton.widthAnchor.constraint(equalToConstant: 50),
            plusButton.heightAnchor.constraint(equalToConstant: 50),
            
            minusButton.leftAnchor.constraint(equalTo: counterButtons.leftAnchor),
            minusButton.topAnchor.constraint(equalTo: counterButtons.topAnchor),
            minusButton.widthAnchor.constraint(equalToConstant: 50),
            minusButton.heightAnchor.constraint(equalToConstant: 50),
            
            countLabel.centerXAnchor.constraint(equalTo: counterButtons.centerXAnchor),
            countLabel.centerYAnchor.constraint(equalTo: counterButtons.centerYAnchor),
            
            addToOrderButton.widthAnchor.constraint(equalToConstant: checkoutButtonView.frame.width - 60),
            addToOrderButton.heightAnchor.constraint(equalToConstant: 40),
            addToOrderButton.centerXAnchor.constraint(equalTo: checkoutButtonView.centerXAnchor),
            addToOrderButton.topAnchor.constraint(equalTo: checkoutButtonView.topAnchor, constant: 10),
            
            priceLabelSimple.rightAnchor.constraint(equalTo: addToOrderButton.rightAnchor, constant: -20),
            priceLabelSimple.centerYAnchor.constraint(equalTo: addToOrderButton.centerYAnchor)
            ])
    }
    
    func setupCV() {
        masterCollectionView.dataSource = self
        masterCollectionView.delegate = self
        masterCollectionView.register(CustomizeMasterCell.self, forCellWithReuseIdentifier: cvCellID)
        masterCollectionView.backgroundColor = UIColor.white
        
        //Layout things. Sets margins
        let collectionViewLayout = masterCollectionView.collectionViewLayout as? UICollectionViewFlowLayout
        collectionViewLayout?.invalidateLayout()
    }
    
    func setupGradientLayer() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.white.cgColor, UIColor.white.withAlphaComponent(0).cgColor]
        gradientLayer.locations = [0, 1]
        gradientLayer.frame = CGRect(x: 0, y: -50, width: 500, height: 120)
        contentView.layer.addSublayer(gradientLayer)
    }
}

extension MenuDetailVC {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cvCellID, for: indexPath) as! CustomizeMasterCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 300)
    }
    
}

extension NSLayoutConstraint {
    
    public class func useAndActivateConstraints(constraints: [NSLayoutConstraint]) {
        for constraint in constraints {
            if let view = constraint.firstItem as? UIView {
                view.translatesAutoresizingMaskIntoConstraints = false
            }
        }
        activate(constraints)
    }
}
