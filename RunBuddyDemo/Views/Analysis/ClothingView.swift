//
//  ClothingView.swift
//  RunBuddyDemo
//
//  Created by Wayne Bishop on 8/6/24.
//

import SwiftUI

struct ClothingView: View {
    
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
                            AnalysisImage(imageColor: Color.blue, imageName: "hanger")
                        }
                    }
                    .frame(height: 90)
                    HStack {
                        Text("Clothing Analysis")
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
            }
        }
        
        //the onchange event waits for changes
        .onChange(of: chartForecasts) { oldValue, newValue in
            if !chartForecasts.isEmpty {
                //print("chartForecasts updated: \(chartForecasts)")
              //  self.getNutritionAnalysis()
                self.clothingAnalysis()
            }
        }
        .padding(.bottom)
       
        /* for testing only
        .onAppear(perform: {
            print("chartForecasts updated..")
            //#error("Error: onAppear section should not be compiled. Comment it out before building.")
            //self.getNutritionAnalysis()
            //clothingAnalysis()
        })        
        */
    }
   
    
   private func clothingAnalysis() {
            
        //build out and send prompt
        let prompt = Prompt()
       let finalPrompt = prompt.promptClothing(weather: chartForecasts, location: question.location, city: question.city, intensity: question.intensity, terrain: question.terrain, duration: question.duration)
        
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
    @State var chartForecasts = ChartForecast.generateTestData()
    let apiKey: String? = BuddyConfig.geminiApiKey

    @State var previewQuestion = Question(city: "Zion Park", location: .gigHarbor, duration: "30 minutes", selectedDate: selectedDate.advanceDays(by: 1), intensity: "Threshold", terrain: "Road", nutrition: false, kit: false)
    
    return VStack {
        ClothingView(chartForecasts: $chartForecasts, question: previewQuestion, apiKey: apiKey)
    }
    
    
}
