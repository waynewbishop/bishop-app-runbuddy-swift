//
//  ContentView2.swift
//  RunBuddyDemo
//
//  Created by Wayne Bishop on 4/19/24.
//

import Foundation

import SwiftUI
import GoogleGenerativeAI

struct ContentView2: View {
    
@State private var userPrompt: String = ""
@ObservedObject var engine = BuddyEngine2()
    
private var rotatingStarView = RotatingStarView(color: .orange, size: 25, duration: 1.0, degrees: 45)

    
private let apiKey: String? = "AIzaSyBjMts2i3xOTtfATk7ZfUBshUUlv6QQuDU"

    var body: some View {
        HStack {
            VStack {
                
                HStack {
                    rotatingStarView
                    TextField("Ask a question..", text: $userPrompt,
                        onCommit: {
                                              
                         Task {
                            //TODO: this is where we would call OpenWeatherAPI
                           do {
                               try await engine.getGenerativeTextChunkAnswer(prompt: .promptNewRunner, apiKey: apiKey)
                               
                           } catch {
                             print(error.localizedDescription)
                           }
                         }
                      }) //question textfield
                     .frame(minHeight: 20) // Sets a minimum height to prevent collapse
                 .padding(15)
                } //end hstack
                
                TextField("Waiting for an answer..", text: $engine.chunkResponse, axis: .vertical)
                    .frame(minHeight: 20) // Sets a minimum height to prevent collapse
                    .padding(15)
                    .background(.gray.opacity(0.1))
                    .cornerRadius(8)
                    .foregroundColor(.primary)
            }
 
        }
        .padding()
    }
}


#Preview {
    ContentView2()
}

