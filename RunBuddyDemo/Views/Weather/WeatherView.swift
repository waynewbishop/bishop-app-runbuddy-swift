//
//  WeatherTest.swift
//  RunBuddyDemo
//
//  Created by Wayne Bishop on 5/29/24.
//

import SwiftUI
import CoreLocation
import Charts


struct WeatherView: View {
    
    @State var targetForecasts: [ForecastData]?
    @State var weatherEngine = WeatherEngine()
    
    //these values will be overriden
    @State var location = CLLocationCoordinate2D(latitude: 38.0832, longitude: -122.7282)
    @State var targetDate = "2024-06-01"
    
    var body: some View {
        
        VStack {
            
        }
        .onAppear() {
            self.weatherForecastData()
        }
        
    }
    
    
    
    private func weatherForecastData() {
        Task {
            do {
                let forecastResponse = try await weatherEngine.fetchFiveDayForecast(for: location)
                
                //process collection data on the main thread
                DispatchQueue.main.async {
                    targetForecasts = weatherEngine.filterHourlyForecasts(forecastResponse, targetDate: targetDate)
                    
                    if let forecasts = targetForecasts {
                        print(forecasts.description)
                    }
                }
                
            } catch {
                print("Error: \(error)")
            }
        } //end task
    }
    
}

#Preview {
    WeatherView()
}
