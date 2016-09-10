//
//  MainModel.swift
//  BeThere
//
//  Created by jared weinstein on 9/10/16.
//  Copyright © 2016 Jared Weinstein. All rights reserved.
//

import Foundation
import CoreLocation
import Alamofire

class MainModel {
    static var user : User = MainModel.getUserInfo()
    static var events : [Event] = [] {
        didSet{
            NSLog("Event list changed n=\(events.count)")
            //Notification on changed
        }
    }
    
    
    //TODO: Switch to async request call on login.
    class func getUserInfo() -> User {
        let user = User()
        user.name = "Annie Chen"
        user.moneyDonated = 24.40
        user.points = 140
        user.streak = 12
        user.daysOnTime = 29
        user.daysLate = 3
        events = getEvents()
        return user
    }
    
    //TODO: Switch to async request call on login
    class func getEvents() -> [Event] {
        Alamofire.request(.GET, "https://")
            .responseJSON { response in
                if response.result.isFailure {
                    print("\(response.result.error!.description)")
                    return
                }
                
                if let resp = response.response, let json = (response.result.value) as? NSDictionary {
                    NSLog(String(json))
                    switch resp.statusCode {
                    case 200:
                        
                        return
                    case 400:
                        return
                    default:
                        print("Get status code \(resp.statusCode)")
                    }
                }
        }
        let loc  = CLLocation.init(latitude: 42.234, longitude: 102.4812)
        let event1 = Event(name: "Go to Bed", location: loc, locationName: "Home", repeatData: [.Monday: [NSDate()]], endDate: NSDate())
        let event2 = Event(name: "Get To Class", location: loc, locationName: "WLH 140", repeatData: [.Monday: [NSDate()]], endDate: NSDate())
        return [event1, event2]
    }
}
