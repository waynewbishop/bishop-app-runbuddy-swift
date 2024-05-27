//
//  AnalysisView.swift
//  RunBuddyDemo
//
//  Created by Wayne Bishop on 5/24/24.
//

import SwiftUI

struct AnalysisView: View {
    
    @State var targetForecast: ForecastData?
    
    //TODO: information recieved as a single prompt request (struct) or as loose parameters
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        
        Button("Check the weather forecast..") {
            // Usage example
            let weatherEngine = WeatherEngine()
            let targetDate = "2024-05-27"

            Task {
                do {
                    
                    //1: Run weather forecast - private function
                    let forecastResponse = try await weatherEngine.fetchForecastForDate(targetDate)
                    targetForecast = weatherEngine.processForecastForDate(forecastResponse, targetDate: targetDate)
                    
                    //2: Run gemini analysis - second private function
                    
                    if let forecast  = targetForecast {
                        print("Target Date: \(targetDate)")
                        print("City: \(forecastResponse.city.name)")
                        print("Temperature: \(forecast.main.temp.roundedNearest)°F")
                        print("Feels like: \(forecast.main.feels_like.roundedNearest)°F")
                        print("High: \(forecast.main.temp_max.roundedNearest)")
                        print("Low: \(forecast.main.temp_min.roundedNearest)")
                        print("Humidity: \(forecast.main.humidity)%")
                        print("Weather: \(forecast.weather.first?.main ?? "N/A")")
                        print("Weather Details: \(forecast.weather.first?.description ?? "N/A")")
                        print("Weather Icon: \(forecast.weather.first?.icon ?? "N/A")")
                        print("Wind speed: \(forecast.wind.speed.roundedNearest) mph")
                        print("Gusts: \(forecast.wind.gust.roundedNearest) mph")
                    }
                    
                } catch {
                    print("Error: \(error)")
                }
            } //end task
        }
    }
}



#Preview {
    AnalysisView()
}
