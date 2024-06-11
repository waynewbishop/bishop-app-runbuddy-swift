//
//  Date.swift
//  RunBuddyDemo
//
//  Created by Wayne Bishop on 6/4/24.
//

import Foundation

extension Date {
    func advanceDays(by days: Int) -> Date {
        return Calendar.current.date(byAdding: .day, value: days, to: self) ?? self
    }
    
    func extractTime() -> String {
           let formatter = DateFormatter()
           formatter.dateFormat = "HH:mm:ss" // Set the desired time format
           return formatter.string(from: self)
    }
    
    func isDateAfterToday() -> Bool {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        
        if self >= today {
            return true
        } else {
            return false
        }
    }
    
    func toString(formatString: String = "yyyy-MM-dd HH:mm:ss", timeZone: TimeZone = .current) -> String {
       let formatter = DateFormatter()
       formatter.dateFormat = formatString
       formatter.timeZone = timeZone
        
       return formatter.string(from: self)
    }
       
   static func fromUTCString(_ dateString: String, formatString: String = "yyyy-MM-dd HH:mm:ss Z") -> Date? {
       let formatter = DateFormatter()
       formatter.dateFormat = formatString
       formatter.timeZone = TimeZone(abbreviation: "UTC")
       
       return formatter.date(from: dateString)
   }
    
    
}
