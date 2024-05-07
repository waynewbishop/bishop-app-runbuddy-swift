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
    
private let apiKey: String? = "AIzaSyBjMts2i3xOTtfATk7ZfUBshUUlv6QQuDU"
private let claudeKey: String? = "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"

    var body: some View {
        HStack {
            VStack {
                HStack {
                    EllipsisView(isGenerating: $isAnimating)
                                        
                    Button("Ask RunBuddy..") {
                        //intiate thinking animation
                        isAnimating = true
                        
                        Task {
                          do {
                              try await engine.getGenerativeTextChunkAnswer(prompt: .promptTrailRace, apiKey: apiKey)
                              
                          } catch {
                            print(error.localizedDescription)
                            isAnimating = false
                          }
                        }
                    }
                 .padding(5)
                } //end hstack
                
                TextField("Waiting for an answer..", text: $engine.chunkResponse, axis: .vertical)
                    .frame(minHeight: 20) // Sets a minimum height to prevent collapse
                    .buddyFieldStyle()
                    .disabled(true) // Disables user interaction
                    .onChange(of: engine.chunkResponse) { oldValue, newValue in
                        isAnimating = false
                    }
            }
 
        }
        .padding()
    }
}


#Preview {
    AnswerView()
}

