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
