//
//  WeatherTest.swift
//  RunBuddyDemo
//
//  Created by Wayne Bishop on 5/29/24.
//

import SwiftUI
import CoreLocation
import Charts


struct ForecastView: View {
    
    @State var weatherEngine = WeatherEngine()
    @State var dailyForecasts = [Forecast]()
    
    //@State var location = CLLocationCoordinate2D(latitude: 37.1047193, longitude: -113.7286516)
    @State var location = CLLocationCoordinate2D(latitude: 47.33260, longitude: -122.680216)
    @State var targetDate = "2024-05-31"
    
    var body: some View {
        
        VStack {
            Chart {
                ForEach(dailyForecasts) { forecast in
                    LineMark (
                        x: .value("Hour", forecast.date, unit: .hour),
                        y: .value("Temp", forecast.temp)
                    )
                    .foregroundStyle(Color.blue.opacity(0.4))
                    
                    PointMark(
                        x: .value("Hour", forecast.date, unit: .hour),
                        y: .value("Temp", forecast.temp)
                    )
                    .foregroundStyle(Color.blue)
                    
                    AreaMark(
                        x: .value("Hour", forecast.date, unit: .hour),
                        y: .value("Humdity", forecast.humidity)
                    )
                    .foregroundStyle(Color.green.opacity(0.3))
                    
                }
                
            }
            .frame(height: 200)
            .padding()
            .chartYAxisLabel("Temperature/Humidity")
            
        }
        .onAppear() {
            self.weatherForecastData()
        }
        
        VStack (alignment: .leading, content: {
            Text("Weather Summary")
                .font(.headline)
            GroupBox () {
                Text("High of 65° and low of 45°. Feels like 57°. Wind gusts up to 14 mph. Chance of precipitation is 82%.")
            }
        })
        .padding()
        
    }
    
    
    private func weatherForecastData() {
        
        Task {
            do {
                let forecastResponse = try await weatherEngine.fetchFiveDayForecast(for: location)
                
                //process collection on the main thread
                DispatchQueue.main.async {
                   let targetForecasts = weatherEngine.filterHourlyForecasts(forecastResponse, targetDate: targetDate)
                    
                    if let forecasts = targetForecasts {
                        print(forecasts.count)
                        
                       //TODO: pass the collection to establish totals..
                        //pass back a single string as a @Binding..
                        
                        //iterate through results
                        for forecast in forecasts {
                            let item = Forecast(dt: forecast.dt, temp: forecast.main.temp, feels_like: forecast.main.feels_like, temp_min: forecast.main.temp_min, temp_max: forecast.main.temp_max, humidity: forecast.main.humidity, weather_main: forecast.weather[0].main, weather_description: forecast.weather[0].description, weather_icon: forecast.weather[0].icon, wind: forecast.wind.gust, pop: forecast.pop)
                            
                            dailyForecasts.append(item)
                           print(item)
                        }
                    }
                }
                
            } catch {
                print("Error: \(error)")
            }
        } //end task
    }
    
}

#Preview {
    ForecastView()
}
