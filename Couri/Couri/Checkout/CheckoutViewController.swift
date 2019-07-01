//
//  CheckoutViewController.swift
//  Couri
//
//  Created by David Chen on 6/29/19.
//  Copyright © 2019 Couri. All rights reserved.
//

import UIKit
import CoreData

class CheckoutViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var itemOrderArray: [ItemOrder]?
    let cellID = "checkoutCellID"
    
    var subtotal = 0.0
    var quantity = 0
    var time = 5
    var deliveryFee = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupFetchRequest()
        handlePricing()
        calculateOrder(price: subtotal, quantity: quantity, time: time)
    }
    
    let checkoutTableView = UITableView()
    
    let backwardsButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "xout"), for: .normal)
        button.frame.size = CGSize(width: 30, height: 30)
        return button
    }()
    
    let contentView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.layer.cornerRadius = 20
        return view
    }()
    
    let subtotalView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        return view
    }()
    
    let subtotalLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AvenirNext-Medium", size: 16)
        label.text = "Subtotal"
        return label
    }()
    
    let taxLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AvenirNext-Medium", size: 16)
        label.text = "Tax"
        return label
    }()
    
    let deliveryLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AvenirNext-Medium", size: 16)
        label.text = "Delivery"
        return label
    }()
    
    let subtotalPriceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AvenirNext-Medium", size: 16)
        label.text = "0.00"
        return label
    }()
    
    let taxPriceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AvenirNext-Medium", size: 16)
        label.text = "0.00"
        return label
    }()
    
    let deliveryPriceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AvenirNext-Medium", size: 16)
        label.text = "0.00"
        return label
    }()
    
    let clearAllDataButton: UIButton = {
        let button = UIButton()
        button.setTitle("Clear All", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        return button
    }()
    
    let checkoutLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AvenirNext-Bold", size: 25)
        label.text = "CHECKOUT"
        return label
    }()
    
    let checkoutStrip: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "honeyYellow")
        view.layer.cornerRadius = 1
        return view
    }()
    
    let checkoutButton: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "honeyYellow")
        view.layer.cornerRadius = 5
        return view
    }()
    
    let checkoutButtonLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AvenirNext-Medium", size: 16)
        return label
    }()
    
    let checkoutPriceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AvenirNext-Medium", size: 16)
        label.text = "0.00"
        return label
    }()
    
    @objc func purgeAllData() {
        let fetchRequest: NSFetchRequest<ItemOrder> = ItemOrder.fetchRequest()
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest as! NSFetchRequest<NSFetchRequestResult>)
        do {
            try PersistenceService.context.execute(deleteRequest)
        } catch {}
        
        itemOrderArray?.removeAll()
        checkoutTableView.reloadData()
        subtotal = 0
        quantity = 0
        calculateOrder(price: subtotal, quantity: quantity, time: time)
        deliveryFee = 0
        deliveryPriceLabel.text = "$\(String(format: "%.2f", deliveryFee))"
        checkoutPriceLabel.text = "$\(String(format: "%.2f", 0))"
    }
    
    func setupFetchRequest() {
        let fetchRequest: NSFetchRequest<ItemOrder> = ItemOrder.fetchRequest()
        do {
            let itemOrderArray = try PersistenceService.context.fetch(fetchRequest)
            self.itemOrderArray = itemOrderArray
            self.checkoutTableView.reloadData()
        } catch {}
    }
    
    let checkoutView = CheckoutView()
    
    @objc func showCheckout() {
        checkoutView.show()
    }
}

extension CheckoutViewController {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count = itemOrderArray?.count {
            return count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = checkoutTableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! OrderCell
        cell.itemOrder = itemOrderArray?[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "backtomenu", sender: self)
    }
}

class BottomToTopSegue: UIStoryboardSegue {
    override func perform() {
        destination.transitioningDelegate = self as? UIViewControllerTransitioningDelegate
        destination.modalPresentationStyle = .overFullScreen
        source.present(destination, animated: true, completion: nil)
    }
}
