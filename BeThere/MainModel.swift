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
            NSNotificationCenter.defaultCenter().postNotificationName("eventsUpdated", object: nil)
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
        loadEvents()
        return user
    }
    
    //TODO: Switch to async request call on login
    class func loadEvents() {
        Alamofire.request(.GET, "https://still-sea-12039.herokuapp.com/events")
            .responseJSON { response in
                if response.result.isFailure {
                    print("\(response.result.error!.description)")
                    return
                }
                
                if let resp = response.response, let jsonArray = (response.result.value) as? [NSDictionary] {
                    switch resp.statusCode {
                    case 200:
                        print(String(jsonArray))
                        for event in jsonArray {
                            let id = event["id"] as! String
                            let name = event["name"] as! String
                            let recurringEventColor = event["recurring_event_color"] as! Int
                            let startTime = (event["start_time"] as! String).toDate()
                            let locationName = event["location_name"] as! String
                            let locationDict = event["location"] as! NSDictionary
                            let latitude = locationDict["latitude"] as! Double
                            let longitude = locationDict["longitude"] as! Double
                            let location = CLLocation(latitude: latitude, longitude: longitude)
                            
                            let newEvent = Event(id: id, name: name, location: location, locationName: locationName, startDate: startTime!)
                            newEvent.color = recurringEventColor
                            
                            self.events.append(newEvent)
                            
                        }
                        
                        return
                    case 400:
                        return
                    default:
                        print("Get status code \(resp.statusCode)")
                    }
                }
        }
        //let loc  = CLLocation.init(latitude: 42.234, longitude: 102.4812)
        //let event1 = Event(name: "Go to Bed", location: loc, locationName: "Home", repeatData: [.Monday: [NSDate()]], endDate: NSDate())
        //let event2 = Event(name: "Get To Class", location: loc, locationName: "WLH 140", repeatData: [.Monday: [NSDate()]], endDate: NSDate())
        //return [event1, event2]
    }
}
