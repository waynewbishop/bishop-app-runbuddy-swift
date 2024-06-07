//
//  String.swift
//  RunBuddyDemo
//
//  Created by Wayne Bishop on 6/4/24.
//

import Foundation

extension String {
    
    //present date in long string format    
    var headingDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        guard let date = formatter.date(from: self) else {
            return "Invalid Date"
        }
        
        formatter.dateFormat = "EEEE, MMMM d"
        return formatter.string(from: date)
    }
}

