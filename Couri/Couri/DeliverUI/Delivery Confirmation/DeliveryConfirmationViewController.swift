//
//  DeliveryConfirmationViewController.swift
//  Couri
//
//  Created by David Chen on 7/6/19.
//  Copyright © 2019 Couri. All rights reserved.
//

import UIKit
import MapKit

class DeliveryConfirmationViewController: UIViewController {
    
    var restaurants: [Restaurant]?
    let selectedRestaurantsView = SelectedRestaurants()
    var minutesCount = Int()
    var deliveriesCount = Int()
    var returnPlacemark: MKPlacemark?
    var isActive = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        selectedRestaurantsView.restaurantArray = restaurants
        setupViews()
    }
    
    let hamburgerButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "hamburgerMenu"), for: .normal)
        button.frame.size = CGSize(width: 50, height: 50)
        return button
    }()
    
    let confirmationView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 20
        view.backgroundColor = UIColor(named: "darkMode")
        return view
    }()
    
    let switchView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 20
        view.backgroundColor = UIColor(named: "darkMode")
        return view
    }()
    
    let confirmLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AvenirNext-Demibold", size: 25)
        label.textColor = UIColor.white
        label.text = "CONFIRM DELIVERY"
        return label
    }()
    
    let fromLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AvenirNext-Regular", size: 16)
        label.textColor = UIColor.white
        label.numberOfLines = 2
        return label
    }()
    
    let durationLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AvenirNext-Regular", size: 16)
        label.textColor = UIColor.white
        label.numberOfLines = 0
        return label
    }()
    
    let deliveringToLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AvenirNext-Regular", size: 16)
        label.textColor = UIColor.white
        label.text = "Delivering to:"
        label.numberOfLines = 2
        return label
    }()
    
    let toView: UIView = {
        let view = UIView()
        view.layer.backgroundColor = UIColor(named: "honeyYellow")?.cgColor
        view.layer.cornerRadius = 5
        return view
    }()
    
    let toAddressLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AvenirNext-Bold", size: 20)
        label.textColor = UIColor(named: "darkMode")
        return label
    }()
    
    let addressDetailLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AvenirNext-Regular", size: 12)
        label.textColor = UIColor(named: "darkMode")
        return label
    }()
    
    let backwardsButton: UIButton = {
        let button = UIButton()
        button.setTitle("Back", for: .normal)
        button.layer.borderColor = UIColor(named: "honeyYellow")?.cgColor
        button.layer.borderWidth = 1
        button.backgroundColor = UIColor(named: "darkMode")
        button.setTitleColor(UIColor(named: "honeyYellow"), for: .normal)
        button.titleLabel?.font = UIFont(name: "AvenirNext-Regular", size: 16)
        button.layer.cornerRadius = 15
        return button
    }()
    
    let readyToDeliverLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AvenirNext-Demibold", size: 25)
        label.textColor = UIColor.white
        label.text = "READY TO DELIVER"
        return label
    }()
    
    let readyMessageLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AvenirNext-Regular", size: 16)
        label.textColor = UIColor.white
        label.text = "Note: We highly recommend that you only activate this switch once you've arrived at your restaurant. This way, customer wait times are accurately represented"
        label.numberOfLines = 0
        return label
    }()
    
    let outerSwitchView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "shopDescription")
        view.layer.cornerRadius = 25
        return view
    }()
    
    let switchButton: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.layer.cornerRadius = 23
        return view
    }()
    
    func exit(action: UIAlertAction) {
        switchSelected()
        navigationController?.popViewController(animated: true)
    }
    
    @objc func backwardsTapped() {
        if isActive {
            let alert = UIAlertController(title: "Are you sure?", message: "You're currently activated. You cannot receive order requests unless your switch is activated.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: exit))
            self.present(alert, animated: true)
        } else {
            navigationController?.popViewController(animated: true)
        }
    }
    
    @objc func switchSelected() {
        if !isActive {
            let height = outerSwitchView.frame.height - switchButton.frame.height - 8
            UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 3, initialSpringVelocity: 1, options: [], animations: {
                self.switchButton.transform = CGAffineTransform(translationX: 0, y: height)
            })
            outerSwitchView.backgroundColor = UIColor(named: "honeyYellow")
            readyMessageLabel.text = "Confirmed. We will send you a notification you when you receive an order. Please keep your phone visible at all times so we can allow delivery requests to go through"
            isActive = true
        } else {
            UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 3, initialSpringVelocity: 1, options: [], animations: {
                self.switchButton.transform = CGAffineTransform(translationX: 0, y: 0)
            })
            readyMessageLabel.text = "Deactivated. Warning: you will not be notified of a delivery request until the switch is activated"
            outerSwitchView.backgroundColor = UIColor(named: "shopDescription")
            isActive = false
        }
    }
    
    func addShadowToView(view: UIView, opacity: Double, radius: Int) {
        view.layer.shadowRadius = CGFloat(radius)
        view.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        view.layer.shadowOffset = CGSize(width: 0, height: 0)
        view.layer.shadowOpacity = Float(CGFloat(opacity))
    }
    
    func setupViews() {
        let guide = view.safeAreaLayoutGuide
        var height: CGFloat
        
        view.backgroundColor = UIColor(named: "darkMode")
        
        view.addSubview(hamburgerButton)
        view.addSubview(confirmationView)
        view.addSubview(backwardsButton)
        view.addSubview(switchView)
        
        confirmationView.addSubview(confirmLabel)
        confirmationView.addSubview(fromLabel)
        confirmationView.addSubview(selectedRestaurantsView)
        confirmationView.addSubview(durationLabel)
        confirmationView.addSubview(deliveringToLabel)
        confirmationView.addSubview(toView)
        
        toView.addSubview(toAddressLabel)
        toView.addSubview(addressDetailLabel)
        
        switchView.addSubview(readyToDeliverLabel)
        switchView.addSubview(readyMessageLabel)
        switchView.addSubview(outerSwitchView)
        outerSwitchView.addSubview(switchButton)
        
        addShadowToView(view: confirmationView, opacity: 0.4, radius: 10)
        addShadowToView(view: switchView, opacity: 0.4, radius: 10)
        addShadowToView(view: switchButton, opacity: 0.2, radius: 3)
        
        fromLabel.text = "Delivering up to \(deliveriesCount) items from:"
        durationLabel.text = "Duration of stay: \(minutesCount) minutes"
        toAddressLabel.text = "\(returnPlacemark?.name ?? "")"
        addressDetailLabel.text = "\(returnPlacemark?.subThoroughfare ?? "") \(returnPlacemark?.thoroughfare ?? ""), \(returnPlacemark?.locality ?? "") \(returnPlacemark?.administrativeArea ?? "") \(returnPlacemark?.postalCode ?? "")"
        
        backwardsButton.addTarget(self, action: #selector(backwardsTapped), for: .touchUpInside)
        switchButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(switchSelected)))
        outerSwitchView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(switchSelected)))
        
        if (restaurants?.count)! > 1 {
            height = 130
        } else {
            height = 70
        }
        
        NSLayoutConstraint.useAndActivateConstraints(constraints: [
            hamburgerButton.topAnchor.constraint(equalTo: guide.topAnchor),
            hamburgerButton.leftAnchor.constraint(equalTo: guide.leftAnchor, constant: 10),
            
            confirmationView.leadingAnchor.constraint(equalTo: hamburgerButton.leadingAnchor),
            confirmationView.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: -10),
            confirmationView.topAnchor.constraint(equalTo: hamburgerButton.bottomAnchor, constant: 20),
            confirmationView.bottomAnchor.constraint(equalTo: toView.bottomAnchor, constant: 20),
            
            confirmLabel.topAnchor.constraint(equalTo: confirmationView.topAnchor, constant: 10),
            confirmLabel.leadingAnchor.constraint(equalTo: confirmationView.leadingAnchor, constant: 10),
            
            fromLabel.topAnchor.constraint(equalTo: confirmLabel.bottomAnchor, constant: 5),
            fromLabel.leadingAnchor.constraint(equalTo: confirmLabel.leadingAnchor),
            
            selectedRestaurantsView.topAnchor.constraint(equalTo: fromLabel.bottomAnchor, constant: 10),
            selectedRestaurantsView.leadingAnchor.constraint(equalTo: confirmLabel.leadingAnchor),
            selectedRestaurantsView.trailingAnchor.constraint(equalTo: confirmationView.trailingAnchor, constant: -10),
            selectedRestaurantsView.heightAnchor.constraint(equalToConstant: height),
            
            durationLabel.topAnchor.constraint(equalTo: selectedRestaurantsView.bottomAnchor, constant: 10),
            durationLabel.leadingAnchor.constraint(equalTo: confirmLabel.leadingAnchor),
            
            deliveringToLabel.topAnchor.constraint(equalTo: durationLabel.bottomAnchor, constant: 10),
            deliveringToLabel.leadingAnchor.constraint(equalTo: confirmLabel.leadingAnchor),
            
            toView.leadingAnchor.constraint(equalTo: confirmLabel.leadingAnchor),
            toView.topAnchor.constraint(equalTo: deliveringToLabel.bottomAnchor, constant: 5),
            toView.trailingAnchor.constraint(equalTo: selectedRestaurantsView.trailingAnchor),
            toView.heightAnchor.constraint(equalToConstant: 60),
            
            toAddressLabel.topAnchor.constraint(equalTo: toView.topAnchor, constant: 10),
            toAddressLabel.leadingAnchor.constraint(equalTo: toView.leadingAnchor, constant: 10),
            
            addressDetailLabel.bottomAnchor.constraint(equalTo: toView.bottomAnchor, constant: -10),
            addressDetailLabel.leadingAnchor.constraint(equalTo: toAddressLabel.leadingAnchor, constant: -2),
            
            backwardsButton.topAnchor.constraint(equalTo: confirmationView.bottomAnchor, constant: 10),
            backwardsButton.leadingAnchor.constraint(equalTo: confirmationView.leadingAnchor),
            backwardsButton.widthAnchor.constraint(equalToConstant: 60),
            backwardsButton.heightAnchor.constraint(equalToConstant: 30),
            
            switchView.leadingAnchor.constraint(equalTo: confirmationView.leadingAnchor),
            switchView.trailingAnchor.constraint(equalTo: confirmationView.trailingAnchor),
            switchView.topAnchor.constraint(equalTo: backwardsButton.bottomAnchor, constant: 10),
            switchView.bottomAnchor.constraint(equalTo: guide.bottomAnchor, constant: -10),
            
            readyToDeliverLabel.leadingAnchor.constraint(equalTo: confirmLabel.leadingAnchor),
            readyToDeliverLabel.topAnchor.constraint(equalTo: switchView.topAnchor, constant: 10),
            
            readyMessageLabel.topAnchor.constraint(equalTo: readyToDeliverLabel.bottomAnchor, constant: 5),
            readyMessageLabel.rightAnchor.constraint(equalTo: outerSwitchView.leftAnchor, constant: -5),
            readyMessageLabel.leadingAnchor.constraint(equalTo: confirmLabel.leadingAnchor),
            
            outerSwitchView.rightAnchor.constraint(equalTo: switchView.rightAnchor, constant: -10),
            outerSwitchView.widthAnchor.constraint(equalToConstant: 50),
            outerSwitchView.heightAnchor.constraint(equalToConstant: 160),
            outerSwitchView.topAnchor.constraint(equalTo: switchView.topAnchor, constant: 10),
            
            switchButton.topAnchor.constraint(equalTo: outerSwitchView.topAnchor, constant: 4),
            switchButton.heightAnchor.constraint(equalToConstant: 80),
            switchButton.leftAnchor.constraint(equalTo: outerSwitchView.leftAnchor, constant: 4),
            switchButton.rightAnchor.constraint(equalTo: outerSwitchView.rightAnchor, constant: -4)
            ])
    }
}
