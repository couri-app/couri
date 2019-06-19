//
//  ViewController.swift
//  Couri
//
//  Created by Jai Bansal on 5/28/19.
//  Copyright © 2019 Couri. All rights reserved.
//

import UIKit
import Firebase
import FirebaseUI
import FirebaseAuth

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, TransferSelectionDelegate, FUIAuthDelegate {
    
    fileprivate(set) var auth:Auth?
    fileprivate(set) var authUI: FUIAuth?
    fileprivate(set) var authStateListenerHandle: AuthStateDidChangeListenerHandle?
    
    func goToNextScene() {
        performSegue(withIdentifier: "Transfer", sender: self)
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    var restaurantLibrary = RestaurantLibrary()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return restaurantLibrary.restaurants.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RestaurantCell", for: indexPath) as! RestaurantCell
        let currentRestaurant = restaurantLibrary.restaurants[indexPath.row]
        cell.restaurantView.restaurant = currentRestaurant
        cell.layer.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "MainShowDetail", sender: self)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 350
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? RestaurantDetailViewController {
            destination.restaurant = restaurantLibrary.restaurants[(tableView.indexPathForSelectedRow?.row)!]
        }
    }

    //Top layer buttons
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var shopView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var balanceLabel: UILabel!
    
    //Breadcrumb trail outlets
    @IBOutlet weak var restaurantBreadcrumb: UIView!
    @IBOutlet weak var orderBreadcrumb: UIView!
    @IBOutlet weak var registerBreadcrumb: UIView!
    @IBOutlet weak var courierBreadcrumb: UIView!
    
    //Restaurant UIView containing Restaurant Table View
    @IBOutlet weak var restaurantUIView: UIView!
    @IBOutlet weak var restaurantLabel: UILabel!
    @IBOutlet weak var nextPageButton: UIButton!
    
    public var isOn = true
    
    //Created a function that adds shadows the UIViews for my own ease of use
    func addShadowToView(view: UIView, opacity: Double, radius: Int) {
        view.layer.shadowRadius = CGFloat(radius)
        view.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        view.layer.shadowOffset = CGSize(width: 0, height: 0)
        view.layer.shadowOpacity = Float(CGFloat(opacity))
    }
    
    //Created a function that adds shadows buttons for my own ease of use
    func addShadowToButton(button: UIButton, opacity: Double, radius: Int) {
        button.layer.shadowRadius = CGFloat(radius)
        button.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        button.layer.shadowOffset = CGSize(width: 0, height: 0)
        button.layer.shadowOpacity = Float(CGFloat(opacity))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Authentication code to set up UI, must be done before we get to any other part of the app
        self.auth = Auth.auth()
        self.authUI = FUIAuth.defaultAuthUI()
        self.authUI?.delegate = self
        
//        let firebaseAuth = Auth.auth()
//        do {
//            try firebaseAuth.signOut()
//        } catch let signOutError as NSError {
//            print ("Error signing out: %@", signOutError)
//        }
        
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
        
        //Button to expanded Restaurant View
        addShadowToButton(button: nextPageButton, opacity: 0.1, radius: 8)
        
        //Restaurant UIView Aesthetics
        restaurantUIView.layer.cornerRadius = 20
        addShadowToView(view: restaurantUIView, opacity: 0.1, radius: 10)
        restaurantLabel.numberOfLines = 0
        
        //Breadcrumb trail images (giving all of them a shadow)
        addShadowToView(view: restaurantBreadcrumb, opacity: 0.1, radius: 8)
        addShadowToView(view: orderBreadcrumb, opacity: 0.1, radius: 8)
        addShadowToView(view: registerBreadcrumb, opacity: 0.1, radius: 8)
        addShadowToView(view: courierBreadcrumb, opacity: 0.1, radius: 8)
        
        //Breadcrumb trail images (giving all of them a circular frame)
        let breadcrumbArray = [restaurantBreadcrumb, orderBreadcrumb, registerBreadcrumb, courierBreadcrumb]
        for view in breadcrumbArray {
            view?.layer.cornerRadius = (view?.frame.width)!/2
        }

        //Aesthetic settings upon start for various buttons
        addShadowToButton(button: button, opacity: 0.2, radius: 3)
        
        //Aesthetics for shop upon initialization
        shopView.layer.cornerRadius = 20
        addShadowToView(view: shopView, opacity: 0.1, radius: 10)
        
        //Aesthetics for balance label
        balanceLabel.layer.backgroundColor = #colorLiteral(red: 1, green: 0.8901960784, blue: 0.5490196078, alpha: 1)
        balanceLabel.layer.cornerRadius = 4
        balanceLabel.numberOfLines = 0
        
        sidebarLauncher.delegate = self
    }

    @IBAction func loginAction(sender: AnyObject) {
        //Present the default login view controller provided by authUI
        //**DAVID IF YOU WANT TO CHANGE THE AUTHUI TO DO YOUR THING, ITS HERE!!**
        let authViewController = authUI?.authViewController()
        self.present(authViewController!, animated: true, completion: nil)
    }
    
    @IBAction func down(_ sender: UIButton) {
        if isOn {
            UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 3, initialSpringVelocity: 1, options: [], animations: {
                self.button.transform = CGAffineTransform(translationX: 0, y: 90)
            })
            view.backgroundColor = #colorLiteral(red: 0.1764705882, green: 0.1921568627, blue: 0.2549019608, alpha: 1)
            titleLabel.text = "DELIVER"
            titleLabel.textColor = #colorLiteral(red: 1, green: 0.8901960784, blue: 0.5490196078, alpha: 1)
            shopView.backgroundColor = #colorLiteral(red: 0.1764705882, green: 0.1921568627, blue: 0.2549019608, alpha: 1)
            descriptionLabel.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            descriptionLabel.text = "Deliver to customers near you"
            descriptionLabel.numberOfLines = 0
            shopView.layer.shadowOpacity = 0.3
            isOn = !isOn
            
        } else {
            UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 3, initialSpringVelocity: 1, options: [], animations: {
                self.button.transform = CGAffineTransform(translationX: 0, y: 0)
            })
            titleLabel.text = "SHOP"
            titleLabel.textColor = #colorLiteral(red: 0.07881314767, green: 0.07881314767, blue: 0.07881314767, alpha: 1)
            shopView.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            descriptionLabel.textColor = #colorLiteral(red: 0.07881314767, green: 0.07881314767, blue: 0.07881314767, alpha: 1)
            descriptionLabel.text = "Enjoy deliveries from nearby Couriers"
            descriptionLabel.numberOfLines = 0
            shopView.layer.shadowOpacity = 0.1
            isOn = !isOn
        }
    }
    let sidebarLauncher = SidebarLauncher()
    
    func handleMore() {
        sidebarLauncher.showSidebar()
    }
    
    @IBAction func hamburgerMenu(_ sender: Any) {
        handleMore()
    }
}

class TransferVC: UIViewController {
    @IBOutlet weak var cancelTapped: UIButton!
    @IBAction func cancel(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}
