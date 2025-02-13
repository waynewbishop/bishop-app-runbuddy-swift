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
            if engine.chunkResponse != "" {
                VStack {
                    HStack {
                        VStack {
                            AnalysisImage(imageColor: Color.green, imageName: "waterbottle")
                            Text("Duration: \(question.duration)")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                               // .fontWeight(.bold)
                        }
                       
                    }
                    .frame(height: 120)
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
                    Spacer().frame(height: 10) // Adjust the height as needed
                    HStack {
                        Text("Recommendations obtained from the running community and should not be considered medical advice.")
                            .font(.caption)
                            .foregroundStyle(.gray).opacity(0.6)
                        Spacer()
                    }
                }
                .padding(.horizontal)
            }
        }
        
        //the onchange event waits for changes
        .onChange(of: chartForecasts) { oldValue, newValue in
            if !chartForecasts.isEmpty {
                //print("chartForecasts updated: \(chartForecasts)")
                self.nutritionAnalaysis()
            }
        }
        .padding(.bottom)
       
        /* for testing only
        .onAppear(perform: {
            //#error("Error: onAppear section should not be compiled. Comment it out before building.")
            self.nutritionAnalaysis()
        })
        */
               
    }
   

    //obtain the nutritional analysis
    private func nutritionAnalaysis() {

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

    @Previewable @State var chartForecasts = ChartForecast.generateTestData()
    @Previewable @State var previewQuestion = Question(city: "Zion Park", location: .bouldersCreekPath, duration: "30-60 minutes", selectedDate: Date().advanceDays(by: 1), intensity: "Threshold", terrain: "Road", nutrition: false, kit: false)
    
    let apiKey: String? = BuddyConfig.geminiApiKey
    
    return VStack {
        NutritionView(chartForecasts: $chartForecasts, question: previewQuestion, apiKey: apiKey)
    }

    
}
