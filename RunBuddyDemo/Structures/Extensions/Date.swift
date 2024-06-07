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
    
    func isDateAfterToday() -> Bool {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        
        if self >= today {
            return true
        } else {
            return false
        }
    }
    
}
