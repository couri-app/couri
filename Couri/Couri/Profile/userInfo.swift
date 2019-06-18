//
//  userInfo.swift
//  Couri
//
//  Created by David Chen on 6/11/19.
//  Copyright © 2019 Couri. All rights reserved.
//

import Foundation
import UIKit

class User: NSObject {
    var userFullName: String
    var userHomeAddress: String?
    var userBalance: Double
    var userIsCourier: Bool
    var favorites: [Restaurant] = []
    var deliveryCount: Int = 0
    var courierRating: Double
    var image: UIImage
    
    init(userFullName: String, userHomeAddress: String?, userBalance: Double, userIsCourier: Bool, courierRating: Double, image: UIImage) {
        self.userFullName = userFullName
        self.userHomeAddress = userHomeAddress
        self.userBalance = userBalance
        self.userIsCourier = userIsCourier
        self.courierRating = courierRating
        self.image = image
    }
    
    func addFavorite(restaurant: Restaurant) {
        self.favorites.append(restaurant)
    }
    
    func removeFavorite(restaurant: Restaurant) {
        var newFavorites = [Restaurant]()
        for r in favorites {
            if r !== restaurant {
                newFavorites.append(r)
                newFavorites = favorites
            }
        }
    }
}

struct UserInfo {
    let userInfo = User(userFullName: "Tony Xu", userHomeAddress: "2401 Durant", userBalance: 10.00, userIsCourier: true, courierRating: 4.9, image: #imageLiteral(resourceName: "Tony Xu"))
}
