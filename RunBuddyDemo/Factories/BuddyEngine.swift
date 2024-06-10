//
//  BuddyEngine2.swift
//  RunBuddyDemo
//
//  Created by Wayne Bishop on 4/19/24.
//

import Foundation

import Foundation
import GoogleGenerativeAI


class BuddyEngine: ObservableObject {

    @Published var chunkResponse: String = ""

    init() {
     //default initalizer
    }
    
   private func newTextModel(with key: String) -> GenerativeModel {
        let model = GenerativeModel(name: "gemini-pro", apiKey: key)
        return model
    }
    
    
    func getGenerativeTextChunkAnswer(prompt: String, apiKey: String?) async throws -> () {
        
        //check for apiKey
        guard let key = apiKey else {
            throw GenerateContentError.invalidAPIKey(message: "error: invalid api key..")
        }

        let model = newTextModel(with: key)
        
        let prompt: String = prompt
        
        // Use streaming with text-only input
        let contentStream = model.generateContentStream(prompt)
                
        do {
            for try await chunk in contentStream {
                if let text = chunk.text {
                   // print(text)
                    
                    //update published property on main thread
                    DispatchQueue.main.async {
                        self.chunkResponse += text
                    }
                }
            }
        } //end do
        catch {
            //throw general exception
            print("something went wrong..")
            throw error
        }
        
    } //end function

    func generativeChunkChat(prompt: String, apiKey: String?) async throws -> () {
        
        let config = GenerationConfig(
          maxOutputTokens: 100
        )
        
        //check for apiKey
        guard let key = apiKey else {
            throw GenerateContentError.invalidAPIKey(message: "error: invalid api key..")
        }

        // For text-only input, use the gemini-pro model
        // Access your API key from your on-demand resource .plist file (see "Set up your API key" above)
        let model = GenerativeModel(
          name: "gemini-pro",
          apiKey: key,
          generationConfig: config
        )
        
        //this history could be loaded in via SwiftData
        let history = [
          ModelContent(role: "user", parts: "Hello, I have 2 dogs in my house."),
          ModelContent(role: "model", parts: "Great to meet you. What would you like to know?"),
        ]

        // Initialize the chat
        let chat = model.startChat(history: history)
        let response = try await chat.sendMessage("How many paws are in my house?")
        
        //latest revised interaction. To be saved to some persistent store.
        //let latestHistory = chat.history
        
        if let text = response.text {
          print(text)
        }
        
        //todo: this is where you would ask ask a second question about providing two
        //resonable related questions to ask based on the previously asked question.
        //this is similar to how LinkedIn works to create a circular model.
    }
    
} //end class
