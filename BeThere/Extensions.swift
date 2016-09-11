//
//  Extensions.swift
//  BeThere
//
//  Created by jared weinstein on 9/10/16.
//  Copyright © 2016 Jared Weinstein. All rights reserved.
//

import Foundation

extension String {
    func toDate() -> NSDate? {
        let format="yyyy-MM-dd'T'HH:mm:ss"
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = format
        let date = dateFormatter.dateFromString(self)
        return date
    }
}

extension NSDate {
    func currentDateInDayMonthYear() -> String {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "dd MM yyyy"
        return dateFormatter.stringFromDate(self)
    }
    
    //11:35 AM
    func timeOfDayStringN() -> String {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "h:mm \na"
        dateFormatter.AMSymbol = "AM"
        dateFormatter.PMSymbol = "PM"
        return dateFormatter.stringFromDate(self)
    }
    
    func timeOfDayString() -> String {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "h:mm a"
        dateFormatter.AMSymbol = "AM"
        dateFormatter.PMSymbol = "PM"
        return dateFormatter.stringFromDate(self)
    }
    
    func shortDate() -> String {
        return "MON"
    }
}

