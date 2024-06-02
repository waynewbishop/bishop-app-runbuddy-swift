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
    
    @StateObject var weatherEngine = WeatherEngine()
    @State var chartForecasts = [ChartForecast]()
    
    //47.9630579,-122.0994235
    
    @State var location = CLLocationCoordinate2D(latitude: 47.9630579, longitude: -122.0994235)
   // @State var location = CLLocationCoordinate2D(latitude: 37.1047193, longitude: -113.7286516)
    //@State var location = CLLocationCoordinate2D(latitude: 47.33260, longitude: -122.680216)
    //@State var location = CLLocationCoordinate2D(latitude: 44.9509, longitude: -120.7289)
    @State var targetDate = "2024-06-03"
    
    var body: some View {
        
        VStack {
            Chart {
                ForEach(chartForecasts) { forecast in
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
                    .foregroundStyle(Color.green.opacity(0.2))
                }
            }
            .frame(height: 225)
            .padding()
            .chartYAxisLabel("Temperature / Humidity")
            
        }
        .onAppear() {
            self.weatherForecastData()
        }
        
        if weatherEngine.summary != "" {
            VStack (alignment: .leading, content: {
                HStack {
                    Text("Weather Summary")
                        .font(.headline)
                    weatherEngine.icon
                        //.symbolRenderingMode(.multicolor)
                 }
                GroupBox () {
                Text(weatherEngine.summary)
                }
            })
            .padding()
        }
    }
    
    
    private func weatherForecastData() {
        
        Task {
            do {
                let forecastResponse = try await weatherEngine.fetchFiveDayForecast(for: location)
                
                //process collection on the main thread
                DispatchQueue.main.async {
                   let targetForecasts = weatherEngine.filterHourlyForecasts(forecastResponse, targetDate: targetDate)
                    
                    if let forecasts = targetForecasts {
                        //print(forecasts.count)
                        
                        weatherEngine.createWeatherSummary(with: forecasts)
                         
                        //iterate through results
                        for forecast in forecasts {
                            let item = ChartForecast(dt: forecast.dt, temp: forecast.main.temp, feels_like: forecast.main.feels_like, temp_min: forecast.main.temp_min, temp_max: forecast.main.temp_max, humidity: forecast.main.humidity, pop: forecast.pop)
                            
                            chartForecasts.append(item)
                           //print(item)
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
