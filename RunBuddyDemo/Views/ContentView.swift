//
//  ContentView.swift
//  RunBuddyDemo
//
//  Created by Wayne Bishop on 4/10/24.
//

import SwiftUI
import GoogleGenerativeAI

struct ContentView: View {
    
@State private var userPrompt: String = ""
@State private var answer: String = ""
    
private let apiKey: String? = "AIzaSyBjMts2i3xOTtfATk7ZfUBshUUlv6QQuDU"

    var body: some View {
        HStack {
            VStack {
                 TextField("Ask a question..", text: $userPrompt,
                    onCommit: {
                     
                     //TODO: Move this key checking code to BuddyEngine..
                                        
                     //check for the api key
                     guard let key = apiKey else {
                         print("error: no api key initialization present..")
                         return
                     }
                                              
                     //initialize engine
                     //TODO: Just refactor so that BuddyEngine has no initializers. Dumb but whatever..
                     //set the apikey as a public property of BuddyEngine and just check it whenever I have to access a function..
                     //Move this code to line 15 in this model..
                     let engine: BuddyEngine = BuddyEngine(key)
                     
                     Task {
                       do {
                           //create story question
                           let summary = try await engine.getGenerativeTextStreamAnswer(prompt: "Will it rain on Tuesday?")
                        
                           //reassign the answer to a binding..
                           if let result = summary {
                               answer = result
                           }
                           
                       } catch {
                         print(error.localizedDescription)
                         // Handle errors here (e.g., display an error message to the user)
                       }
                     }
                  }) //Textfield
                
                TextField("Waiting for an answer..", text: $answer, axis: .vertical)
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
    ContentView()
}

