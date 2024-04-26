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
@State var isAnimating: Bool = false
    
private let apiKey: String? = "AIzaSyBjMts2i3xOTtfATk7ZfUBshUUlv6QQuDU"

    var body: some View {
        HStack {
            VStack {
                HStack {
                    AnimateTest(isGenerating: $isAnimating)
                    
                    TextField("Ask a question..", text: $userPrompt,
                        onCommit: {
                        
                         //start thinking process
                         isAnimating = true
                        
                         Task {
                           do {
                               try await engine.getGenerativeTextChunkAnswer(prompt: .prompt10MileSample, apiKey: apiKey)
                               
                           } catch {
                             print(error.localizedDescription)
                             isAnimating = false
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
                
                //TODO: is there an onChange event for the
                //Texfield where I can stop the animation?
                //or I can monitor the change in the chunkResponse
                //data? 
            }
 
        }
        .padding()
    }
}


#Preview {
    ContentView2()
}

