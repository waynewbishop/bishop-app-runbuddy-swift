//
//  WeatherUI.swift
//  RunBuddyDemo
//
//  Created by Wayne Bishop on 5/24/24.
//

import Foundation


/// Acts as the container for presentation layer for weather information
struct WeatherSummary {
        
    let targetDate: String = ""
    let city: String = ""
    let temp: Int = 0
    let temp_high: Int = 0
    let temp_low: Int = 0
    let humidity: Int = 0 //expressed as percentage %
    let weather: String = ""
    let weather_description: String = ""
    let weather_icon: String = ""
    let wind_speed: Int = 0 //expressed in mph
    let wind_gusts: Int = 0 //expressed in mph
    
}
