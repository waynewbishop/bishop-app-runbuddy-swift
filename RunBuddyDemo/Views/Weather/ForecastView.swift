//
//  WeatherTest.swift
//  RunBuddyDemo
//
//  Created by Wayne Bishop on 5/29/24.
//

import SwiftUI
import CoreLocation
import Charts


//used for preview testing
extension CLLocationCoordinate2D {
    static let gigHarbor = CLLocationCoordinate2D(latitude: 47.64373, longitude: -122.17364)
    static let zionPark = CLLocationCoordinate2D(latitude: 37.1047193, longitude: -113.7286516)
}


struct ForecastView: View {
    
    @ObservedObject var engine = BuddyEngine()
    @StateObject var weatherEngine = WeatherEngine()
    
    @State var isAnimating: Bool = false
    @State var chartForecasts = [ChartForecast]()
    
    @State var location: CLLocationCoordinate2D
    @State var targetDate = ""
    @State var name = ""
    @State var distance = ""
    @State var terrain = ""
    @State var country = ""
    
    //access key from plist.
    private let apiKey: String? = BuddyConfig.geminiApiKey

    //present date in long string format
    var headingDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        guard let date = formatter.date(from: targetDate) else {
            return "Invalid Date"
        }
        
        formatter.dateFormat = "EEEE, MMMM d"
        return formatter.string(from: date)
    }
    
    
    var body: some View {
               
        VStack {
            VStack {
                Spacer()
            }
             VStack {
                Text(self.name)
                    .font(.title)
                weatherEngine.icon
                    .font(.system(size: 95, weight: .ultraLight))
                    .symbolRenderingMode(.multicolor)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color.gray.opacity(0.1))
                    )
            }
            .padding()
            
            VStack {
                if engine.chunkResponse != "" {
                    VStack {
                        HStack {
                            Text("Weather Analysis")
                                .font(.headline)
                            Spacer()
                        }
                        HStack {
                            Text(engine.chunkResponse)
                                .lineLimit(nil)
                            Spacer()
                            
                            // Text("This is a test..")
                        }
                    }
                    .padding(.horizontal)
                }
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
        }
        
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
        
        Spacer()
    }
    
    
    //invoke engine and receive response.
    private func askRunBuddyAndGetResponse(_ prompt: String) {
        
        Task {
            do {
                try await engine.getGenerativeTextChunkAnswer(prompt: prompt, apiKey: apiKey)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    private func weatherForecastData() {
        
        Task {
            do {
                let forecastResponse = try await weatherEngine.fetchFiveDayForecast(for: location)
                
                //check the location name
                let city = forecastResponse.city.name
                if self.name == "" {
                    self.name = city
                    self.country = forecastResponse.city.country
                }
                
                //process collection on the main thread
                DispatchQueue.main.async {
                   let targetForecasts = weatherEngine.filterHourlyForecasts(forecastResponse, targetDate: targetDate)
                    
                    if let forecasts = targetForecasts {
                        //print(forecasts)
                        
                        weatherEngine.createWeatherSummary(with: forecasts)
                         
                        //iterate through results
                        for forecast in forecasts {
                            let item = ChartForecast(dt: forecast.dt, temp: forecast.main.temp, feels_like: forecast.main.feels_like, temp_min: forecast.main.temp_min, temp_max: forecast.main.temp_max, humidity: forecast.main.humidity, pop: forecast.pop)
                            
                            chartForecasts.append(item)
                           //print(item)
                        }
                    }
                    
                    //build a new prompt for weather analysis
                    let prompt = Prompt()
                    let revisedPrompt = prompt.newWeatherPrompt(summary: weatherEngine.summary, location: location, distance: distance, targetDate: targetDate, terrain: terrain)
                    
                    //print(revisedPrompt)

                    self.askRunBuddyAndGetResponse(revisedPrompt)
                }
                
            } catch {
                print("Error: \(error)")
            }
        } //end task
    }    
}

#Preview {

    //provide test data..
    @State var targetDate = "2024-06-13"
    @State var summary = "Sun. High of 92 and low of 68. Wind gusts up to 8 mph."
    
    return VStack {
        ForecastView(location: .zionPark, targetDate: targetDate, name:"Zion National Park", distance: "3.1")
    }
}
