//
//  MenuCategoryModels.swift
//  Couri
//
//  Created by David Chen on 6/18/19.
//  Copyright © 2019 Couri. All rights reserved.
//

import UIKit

class CategoryCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var categorySelected = false
    
    let buttonView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        
        return view
    }()
    
    let categoryLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont(name: "AvenirNext-Regular", size: 10)
        
        return label
    }()
    
    func setupViews() {
        addSubview(buttonView)
        addSubview(categoryLabel)
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(selectCategory)))
        
        backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        layer.cornerRadius = 10
        addShadowObject(object: self)
        
        buttonView.translatesAutoresizingMaskIntoConstraints = false
        categoryLabel.translatesAutoresizingMaskIntoConstraints = false
        
        addConstraints([
            buttonView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            buttonView.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            buttonView.widthAnchor.constraint(equalToConstant: 30),
            buttonView.heightAnchor.constraint(equalToConstant: 30),
            categoryLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            categoryLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5),
            categoryLabel.widthAnchor.constraint(equalToConstant: frame.width)
            ])
    }
    
    func deselectCategory() {
        backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        categoryLabel.font = UIFont(name: "AvenirNext-Regular", size: 10)
        categorySelected = false
    }
    
    @objc func selectCategory() {
        if categorySelected == true {
            deselectCategory()
        } else {
            backgroundColor = #colorLiteral(red: 1, green: 0.8899999857, blue: 0.5490000248, alpha: 1)
            self.categoryLabel.font = UIFont(name: "AvenirNext-Bold", size: 10)
            self.categorySelected = true
        }
    }
    
    func addShadowObject(object: UIView) {
        object.layer.shadowRadius = 8
        object.layer.shadowColor = #colorLiteral(red: 0.07881314767, green: 0.07881314767, blue: 0.07881314767, alpha: 1)
        object.layer.shadowOffset = CGSize(width: 0, height: 0)
        object.layer.shadowOpacity = 0.2
        object.layer.shadowRadius = 3
    }
}
