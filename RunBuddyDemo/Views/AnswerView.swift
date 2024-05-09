//
//  ContentView2.swift
//  RunBuddyDemo
//
//  Created by Wayne Bishop on 4/19/24.
//

import Foundation

import SwiftUI
import GoogleGenerativeAI

struct AnswerView: View {
    
@ObservedObject var engine = BuddyEngine()
@State var isAnimating: Bool = false
@State var showGroupBox = false

//access key from plist.
private let apiKey: String? = BuddyConfig.apiKey

    var body: some View {
        HStack {
            VStack {
                HStack {
                    EllipsisView(isGenerating: $isAnimating)
                                        
                    Button("Ask RunBuddy..") {
                        
                        //reset interface elements..
                        isAnimating = true
                        engine.chunkResponse = ""
                        showGroupBox = false
                        
                        Task {
                          do {
                              try await engine.getGenerativeTextChunkAnswer(prompt: .prompt10MileSample, apiKey: apiKey)
                              
                          } catch {
                            print(error.localizedDescription)
                            isAnimating = false
                          }
                        }
                    }
                 .padding(5)
                } //end hstack
                
                //TODO: can I place the entire TextField in
                //conditional if statement for engine.chunkResponse?
                
                TextField("", text: $engine.chunkResponse, axis: .vertical)
                    .frame(minHeight: 20) // Sets a minimum height to prevent collapse
                    .buddyFieldStyle()
                    .disabled(true) // Disables user interaction
                    .onChange(of: engine.chunkResponse) { oldValue, newValue in
                        isAnimating = false
                        if newValue != "" { //replace with single line if statement.
                            showGroupBox = true
                        }
                        else {
                            showGroupBox = false
                        }
                    }
        
                if showGroupBox {
                    ThumbsView()
               }
            }
            
        }
        .padding()
        Spacer()
    }
}


#Preview {
    @State var showGroupBox: Bool = false
    return VStack {
        AnswerView(showGroupBox: showGroupBox)
    }
}

