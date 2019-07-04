//
//  ShopHomeViewController.swift
//  Couri
//
//  Created by David Chen on 6/28/19.
//  Copyright © 2019 Couri. All rights reserved.
//

import UIKit
import Firebase
import FirebaseUI
import FirebaseAuth
import Foundation
import CoreData

class HomeViewController: UIViewController, FUIAuthDelegate, RestaurantSegueDelegate, CheckoutDelegate {
    
    fileprivate(set) var auth:Auth?
    fileprivate(set) var authUI: FUIAuth?
    fileprivate(set) var authStateListenerHandle: AuthStateDidChangeListenerHandle?
    
    @IBAction func unwindSegueToRestaurant(segue: UIStoryboardSegue) {}
    
    var restaurantLibrary = RestaurantLibrary()
    var selectedIndex = 0
    var itemOrderArray: [ItemOrder]?
    let checkoutView = CheckoutView()
    
    override func viewWillAppear(_ animated: Bool) {
        setupViews()
        checkoutView.delegate = self
        //setupFirebase()
        displayShopViewController()
        setupFetchRequest()
        displayCheckoutView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        shopViewController.restaurantSegueDelegate = self
    }
    
    let deliverViewController = DeliverViewController()
    let shopViewController = ShopViewController()
    let sidebarLauncher = SidebarLauncher()
    let userInfo = UserInfo().userInfo
    var isShop = true
    
    let cardView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.layer.cornerRadius = 20
        return view
    }()
    
    let switchView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "honeyYellow")
        view.frame = CGRect(x: 0, y: 0, width: 50, height: 200)
        view.layer.cornerRadius = view.frame.width / 2
        return view
    }()
    
    let switchButton: UIView = {
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: 46, height: 200)
        view.layer.cornerRadius = view.frame.width / 2
        view.backgroundColor = UIColor.white
        return view
    }()
    
    let shopLabel: UILabel = {
        let label = UILabel()
        label.text = "SHOP"
        label.font = UIFont(name: "AvenirNext-Regular", size: 60)
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Enjoy deliveries from nearby Couriers"
        label.font = UIFont(name: "AvenirNext-Medium", size: 16)
        label.textColor = UIColor.gray.withAlphaComponent(0.7)
        return label
    }()
    
    let balanceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AvenirNext-Medium", size: 16)
        label.backgroundColor = UIColor(named: "honeyYellow")
        label.layer.cornerRadius = 3
        label.layer.masksToBounds = true
        return label
    }()
    
    let hamburgerButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "hamburgerMenu"), for: .normal)
        button.frame.size = CGSize(width: 50, height: 50)
        return button
    }()
    
    func setupFetchRequest() {
        let fetchRequest: NSFetchRequest<ItemOrder> = ItemOrder.fetchRequest()
        do {
            let itemOrderArray = try PersistenceService.context.fetch(fetchRequest)
            self.itemOrderArray = itemOrderArray
        } catch {}
    }
    
    func goToCheckout() {
        performSegue(withIdentifier: "homeToCheckout", sender: self)
    }
    
    func displayCheckoutView() {
        if (itemOrderArray?.count)! > 0 {
            checkoutView.show()
        }
    }
    
    func displayDeliverViewController() {
        view.addSubview(deliverViewController.view)
        deliverViewController.didMove(toParent: self)
        shopViewController.view.removeFromSuperview()
        shopViewController.removeFromParent()
        deliverViewController.restaurantCollectionView.reloadData()
        
        shopLabel.text = "DELIVER"
        shopLabel.textColor = UIColor(named: "honeyYellow")
        cardView.backgroundColor = UIColor(named: "darkMode")
        cardView.layer.shadowOpacity = 0.4
        
        descriptionLabel.text = "Deliver to nearby customers"
        descriptionLabel.textColor = UIColor.white
        
        NSLayoutConstraint.useAndActivateConstraints(constraints: [
            deliverViewController.view.topAnchor.constraint(equalTo: cardView.bottomAnchor, constant: 10),
            deliverViewController.view.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 10),
            deliverViewController.view.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            deliverViewController.view.rightAnchor.constraint(equalTo: self.view.rightAnchor)
            ])
        
        view.backgroundColor = UIColor(named: "darkMode")
    }
    
    func removeDeliveryViewController() {
        deliverViewController.willMove(toParent: nil)
        deliverViewController.view.removeFromSuperview()
        deliverViewController.removeFromParent()
        
        view.backgroundColor = .white
        displayShopViewController()
    }
    
    func displayShopViewController() {
        view.addSubview(shopViewController.view)
        shopLabel.text = "SHOP"
        shopLabel.textColor = UIColor.black
        cardView.backgroundColor = UIColor.white
        cardView.layer.shadowOpacity = 0.1
        descriptionLabel.text = "Enjoy deliveries from nearby Couriers"
        descriptionLabel.textColor = UIColor.gray.withAlphaComponent(0.7)
        shopViewController.restaurantsTableView.reloadData()
        
        NSLayoutConstraint.useAndActivateConstraints(constraints: [
            shopViewController.view.topAnchor.constraint(equalTo: cardView.bottomAnchor, constant: 10),
            shopViewController.view.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 10),
            shopViewController.view.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            shopViewController.view.rightAnchor.constraint(equalTo: self.view.rightAnchor)
            ])
    }
    
    let restaurantDVC = RestaurantDetailViewController()
    
    func segue(index: Int) {
        selectedIndex = index
        self.performSegue(withIdentifier: "showrestaurantdetail", sender: self)
        print(index)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? RestaurantDetailViewController {
            destination.restaurant = restaurantLibrary.restaurants[selectedIndex]
        }
    }
    
    @objc func loginAction(sender: AnyObject) {
        //        Present the default login view controller provided by authUI
        //        **DAVID IF YOU WANT TO CHANGE THE AUTHUI TO DO YOUR THING, ITS HERE!!**
        
        let authViewController = authUI?.authViewController()
        self.present(authViewController!, animated: true, completion: nil)
    }
    
    @objc func handleMore() {
        sidebarLauncher.showSidebar()
    }
    
    @objc func switchWasSelected() {
        let impactFeedbackGenerator = UIImpactFeedbackGenerator(style: .heavy)
        impactFeedbackGenerator.prepare()
        if isShop {
            let height = switchView.frame.height - switchButton.frame.height - 7
            UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 3, initialSpringVelocity: 1, options: [], animations: {
                self.switchButton.transform = CGAffineTransform(translationX: 0, y: height)
            })
            displayDeliverViewController()
            impactFeedbackGenerator.impactOccurred()
            isShop = false
        } else {
            UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 3, initialSpringVelocity: 1, options: [], animations: {
                self.switchButton.transform = CGAffineTransform(translationX: 0, y: 0)
            })
            removeDeliveryViewController()
            impactFeedbackGenerator.impactOccurred()
            isShop = true
        }
    }
    
    func setupFirebase() {
        //Authentication code to set up UI, must be done before we get to any other part of the app
        self.auth = Auth.auth()
        self.authUI = FUIAuth.defaultAuthUI()
        self.authUI?.delegate = self
        
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
        
        //This detects any changes in authentication, and if a change is detected then it will summon the authentication ui.
        self.authStateListenerHandle = self.auth?.addStateDidChangeListener {
            (auth, user) in guard user != nil else {
                self.loginAction(sender: self)
                return
            }
        }
        let providers: [FUIAuthProvider] = [ FUIEmailAuth(), FUIGoogleAuth() ]
        
        //Sets the authUI providers as the providers listed above
        self.authUI?.providers = providers
    }
    
    func addShadowToView(view: UIView, opacity: Double, radius: Int) {
        view.layer.shadowRadius = CGFloat(radius)
        view.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        view.layer.shadowOffset = CGSize(width: 0, height: 0)
        view.layer.shadowOpacity = Float(CGFloat(opacity))
    }
    
    func setupViews() {
        let guide = view.safeAreaLayoutGuide
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(switchWasSelected))
        swipeUp.direction = .up
        switchButton.addGestureRecognizer(swipeUp)
        
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(switchWasSelected))
        swipeDown.direction = .down
        switchButton.addGestureRecognizer(swipeDown)
        
        view.addSubview(cardView)
        view.addSubview(switchView)
        view.addSubview(switchButton)
        view.addSubview(shopViewController.view)
        view.addSubview(hamburgerButton)
        
        cardView.addSubview(shopLabel)
        cardView.addSubview(descriptionLabel)
        cardView.addSubview(balanceLabel)
        
        addShadowToView(view: switchButton, opacity: 0.2, radius: 3)
        addShadowToView(view: cardView, opacity: 0.1, radius: 10)
        
        switchButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(switchWasSelected)))
        switchView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(switchWasSelected)))
        hamburgerButton.addTarget(self, action: #selector(handleMore), for: .touchUpInside)
        
        balanceLabel.text = " Balance: $\(String(format: "%.2f", (userInfo.userBalance))) "
        
        NSLayoutConstraint.useAndActivateConstraints(constraints: [
            hamburgerButton.topAnchor.constraint(equalTo: guide.topAnchor, constant: 10),
            hamburgerButton.leadingAnchor.constraint(equalTo: cardView.leadingAnchor),
            
            cardView.topAnchor.constraint(equalTo: guide.topAnchor, constant: 50),
            cardView.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: 10),
            cardView.rightAnchor.constraint(equalTo: switchView.leftAnchor, constant: -10),
            cardView.bottomAnchor.constraint(equalTo: switchView.bottomAnchor),
            
            shopLabel.topAnchor.constraint(equalTo: cardView.topAnchor),
            shopLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 8),
            
            descriptionLabel.topAnchor.constraint(equalTo: shopLabel.bottomAnchor, constant: -10),
            descriptionLabel.leadingAnchor.constraint(equalTo: shopLabel.leadingAnchor, constant: 4),
            descriptionLabel.rightAnchor.constraint(equalTo: cardView.rightAnchor, constant: 10),
            
            balanceLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 10),
            balanceLabel.leadingAnchor.constraint(equalTo: shopLabel.leadingAnchor, constant: 4),
            
            switchView.topAnchor.constraint(equalTo: guide.topAnchor, constant: 10),
            switchView.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: -10),
            switchView.widthAnchor.constraint(equalToConstant: 50),
            switchView.heightAnchor.constraint(equalToConstant: 180),
            
            switchButton.topAnchor.constraint(equalTo: switchView.topAnchor, constant: 3),
            switchButton.heightAnchor.constraint(equalToConstant: switchView.frame.height / 2),
            switchButton.leftAnchor.constraint(equalTo: switchView.leftAnchor, constant: 3),
            switchButton.rightAnchor.constraint(equalTo: switchView.rightAnchor, constant: -3)
            ])
    }
}
