//
//  WeatherModel.swift
//  RunBuddyDemo
//
//  Created by Wayne Bishop on 4/19/24.
//

import Foundation
import CoreLocation

class WeatherModel {
    
    //TODO: This is where we will obtain and store all the weather specific information from the OpenWeatherAPI.
    //This is where we will call the OpenWeatherAPI
    
    //example of how to obtain altitude for prompt analysis
    func getAltitude() {

        let latitude = 37.7749 // Example latitude value
        let longitude = -122.4194 // Example longitude value

        // Create a CLLocation object
        let myLocation = CLLocation(latitude: latitude, longitude: longitude)
        let altitude = myLocation.altitude
        
        print("altitude of coordinates is: \(altitude)")
    }
}


