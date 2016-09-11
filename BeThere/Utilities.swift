//
//  Utilities.swift
//  BeThere
//
//  Created by jared weinstein on 9/10/16.
//  Copyright © 2016 Jared Weinstein. All rights reserved.
//

import Foundation

struct GlobalKeys {
    static let website = "https://still-sea-12039.herokuapp.com"
    static let dennis = "https://10.103.231.83:5000"
}

class Utilities {
    static func eventsForDay(date: NSDate = NSDate(), events: [Event] = MainModel.events) -> [Event]{
        var returnedEvents : [Event] = []
        for event in events {
            if event.startDate.currentDateInDayMonthYear() == date.currentDateInDayMonthYear() {
                returnedEvents.append(event)
            }
        }
        return returnedEvents
    }
    
    static func eventsWithName(name: String, events: [Event] = MainModel.events) -> [Event]{
        var returnedEvents : [Event] = []
        for event in events {
            if event.name == name {
                returnedEvents.append(event)
            }
        }
        return returnedEvents
    }
    
    static func getURL() -> String {
        return GlobalKeys.website
    }
}
