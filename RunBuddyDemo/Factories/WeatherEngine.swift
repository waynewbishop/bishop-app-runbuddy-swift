//
//  WeatherEngine.swift
//  RunBuddyDemo
//
//  Created by Wayne Bishop on 5/22/24.
//

import Foundation

class WeatherEngine {
    
    func fetchForecastForDate(_ targetDate: String) async throws -> WeatherResponse {
        let apiKey = BuddyConfig.openWeatherApiKey
        let latitude = 40.7128
        let longitude = -74.0059
        let units = "metric"
        let apiUrl = "https://api.openweathermap.org/data/2.5/forecast?lat=\(latitude)&lon=\(longitude)&appid=\(apiKey)&units=\(units)"

        print(apiUrl)
        
        guard let url = URL(string: apiUrl) else {
            throw NSError(domain: "com.example.WeatherEngine", code: 1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
            throw NSError(domain: "com.example.WeatherEngine", code: 2, userInfo: [NSLocalizedDescriptionKey: "Server responded with an error"])
        }
        
        let forecastResponse = try JSONDecoder().decode(WeatherResponse.self, from: data)
        return forecastResponse
    }
    
    func processForecastForDate(_ forecastResponse: WeatherResponse, targetDate: String) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        if let targetForecast = forecastResponse.list.first(where: { forecast in
            let date = Date(timeIntervalSince1970: TimeInterval(forecast.dt))
            let formattedDate = formatter.string(from: date)
            return formattedDate == targetDate
        }) {
            print("Forecast for \(targetDate):")
            print("Temperature: \(targetForecast.main.temp)°C")
            print("Weather: \(targetForecast.weather.first?.main ?? "N/A")")
            print("Wind speed: \(targetForecast.wind.speed) m/s")
            // Access other properties as needed
        } else {
            print("No forecast data found for the target date.")
        }
    }
}

/*
// Usage example
let weatherEngine = WeatherEngine()
let targetDate = "2024-05-25"

Task {
    do {
        let forecastResponse = try await weatherEngine.fetchForecastForDate(targetDate)
        weatherEngine.processForecastForDate(forecastResponse, targetDate: targetDate)
    } catch {
        print("Error: \(error)")
    }
}
*/

