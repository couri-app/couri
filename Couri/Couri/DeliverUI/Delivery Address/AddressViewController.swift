//
//  AddressViewController.swift
//  Couri
//
//  Created by David Chen on 7/6/19.
//  Copyright © 2019 Couri. All rights reserved.
//

import UIKit
import MapKit

protocol AddressDelegate: class {
    func sendPlacemarkBack(placemark: MKPlacemark)
}

class AddressViewController: UIViewController, CLLocationManagerDelegate, UISearchBarDelegate, MKMapViewDelegate {
    
    let locationManager = CLLocationManager()
    var resultSearchController: UISearchController?
    let mapView = MKMapView()
    let deliveryAddressVC = DeliveryAddressViewController()
    var selectedPin: MKPlacemark?
    weak var addressDelegate: AddressDelegate?
    
    let contentView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "darkMode")
        return view
    }()
    
    let selectButton: UIButton = {
        let button = UIButton()
        button.layer.backgroundColor = UIColor(named: "honeyYellow")?.cgColor
        button.layer.cornerRadius = 10
        button.setTitle("Select", for: .normal)
        button.titleLabel?.font = UIFont(name: "AvenirNext-Demibold", size: 25)
        button.setTitleColor(UIColor(named: "darkMode"), for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLocation()
        setupViews()
    }
    
    func setupLocation() {
        mapView.delegate = self
        mapView.showsUserLocation = true
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
        let locationSearchTable = storyboard!.instantiateViewController(withIdentifier: "LocationSearchTable") as! LocationSearchTable
        resultSearchController = UISearchController(searchResultsController: locationSearchTable)
        resultSearchController?.searchResultsUpdater = locationSearchTable
        locationSearchTable.mapView = mapView
        locationSearchTable.handleMapSearchDelegate = self
        
        let searchBar = resultSearchController?.searchBar
        searchBar?.sizeToFit()
        searchBar?.placeholder = "Enter your return location"
        searchBar?.delegate = self
        navigationItem.titleView = resultSearchController?.searchBar
        
        resultSearchController?.hidesNavigationBarDuringPresentation = false
        resultSearchController?.dimsBackgroundDuringPresentation = true
        definesPresentationContext = true
    }
    
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let region = MKCoordinateRegion(center: userLocation.coordinate, span: span)
        mapView.setRegion(region, animated: true)
    }
    
    func setupViews() {
        view.backgroundColor = UIColor(named: "darkMode")
        navigationController?.navigationBar.tintColor = UIColor(named: "darkMode")
        
        view.addSubview(mapView)
        mapView.frame = self.view.frame
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func selectButtonClicked() {
        dismiss(animated: true, completion: nil)
        self.addressDelegate?.sendPlacemarkBack(placemark: selectedPin!)
    }
}

extension AddressViewController {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            locationManager.requestLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            print("location: \(location)")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error:: \(error.localizedDescription)")
    }
}

extension AddressViewController: HandleMapSearch {
    func dropPinZoomIn(placemark: MKPlacemark) {
        // cache the pin
        selectedPin = placemark
        // clear existing pins
        mapView.removeAnnotations(mapView.annotations)
        let annotation = MKPointAnnotation()
        annotation.coordinate = placemark.coordinate
        annotation.title = placemark.name
        if let city = placemark.locality,
            let address = placemark.thoroughfare {
            annotation.subtitle = "\(city), \(address)"
        }
        mapView.addAnnotation(annotation)
        let span = MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
        let region = MKCoordinateRegion(center: placemark.coordinate, span: span)
        mapView.setRegion(region, animated: true)
        
        view.addSubview(contentView)
        contentView.addSubview(selectButton)
        
        selectButton.addTarget(self, action: #selector(selectButtonClicked), for: .touchUpInside)
        
        let guide = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.useAndActivateConstraints(constraints: [
            contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            contentView.topAnchor.constraint(equalTo: selectButton.topAnchor, constant: -30),
            contentView.leftAnchor.constraint(equalTo: view.leftAnchor),
            contentView.rightAnchor.constraint(equalTo: view.rightAnchor),
            
            selectButton.heightAnchor.constraint(equalToConstant: 70),
            selectButton.bottomAnchor.constraint(equalTo: guide.bottomAnchor, constant: -20),
            selectButton.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10),
            selectButton.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10)
            ])
    }
}
