//
//  DataModels.swift
//  BeThere
//
//  Created by jared weinstein on 9/10/16.
//  Copyright © 2016 Jared Weinstein. All rights reserved.
//

import Foundation
import MapKit

enum WeekDay {
    case Monday
    case Tuesday
    case Wednesday
    case Thursday
    case Friday
    case Saturday
    case Sunday
}


class Event {
    var id : String!
    var name : String!
    var location : CLLocation!
    var locationString : String!
    var dayRepeat : [WeekDay : [NSDate]]!
    var endDate : NSDate?
    var reminder : Int? //number of minutes before start when reminder
    var multiplier : Double = 1.0
    var streak : Int = 0
    var moneyDonated : Double = 0.0
    var daysOnTime : Int = 0
    var daysLate : Int = 0
    
    init(name: String, location: CLLocation, locationName: String, repeatData: [WeekDay : [NSDate]], endDate: NSDate?) {
        self.name = name
        self.location = location
        self.dayRepeat = repeatData
        self.endDate = endDate
    }
}

class User {
    var name : String = "John Doe"
    var moneyDonated : Double = 0.0
    var points : Int = 0
    var streak : Int = 0
    var daysOnTime : Int = 0
    var daysLate : Int = 0
}
