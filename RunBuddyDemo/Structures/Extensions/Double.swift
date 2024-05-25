//
//  Double.swift
//  RunBuddyDemo
//
//  Created by Wayne Bishop on 5/24/24.
//

import Foundation

extension Double {
    /// Rounds the double to the nearest whole number, removing the ".0" if present.
    var roundedTo: Int {
        let fractionalPart = self.truncatingRemainder(dividingBy: 1.0)
        let roundedValue = fractionalPart >= 0.5 ? ceil(self) : floor(self)
        return Int(roundedValue)
    }
}
