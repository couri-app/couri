//
//  DeliveryAddressViewController.swift
//  Couri
//
//  Created by David Chen on 7/6/19.
//  Copyright © 2019 Couri. All rights reserved.
//

import UIKit
import MapKit

class DeliveryAddressViewController: UIViewController, MKMapViewDelegate, AddressDelegate {

    var restaurants: [Restaurant]?
    let selectedRestaurantsView = SelectedRestaurants()
    let mapView = MKMapView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        selectedRestaurantsView.restaurantArray = self.restaurants
        setupViews()
    }
    
    let hamburgerButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "hamburgerMenu"), for: .normal)
        button.frame.size = CGSize(width: 50, height: 50)
        return button
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
    
    let nextButton: UIButton = {
        let button = UIButton()
        button.setTitle("Next", for: .normal)
        button.layer.borderWidth = 1
        button.backgroundColor = UIColor(named: "honeyYellow")
        button.setTitleColor(UIColor(named: "darkMode"), for: .normal)
        button.titleLabel?.font = UIFont(name: "AvenirNext-Demibold", size: 25)
        button.layer.cornerRadius = 20
        button.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        return button
    }()
    
    let contentView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "darkMode")
        view.layer.cornerRadius = 20
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.4
        view.layer.shadowOffset = CGSize(width: 0, height: 0)
        view.layer.shadowRadius = 10
        return view
    }()
    
    let addressLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AvenirNext-Demibold", size: 25)
        label.textColor = UIColor.white
        label.text = "DELIVERY ADDRESS"
        return label
    }()
    
    let addressDescriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AvenirNext-Regular", size: 16)
        label.textColor = UIColor.white
        label.text = "Where will you be returning to?"
        label.numberOfLines = 2
        return label
    }()
    
    let decoyAddressSearchView: UIView = {
        let view = UIView()
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "searchicon")
        imageView.contentMode = .scaleAspectFill
        view.backgroundColor = UIColor(named: "honeyYellow")
        view.layer.cornerRadius = 15
        view.addSubview(imageView)
        NSLayoutConstraint.useAndActivateConstraints(constraints: [
            imageView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
            imageView.widthAnchor.constraint(equalToConstant: 25),
            imageView.heightAnchor.constraint(equalToConstant: 25),
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            ])
        return view
    }()
    
    let enterAddressLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AvenirNext-Regular", size: 16)
        label.textColor = UIColor.black
        label.text = "Enter an address"
        return label
    }()
    
    @objc func backTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func addressSegue() {
        performSegue(withIdentifier: "addressSegue", sender: self)
    }
    
    func sendPlacemarkBack(placemark: MKPlacemark) {
        // name, subThoroughfare, thoroughfare, locality, administrative area
        let name = placemark.name
        let addressNumber = placemark.subThoroughfare
        let addressTitle = placemark.thoroughfare
        let city = placemark.locality
        let state = placemark.administrativeArea
        let zip = placemark.postalCode
        enterAddressLabel.text = "\(name ?? ""): \(addressNumber ?? "") \(addressTitle ?? ""), \(city ?? "") \(state ?? "") \(zip ?? "")"
        
        contentView.addSubview(mapView)
        mapView.delegate = self
        let span = MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
        let region = MKCoordinateRegion(center: placemark.coordinate, span: span)
        let annotation = MKPointAnnotation()
        annotation.coordinate = placemark.coordinate
        annotation.title = placemark.name
        if let city = placemark.locality,
            let address = placemark.thoroughfare {
            annotation.subtitle = "\(city), \(address)"
        }
        mapView.addAnnotation(annotation)
        mapView.setRegion(region, animated: true)
        mapView.isScrollEnabled = false
        mapView.isZoomEnabled = false
        
        NSLayoutConstraint.useAndActivateConstraints(constraints: [
            mapView.topAnchor.constraint(equalTo: decoyAddressSearchView.bottomAnchor, constant: 10),
            mapView.leadingAnchor.constraint(equalTo: decoyAddressSearchView.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: decoyAddressSearchView.trailingAnchor),
            mapView.bottomAnchor.constraint(equalTo: nextButton.topAnchor, constant: -10)
            ])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nav = segue.destination as! UINavigationController
        let destination = nav.topViewController as! AddressViewController
        destination.addressDelegate = self
    }
    
    func setupViews() {
        let guide = view.safeAreaLayoutGuide
        
        var height = 140
        
        if restaurants?.count == 1 {
            height = 70
        }
        
        view.backgroundColor = UIColor(named: "darkMode")
        view.addSubview(hamburgerButton)
        view.addSubview(selectedRestaurantsView)
        view.addSubview(backwardsButton)
        view.addSubview(contentView)
        view.addSubview(nextButton)
        
        contentView.addSubview(addressLabel)
        contentView.addSubview(addressDescriptionLabel)
        contentView.addSubview(decoyAddressSearchView)
        contentView.addSubview(enterAddressLabel)
        
        backwardsButton.addTarget(self, action: #selector(backTapped), for: .touchUpInside)
        decoyAddressSearchView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(addressSegue)))
        
        NSLayoutConstraint.useAndActivateConstraints(constraints: [
            hamburgerButton.topAnchor.constraint(equalTo: guide.topAnchor, constant: 10),
            hamburgerButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            
            selectedRestaurantsView.topAnchor.constraint(equalTo: hamburgerButton.bottomAnchor, constant: 20),
            selectedRestaurantsView.heightAnchor.constraint(equalToConstant: CGFloat(height)),
            selectedRestaurantsView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
            selectedRestaurantsView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10),
            
            backwardsButton.topAnchor.constraint(equalTo: selectedRestaurantsView.bottomAnchor, constant: 10),
            backwardsButton.leftAnchor.constraint(equalTo: guide.leftAnchor, constant: 10),
            backwardsButton.widthAnchor.constraint(equalToConstant: 60),
            backwardsButton.heightAnchor.constraint(equalToConstant: 30),
            
            contentView.topAnchor.constraint(equalTo: backwardsButton.bottomAnchor, constant: 10),
            contentView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
            contentView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10),
            contentView.bottomAnchor.constraint(equalTo: guide.bottomAnchor),
            
            addressLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            addressLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            
            addressDescriptionLabel.topAnchor.constraint(equalTo: addressLabel.bottomAnchor),
            addressDescriptionLabel.leadingAnchor.constraint(equalTo: addressLabel.leadingAnchor),
            addressDescriptionLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10),
            
            decoyAddressSearchView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10),
            decoyAddressSearchView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10),
            decoyAddressSearchView.topAnchor.constraint(equalTo: addressDescriptionLabel.bottomAnchor, constant: 10),
            decoyAddressSearchView.heightAnchor.constraint(equalToConstant: 30),
            
            enterAddressLabel.centerYAnchor.constraint(equalTo: decoyAddressSearchView.centerYAnchor),
            enterAddressLabel.leftAnchor.constraint(equalTo: decoyAddressSearchView.leftAnchor, constant: 40),
            enterAddressLabel.rightAnchor.constraint(equalTo: decoyAddressSearchView.rightAnchor),
            
            nextButton.heightAnchor.constraint(equalToConstant: 80),
            nextButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            nextButton.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            nextButton.rightAnchor.constraint(equalTo: contentView.rightAnchor)
            ])
    }
}
