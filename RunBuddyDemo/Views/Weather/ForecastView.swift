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
    
    @State var targetForecasts: [ForecastData]?
    @State var weatherEngine = WeatherEngine()
    
    //these values will be overriden
    @State var location = CLLocationCoordinate2D(latitude: 38.0832, longitude: -122.7282)
    @State var targetDate = "2024-06-01"
    
    let dailySales: [(day: Date, sales: Int)] = [
        (day: Date(), sales: 45),
        (day: Date() + 1, sales: 64),
        (day: Date() + 3, sales: 86)
    ]
    
    var body: some View {
        
        VStack {
            Chart {
                ForEach(dailySales, id: \.day) {
                    LineMark(
                        x: .value("Day", $0.day, unit: .day),
                        y: .value("Sales", $0.sales)
                    )
                }
            }
            .frame(height: 150)
            .padding()
        }
        .onAppear() {
            //self.weatherForecastData()
        }
        
        VStack (alignment: .leading, content: {
            Text("Summary")
                .font(.headline)
            GroupBox () {
                Text("High of 65° and low of 45°. Feels 57. Wind gusts up to 14 mph.")
                    
            }
        })
        
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
                        
                        //this is where we convert data from the
                        //targetForecasts collection to a denormalized struct
                        //that can be handled by Swift charts. High, Low and
                        //target temps for each day. We also want the chart to
                        //include a legend.
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
