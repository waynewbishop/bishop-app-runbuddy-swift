//
//  WeatherEngine.swift
//  RunBuddyDemo
//
//  Created by Wayne Bishop on 5/22/24.
//

import Foundation
import SwiftUI
import CoreLocation

class WeatherEngine: ObservableObject {
    
    
    /// Retrieves the weather forecast for the next 5 days
    /// - Parameters:
    ///   - location: The location latitude and longitude
    func fetchFiveDayForecast(for location: CLLocationCoordinate2D) async throws -> WeatherResponse {
        
        let apiKey = BuddyConfig.openWeatherApiKey
        let latitude = location.latitude
        let longitude = location.longitude
        let units = "imperial"
        var apiUrl = "https://api.openweathermap.org/data/2.5/forecast"
        
        //add specified parameters
        apiUrl += "?lat=\(latitude)&lon=\(longitude)&appid=\(apiKey)&units=\(units)"
        print(apiUrl)
        
        guard let url = URL(string: apiUrl) else {
            throw NSError(domain: "openweatherapi.org", code: 1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])
        }

        //obtain data and response tuple
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
            throw NSError(domain: "openweatherapi.org", code: 2,
                          userInfo: [NSLocalizedDescriptionKey: "Remote server responded with an error"])
        }

        //process the response..
        let forecastResponse = try JSONDecoder().decode(WeatherResponse.self, from: data)
        return forecastResponse
    }
    
        
    
    //obtain the daily weather estimates (three for any specific date)
    func filterHourlyForecasts(_ forecastResponse: WeatherResponse, targetDate: String) -> [ForecastData]? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        let targetForecasts = forecastResponse.list.filter { forecast in
                    let date = Date(timeIntervalSince1970: TimeInterval(forecast.dt))
                    let formattedDate = formatter.string(from: date)
                    return formattedDate == targetDate
        }
        
        if !targetForecasts.isEmpty {
            return targetForecasts
        }
        else {
            print("No forecast data found for this target date..")
            return nil
        }

    }
    

    
    /// Provides image representation for Openweather API icon codes.
    /// - Parameter iconCode: Openweather weather string representations
    /// - Returns: SwiftUI image.
    func getWeatherIcon(iconCode: String) -> Image {
        switch iconCode {
        case "01d":
            return Image(systemName: "sun.max")
        case "01n":
            return Image(systemName: "moon")
        case "02d":
            return Image(systemName: "cloud.sun")
        case "02n":
            return Image(systemName: "cloud.moon")
        case "03d", "03n":
            return Image(systemName: "cloud")
        case "04d", "04n":
            return Image(systemName: "cloud.fill")
        case "09d", "09n":
            return Image(systemName: "cloud.drizzle")
        case "10d", "10n":
            return Image(systemName: "cloud.rain")
        case "11d", "11n":
            return Image(systemName: "cloud.bolt")
        case "13d", "13n":
            return Image(systemName: "cloud.snow")
        case "50d", "50n":
            return Image(systemName: "cloud.fog")
        default:
            return Image(systemName: "questionmark.circle")
        }
    }
}

