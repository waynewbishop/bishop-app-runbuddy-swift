//
//  Double.swift
//  RunBuddyDemo
//
//  Created by Wayne Bishop on 5/24/24.
//

import Foundation

extension Double {
    /// Rounds the double to the specified number of decimal places.
    ///
    /// - Parameter decimalPlaces: The number of decimal places to round to. If `decimalPlaces` is 0, the value is rounded to the nearest whole number (`Int`).
    /// - Returns: The rounded value.
    func rounded(to decimalPlaces: Int) -> Double {
        let multiplier = pow(10.0, Double(decimalPlaces))
        return (self * multiplier).rounded() / multiplier
    }
    
    /// Rounds the double to the nearest whole number, removing the ".0" if present.
    var roundedNearest: Int {
        return Int(rounded(to: 0))
    }
}
