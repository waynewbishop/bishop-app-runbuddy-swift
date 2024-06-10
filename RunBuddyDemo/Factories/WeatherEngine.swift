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
    
    var summary: String = ""
    var icon: Image = Image("")
    var high: Double = 0
    var low: Double = 0
    
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
        //print(apiUrl)
        
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
    
        
    
    //obtain the hourly weather forecast (up to eight entries for any target date)
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

    
    //provides the weather summary for the requested forecast
    func createWeatherSummary(with forecasts: [ForecastData]) {
        
        var temp_max: Double = 0
        var temp_min: Double = -100
        var weather_main = ""
        var wind: Double = 0
        var pop: Double = 0
        var humidity: Int = 0 
        var i: Int = 0
        
        for forecast in forecasts {
            
            //print(forecast.weather[0].icon)
            
            if forecast.main.temp_max > temp_max {
                temp_max = forecast.main.temp_max
                weather_main = forecast.weather[0].main
                icon = getWeatherIcon(for: forecast.weather[0].icon)
                high = forecast.main.temp_max
            }
            
            //additional logic for low temp
            if temp_min != -100 {
                if forecast.main.temp_min < temp_min {
                    temp_min = forecast.main.temp_min
                    low = forecast.main.temp_min
                }
            }
            else {
                temp_min = forecast.main.temp_min
                low = forecast.main.temp_min
            }
            
            if forecast.wind.speed > wind {
                wind = forecast.wind.speed
            }
                    
            if forecast.pop > pop {
                pop = forecast.pop
            }
            
            //calculate average humidity.
            i += 1
            
            if forecast.main.humidity > 0 {
                humidity += forecast.main.humidity
            }
            
        } //end for
        
        humidity = humidity / i 
        
        //provide a display summary
        self.summary = "\(weather_main). High of \(temp_max.roundedNearest)° and low of \(temp_min.roundedNearest)°. Wind gusts up to \(wind.roundedNearest) mph. Today, the average humidity is \(humidity)%. Chance of precipitation is \(pop * 100)%."
        
    }
    
    
    /// Provides image representation for Openweather API icon codes.
    /// - Parameter iconCode: Openweather weather string representations
    /// - Returns: SwiftUI image.
    func getWeatherIcon(for iconCode: String) -> Image {
        switch iconCode {
        case "01d":
            return Image(systemName: "sun.max.fill")
        case "01n":
            return Image(systemName: "moon.fill")
        case "02d":
            return Image(systemName: "cloud.sun.fill")
        case "02n":
            return Image(systemName: "cloud.sun.fill")
        case "03d", "03n":
            return Image(systemName: "cloud.sun.fill")
        case "04d", "04n":
            return Image(systemName: "cloud.fill")
        case "09d", "09n":
            return Image(systemName: "cloud.drizzle.fill")
        case "10d", "10n":
            return Image(systemName: "cloud.rain.fill")
        case "11d", "11n":
            return Image(systemName: "cloud.bolt.fill")
        case "13d", "13n":
            return Image(systemName: "cloud.snow.fill")
        case "50d", "50n":
            return Image(systemName: "cloud.fog.fill")
        default:
            return Image(systemName: "questionmark.circle")
        }
    }
}

