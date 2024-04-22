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
    
private let apiKey: String? = "AIzaSyBjMts2i3xOTtfATk7ZfUBshUUlv6QQuDU"

    var body: some View {
        HStack {
            VStack {
                 TextField("Ask a question..", text: $userPrompt,
                    onCommit: {
                                          
                     Task {
                         
                         //TODO: This is where we go through the complex process of building out the prompt based on the information provided. This included accessing OpenweatherAPI as another background task
                         
                       do {
                           //TODO: pass default prompt to the AI engine. Easier for testing..
                           try await engine.getGenerativeTextChunkAnswer(prompt: .promptNewRunner, apiKey: apiKey)
                           
                       } catch {
                         print(error.localizedDescription)
                         // Handle errors here (e.g., display an error message to the user)
                       }
                     }
                  }) //Textfield
                
                TextField("Waiting for an answer..", text: $engine.chunkResponse, axis: .vertical)
                    .frame(minHeight: 30) // Sets a minimum height to prevent collapse
                    .padding(15)
                    .background(.gray.opacity(0.1))
                    .cornerRadius(8)
                    .foregroundColor(.primary)
            }
            .padding(.vertical, 10)
        }
        .padding()
    }
}


#Preview {
    ContentView2()
}

