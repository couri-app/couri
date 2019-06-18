//
//  CourierView.swift
//  Couri
//
//  Created by David Chen on 6/9/19.
//  Copyright © 2019 Couri. All rights reserved.
//

import Foundation
import UIKit

// Restaurant class with the following parameters: number of couriers, name of restaurant, restaurant's categories, restaurant's description, front-page image for restaurant



class CourierView: UIView {
    @IBOutlet var courierView: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        Bundle.main.loadNibNamed("CourierView", owner: self, options: nil)
        courierView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(courierView)
        courierView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        courierView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        courierView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        courierView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
    
    @IBOutlet weak var courierName: UILabel!
    @IBOutlet weak var timeAway: UILabel!
    @IBOutlet weak var deliveriesMade: UILabel!
    @IBOutlet weak var courierImage: UIImageView!
    @IBOutlet weak var courierBackground: UIView!
    @IBOutlet weak var selectCourierButton: UIButton!
    
    
    //Connecting our Restaurant class's parameters to the outlets in the CourierView.xib file
    var courier: Courier! {
        didSet {
            courierName.text = courier.courierName
            courierBackground.layer.backgroundColor = courier.colorProfile
            courierBackground.layer.cornerRadius = courierBackground.frame.width/2
            deliveriesMade.text = "(\(String(courier.deliveriesMade)))"
            courierImage.image = courier.courierImage
            timeAway.text = String(courier.timeAway)
            
            //Aesthetics
            addShadowButton(button: selectCourierButton)
        }
    }
}

extension CourierView {
    // Gives shadow to argument: button
    func addShadowButton(button: UIButton) {
        button.layer.shadowRadius = 8
        button.layer.shadowColor = #colorLiteral(red: 0.07881314767, green: 0.07881314767, blue: 0.07881314767, alpha: 1)
        button.layer.shadowOffset = CGSize(width: 0, height: 0)
        button.layer.shadowOpacity = 0.1
        button.layer.shadowRadius = 10
    }
}

class Courier {
    var courierImage: UIImage
    var colorProfile: CGColor
    var courierName: String
    var ratingAverage: Double
    var timeAway: Int
    var deliveriesMade: Int
    
    init(courierImage: UIImage, colorProfile: CGColor, courierName: String, ratingAverage: Double, timeAway: Int, deliveriesMade: Int) {
        self.courierImage = courierImage
        self.colorProfile = colorProfile
        self.courierName = courierName.uppercased()
        self.ratingAverage = ratingAverage
        self.timeAway = timeAway
        self.deliveriesMade = deliveriesMade
    }
}

// Very simple struct for the array of Courier instances
struct CourierLibrary {
    var couriers: [Courier] = []
        
    init() {
        generateCourierLibrary()
    }
}


 //Extension of CourierLibrary struct that contains all of the relevant information.
extension CourierLibrary {
    mutating func generateCourierLibrary() {
        let courier1 = Courier(courierImage: #imageLiteral(resourceName: "Jess Icon"), colorProfile: #colorLiteral(red: 1, green: 0.5188116431, blue: 0.5348733068, alpha: 1), courierName: "Jess C.", ratingAverage: 4.8, timeAway: 30, deliveriesMade: 28)
        let courier2 = Courier(courierImage: #imageLiteral(resourceName: "David Icon"), colorProfile: #colorLiteral(red: 0.7290983796, green: 0.9907270074, blue: 0.7432793975, alpha: 1), courierName: "David C.", ratingAverage: 4.6, timeAway: 23, deliveriesMade: 20)
        let courier3 = Courier(courierImage: #imageLiteral(resourceName: "Jai Icon"), colorProfile: #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1), courierName: "Jai B.", ratingAverage: 4.7, timeAway: 21, deliveriesMade: 18)
        let courier4 = Courier(courierImage: #imageLiteral(resourceName: "Shrey Icon"), colorProfile: #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1), courierName: "Shrey V.", ratingAverage: 4.8, timeAway: 23, deliveriesMade: 17)
        let courier5 = Courier(courierImage: #imageLiteral(resourceName: "Tushar Icon"), colorProfile: #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1), courierName: "Tushar S.", ratingAverage: 4.5, timeAway: 34, deliveriesMade: 21)
        let courier6 = Courier(courierImage: #imageLiteral(resourceName: "Jamal Icon"), colorProfile: #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1), courierName: "Jamal J.", ratingAverage: 4.5, timeAway: 35, deliveriesMade: 20)
    
        couriers = [courier1, courier2, courier3, courier4, courier5, courier6]
    }
}

