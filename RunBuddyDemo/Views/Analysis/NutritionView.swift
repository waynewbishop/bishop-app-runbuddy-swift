//
//  NutritionView.swift
//  RunBuddyDemo
//
//  Created by Wayne Bishop on 7/1/24.
//

import SwiftUI

struct NutritionView: View {
    
    @StateObject var engine = BuddyEngine()
    
    @Binding var chartForecasts: [ChartForecast]
    @State var question: Question
    @State var apiKey: String?
    
    var targetDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: question.selectedDate)
    }
    
    
    var body: some View {
        VStack {
            //if engine.chunkResponse != "" {
                VStack {
                    HStack {
                        Image(systemName: "figure.run")
                            .font(.system(size: 30, weight: .regular))
                            .foregroundStyle(.white)
                            .background(
                                Circle()
                                    .fill(Color.green.opacity(0.5))
                                    .frame(width: 55, height: 70)
                            )
                        Spacer()
                               .frame(width: 80) // Adjust this value as needed
                        Image(systemName: "signpost.right.and.left")
                            .font(.system(size: 30, weight: .regular))
                            .foregroundStyle(.white)
                            .background(
                                Circle()
                                    .fill(Color.green.opacity(0.5))
                                    .frame(width: 55, height: 70)
                            )
                    }
                    .padding()
                    HStack {
                        Text("Nutrition Analysis")
                            .font(.headline)
                        Spacer()
                    }
                    HStack {
                        Text(engine.chunkResponse)
                            .lineLimit(nil)
                        Spacer()
                    }
                }
                .padding(.horizontal)
            //}
        }
        //the onchange event waits for changes
        .onChange(of: chartForecasts) { oldValue, newValue in
            if !chartForecasts.isEmpty {
                //print("chartForecasts updated: \(chartForecasts)")
                self.getNutritionAnalysis()
            }
        }
        .padding(.bottom)
    }
   

    //obtain the nutritional analysis
    private func getNutritionAnalysis() {

        //build out prompt
        let prompt = Prompt()
        let finalPrompt = prompt.promptNutrition(weather: chartForecasts, location: question.location, city: question.city, intensity: question.intensity, duration: question.duration)
        
        Task {
            do {
                try await engine.getGenerativeTextChunkAnswer(prompt: finalPrompt, apiKey: apiKey)
            } catch {
                print(error.localizedDescription)
            }
        }
        
    }
        
}

#Preview {
        
    @State var selectedDate = Date()
    @State var chartForecasts = [ChartForecast]()
    let apiKey: String? = BuddyConfig.geminiApiKey

    @State var previewQuestion = Question(city: "Gig Harbor", location: .gigHarbor, duration: "30 minutes", selectedDate: selectedDate.advanceDays(by: 1), intensity: "Easy", terrainOption: "Road", nutrition: false, kit: false)
    
    return VStack {
        NutritionView(chartForecasts: $chartForecasts, question: previewQuestion, apiKey: apiKey)
    }
    
}
