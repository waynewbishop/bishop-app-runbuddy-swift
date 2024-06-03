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
    
    @State var location: CLLocationCoordinate2D
    @State var targetDate = "2024-06-04"
    
   // @State var location = CLLocationCoordinate2D(latitude: 37.1047193, longitude: -113.7286516)
   // @State var location = CLLocationCoordinate2D(latitude: 47.33260, longitude: -122.680216)
   // @State var location = CLLocationCoordinate2D(latitude: 44.9509, longitude: -120.7289)

    
    var body: some View {
        
        if weatherEngine.summary != "" {
            VStack (alignment: .leading, content: {
                HStack {
                    weatherEngine.icon
                        .imageScale(.large)
                    Text("Sunday, June 2 - Bridle Trails Park")
                        .font(.headline)
                 }
                GroupBox () {
                    Text(weatherEngine.summary)
                }
            })
            .padding()
        }
        
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
        
        HStack {
            Text("Percent Precipitation")
                .font(.headline)
            Spacer()
        }
        .padding()
        
        
        //provide a bar chart for precipitation
        VStack {
            Chart {
                ForEach(chartForecasts) { forecast in
                    BarMark(
                        x: .value("Hour", forecast.date, unit: .hour),
                        y: .value("Percent Precipitation", forecast.pop * 100)
                    )
                    .foregroundStyle(Color.orange.opacity(0.4))
                }
            }
        }
        .frame(height: 150)
        .padding()
        .chartYAxisLabel("Percent Precipitation")
        
        
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

    //provide test data..
    @State var location = CLLocationCoordinate2D(latitude: 47.64373, longitude: -122.17364)
    @State var targetDate = "2024-06-04"
    
    return VStack {
        ForecastView(location: location, targetDate: targetDate)
    }
}
