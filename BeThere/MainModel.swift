//
//  MainModel.swift
//  BeThere
//
//  Created by jared weinstein on 9/10/16.
//  Copyright © 2016 Jared Weinstein. All rights reserved.
//

import Foundation

class MainModel {
    static var user : User = MainModel.getUserInfo()
    static var events : [Event] = []
    
    
    //TODO: Switch to async request call on login.
    class func getUserInfo() -> User {
        let user = User()
        user.name = "Annie Chen"
        user.moneyDonated = 24.40
        user.points = 140
        user.streak = 12
        user.daysOnTime = 29
        user.daysLate = 3
        return user
    }
}
