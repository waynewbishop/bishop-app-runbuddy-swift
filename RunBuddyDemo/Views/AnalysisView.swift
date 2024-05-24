//
//  AnalysisView.swift
//  RunBuddyDemo
//
//  Created by Wayne Bishop on 5/24/24.
//

import SwiftUI

struct AnalysisView: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        
        Button("Check the weather forecast..") {
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
            } //end task
        }
    }
}

#Preview {
    AnalysisView()
}
