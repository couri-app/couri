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
    var masterCustomizables: [MasterCustomize]?
    
    // Interface Builder Outlets
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var checkoutButtonView: UIView!
    @IBOutlet weak var scrollview: UIScrollView!
    
    @objc func backTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupViews()
        setupCV()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        masterCustomizables = MasterCustomize.sampleChoicesLibrary()
        contentView.topAnchor.constraint(equalTo: scrollview.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo:scrollview.bottomAnchor).isActive = true
        
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
        layout.minimumLineSpacing = 20
        layout.estimatedItemSize = CGSize(width: 1, height: 1)
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return cv
    }()
    
    var itemCount = 1
    
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
        updatedOrderPrice = Double(itemCount)*orderPrice
        priceLabelSimple.text = "$\(String(format: "%.2f", (updatedOrderPrice)))"
        print("increased Count")
    }
    
    @objc func decreaseCount() {
        print("decreased Count")
    }
    
    func setupViews() {
        contentView.backgroundColor = UIColor.white
        checkoutButtonView.backgroundColor = UIColor.white
        
        addShadowButton(button: backwardsButton)
        addShadowView(view: cardView, color: UIColor.black)
        addShadowView(view: checkoutButtonView, color: UIColor.black)
        
        contentView.addSubview(itemImage)
        contentView.addSubview(backwardsButton)
        contentView.addSubview(masterCollectionView)
        contentView.addSubview(cardView)
        
        cardView.addSubview(nameLabel)
        cardView.addSubview(descriptionLabel)
        cardView.addSubview(priceLabel)
        
        checkoutButtonView.addSubview(addToOrderButton)
        addToOrderButton.addSubview(priceLabelSimple)
        
        backwardsButton.addTarget(self, action: #selector(backTapped), for: .touchUpInside)
        
        nameLabel.text = item?.itemName
        descriptionLabel.text = item?.itemDescription
        orderPrice = item!.itemPrice
        priceLabel.text = " $\(String(format: "%.2f", (item?.itemPrice)!)) "
        priceLabelSimple.text = "$\(String(format: "%.2f", (orderPrice)))"
        
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
            
            cardView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10),
            cardView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10),
            cardView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            cardView.bottomAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 20),
            
            itemImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: -50),
            itemImage.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            itemImage.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            itemImage.heightAnchor.constraint(equalToConstant: 250),
            
            nameLabel.leftAnchor.constraint(equalTo: cardView.leftAnchor, constant: 20),
            nameLabel.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 10),
            nameLabel.rightAnchor.constraint(equalTo: cardView.rightAnchor, constant: -20),
            
            priceLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            
            masterCollectionView.topAnchor.constraint(equalTo: cardView.bottomAnchor),
            masterCollectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            masterCollectionView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            masterCollectionView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            
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
        masterCollectionView.register(DetailFooterView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "footerID")
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
        cell.masterCustomizable = masterCustomizables?[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let count = masterCustomizables?.count {
            return count
        } else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if let customizable = masterCustomizables?[indexPath.item] {
            let height = CGFloat((customizable.choices!.count * 50) + 50)
            let width = view.frame.width
            return CGSize(width: width, height: height)
        } else {
            return CGSize(width: collectionView.frame.width, height: 350)
        }
    }
    
    // Footer
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: contentView.frame.width, height: 120)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "footerID", for: indexPath) as! DetailFooterView
        return footer
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
